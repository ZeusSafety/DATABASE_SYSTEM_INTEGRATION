--
-- PROCEDIMIENTO PARA GESTIONAR INGRESOS, SALIDAS Y RESERVAS
--
DROP PROCEDURE IF EXISTS SP_GestionarMovimientoStock;
DELIMITER //
CREATE PROCEDURE SP_GestionarMovimientoStock (
    IN p_id_producto INT,
    IN p_responsable VARCHAR(50),
    IN p_cantidad_ingreso INT,
    IN p_cantidad_salida INT,
    IN p_cantidad_reserva INT,
    IN p_motivo TEXT,
    IN p_unidad_medida VARCHAR(20)
)
BEGIN
    DECLARE v_stock_actual INT;
    DECLARE v_nueva_cantidad INT;
    DECLARE v_producto_nombre VARCHAR(60);
    DECLARE v_categoria VARCHAR(40);
    DECLARE v_id_historial_insertado INT;

    -- Inicio de la transacción para asegurar atomicidad
    START TRANSACTION;

    -- 1. Obtener datos y stock actual del producto
    SELECT 
        CANTIDAD_CAJAS, NOMBRE, CATEGORIA
    INTO 
        v_stock_actual, v_producto_nombre, v_categoria
    FROM 
        productos
    WHERE 
        ID = p_id_producto
    FOR UPDATE; -- Bloqueo de fila para evitar condiciones de carrera

    -- Si no existe el producto o el stock es insuficiente para salidas/reservas
    IF v_stock_actual IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no encontrado.';
    END IF;

    -- Calcular el nuevo stock
    SET v_nueva_cantidad = v_stock_actual + p_cantidad_ingreso - p_cantidad_salida - p_cantidad_reserva;

    -- Validación: No permitir stock negativo
    IF v_nueva_cantidad < 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente para esta operación.';
    END IF;

    -- 2. Actualizar el stock principal (STOCK_DESCUENTO_CAJAS_MV)
    UPDATE productos
    SET CANTIDAD_CAJAS = v_nueva_cantidad
    WHERE ID = p_id_producto;

    -- 3. Insertar registro en HISTORIAL_CAMBIOS_STOCK_CAJAS_MV
    INSERT INTO historial_cambios_stock (
        responsable, fecha_hora, id_producto, producto, categoria,
        cantidad_ingreso, cantidad_salida, cantidad_reservada, motivo, cantidad_cajas_final
    ) VALUES (
        p_responsable, NOW(), p_id_producto, v_producto_nombre, v_categoria,
        p_cantidad_ingreso, p_cantidad_salida, p_cantidad_reserva, p_motivo, v_nueva_cantidad
    );

    -- Obtener el ID del historial recién insertado
    SET v_id_historial_insertado = LAST_INSERT_ID();

    -- 4. Si es una RESERVA, insertar registro en PRODUCTOS_RESERVADOS_STOCK_CAJAS_MV
    IF p_cantidad_reserva > 0 THEN
        INSERT INTO productos_reservados (
            id_historial, id_producto, producto, categoria, fecha_hora, 
            responsable, cantidad_reservada, unidad_medida
        ) VALUES (
            v_id_historial_insertado, p_id_producto, v_producto_nombre, v_categoria, NOW(),
            p_responsable, p_cantidad_reserva, p_unidad_medida
        );
    END IF;

    -- Confirmar todos los cambios
    COMMIT;
    
    -- Devolver el ID_HISTORIAL y el nuevo stock para la actualización del frontend
    SELECT v_id_historial_insertado AS ID_HISTORIAL, v_nueva_cantidad AS NUEVO_STOCK;
END //
DELIMITER ;
--
-- PRUEBAS
--
Select * from colaboradores;

CALL SP_GestionarMovimientoStock (
    1,            -- p_id_producto
    'GAA',        -- p_responsable
    0,             -- p_cantidad_ingreso (20)
    0,              -- p_cantidad_salida (0)
    2,              -- p_cantidad_reserva (0)
    'GXDDD', -- p_motivo
    'CAJAS'         -- p_unidad_medida (no se usa en ingreso, pero se pasa)
);
--
SELECT * FROM productos;
SELECT * FROM historial_cambios_stock;
SELECT * FROM productos_reservados;
--
-- CONSULTAR DE LAS NOTIFICACIONES (ULTIMOS 5 CAMBIOS REGISTRADOS)
--
SELECT
    RESPONSABLE,
    FECHA_HORA,
    PRODUCTO,
    CATEGORIA,
    (CASE 
        WHEN CANTIDAD_INGRESO > 0 THEN 'INGRESO'
        WHEN CANTIDAD_SALIDA > 0 THEN 'SALIDA'
        WHEN CANTIDAD_RESERVADA > 0 THEN 'RESERVA'
        ELSE 'OTRO' 
    END) AS ACCION_REALIZADA,
    CANTIDAD_CAJAS_FINAL AS 'CANTIDAD FINAL',
    MOTIVO
FROM
    historial_cambios_stock
ORDER BY
    ID_HISTORIAL DESC
LIMIT 5;
--
-- #####################################################
--
--
-- PROCEDIMIENTO PARA GESTIONAR LA RESERVA (RETIRAR O REGRESAR)
--
ALTER TABLE productos_reservados ADD COLUMN estado_reserva VARCHAR(10) DEFAULT 'ACTIVA';
--
DROP PROCEDURE IF EXISTS SP_GestionarReserva;
DELIMITER //
CREATE PROCEDURE SP_GestionarReserva (
    IN p_id_reservados INT,
    IN p_responsable VARCHAR(50),
    IN p_cantidad_gestionada INT,
    IN p_es_regreso BOOLEAN, -- TRUE si regresa a stock, FALSE si se retira para venta/uso
    IN p_motivo TEXT,
    IN p_unidad_medida VARCHAR(20) -- Aunque se usa para registro, la lógica es sobre cajas reservadas
)
BEGIN
    DECLARE v_id_producto INT;
    DECLARE v_stock_reservado INT;
    DECLARE v_producto_nombre VARCHAR(60);
    DECLARE v_categoria VARCHAR(40);
    DECLARE v_nuevo_stock_reservado INT;

    START TRANSACTION;

    -- 1. Obtener datos de la reserva y bloquear la fila
    SELECT 
        pr.id_producto, pr.cantidad_reservada, pr.producto, pr.categoria
    INTO 
        v_id_producto, v_stock_reservado, v_producto_nombre, v_categoria
    FROM 
        productos_reservados pr
    WHERE 
        pr.id_reservados = p_id_reservados
    FOR UPDATE; 

    -- Validación de existencia y stock
    IF v_stock_reservado IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Reserva no encontrada.';
    END IF;

    IF p_cantidad_gestionada > v_stock_reservado THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad gestionada excede la cantidad reservada.';
    END IF;

   -- Calcular nuevo stock reservado
    SET v_nuevo_stock_reservado = v_stock_reservado - p_cantidad_gestionada;
    
    -- Validación: No permitir stock negativo (por si acaso)
    IF v_nuevo_stock_reservado < 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El movimiento intenta dejar la reserva con stock negativo.';
    END IF;
    
    -- 2. Actualizar la cantidad en PRODUCTOS_RESERVADOS_STOCK_CAJAS_MV
    UPDATE productos_reservados
    SET 
        cantidad_reservada = v_nuevo_stock_reservado,
        -- Actualización del estado (ACTIVA -> COMPLETADA)
        estado_reserva = CASE WHEN v_nuevo_stock_reservado = 0 THEN 'COMPLETADA' ELSE 'ACTIVA' END
    WHERE id_reservados = p_id_reservados;

    -- 3. Si es un REGRESO (p_es_regreso = TRUE), devolver al stock principal
    IF p_es_regreso THEN
        UPDATE productos
        SET CANTIDAD_CAJAS = CANTIDAD_CAJAS + p_cantidad_gestionada
        WHERE ID = v_id_producto;
    END IF;

    -- 5. Insertar registro en HISTORIAL_CAMBIOS_STOCK_PRODUCTOS_RESERVADOS_MV
    INSERT INTO historial_cambios_productos_reservados (
        id_reservados, id_producto, producto, categoria, responsable, 
        cantidad_salida_reserva, cantidad_regreso, motivo_actualizacion_hc, fecha_hora_actualizacion_hc
    ) VALUES (
        p_id_reservados, v_id_producto, v_producto_nombre, v_categoria, p_responsable,
        CASE WHEN p_es_regreso THEN 0 ELSE p_cantidad_gestionada END, -- G: Cantidad Salida (si no es regreso)
        CASE WHEN p_es_regreso THEN p_cantidad_gestionada ELSE 0 END, -- H: Cantidad Regreso (si es regreso)
        p_motivo, NOW()
    );

    COMMIT;
END //
DELIMITER ;
--
SELECT * FROM productos;
SELECT * FROM historial_cambios_stock;
SELECT * FROM productos_reservados;
SELECT * FROM historial_cambios_productos_reservados;
--
CALL SP_GestionarReserva (
    1,             -- p_id_reservados (ID de la reserva activa)
    'EDGAR',     -- p_responsable
    1,              -- p_cantidad_gestionada
    false,          -- p_es_regreso (FALSE: es un Retiro/Salida de reserva - TRUE: es regresar cantidad al stock)
    'venta al stock', -- p_motivo
    'CAJAS'         -- p_unidad_medida
);
--
-- Consulta para la SECCIÓN DE “PRODUCTOS RESERVADOS” - (TABLA PRODUCTOS RESERVADOS)
--
SELECT
    ID_RESERVADOS,
    PRODUCTO,
    CATEGORIA,
    FECHA_HORA AS 'Fecha y hora de reserva',
    RESPONSABLE,
    CANTIDAD_RESERVADA,
    UNIDAD_MEDIDA
FROM
    productos_reservados
WHERE	
    CANTIDAD_RESERVADA > 0 -- Solo mostrar reservas activas
ORDER BY
    FECHA_HORA DESC;
--
-- Consulta para las NOTIFICACIONES DE RESERVAS (LOS 5 ULTIMOS CAMBIOS REALIZADOS EN PRODUCTOS RESERVADOS)
--
SELECT
    PRODUCTO,
    CATEGORIA,
    (CASE
        WHEN CANTIDAD_REGRESO > 0 THEN 'REGRESO A STOCK'
        WHEN CANTIDAD_SALIDA_RESERVA > 0 THEN 'RETIRO DE RESERVA'
        ELSE 'ACTUALIZACIÓN'
    END) AS ACCION_REALIZADA,
    RESPONSABLE,
    FECHA_HORA_ACTUALIZACION_HC
FROM
    historial_cambios_productos_reservados
ORDER BY
    ID_HISTORIAL_RESERVADOS DESC
LIMIT 5;
--
-- #####################################################
--
-- 
-- PROCEDIMIENTOS ALMACENADOS PARA ACTUALIZACION DE LOGISTICA
--
DROP PROCEDURE IF EXISTS SP_ActualizarLogisticaStock;
DELIMITER //
CREATE PROCEDURE SP_ActualizarLogisticaStock (
    IN p_id_producto INT,
    IN p_nuevo_limite INT,
    IN p_nueva_cantidad INT, 
    IN p_nueva_unidad_medida VARCHAR(20),
    IN p_responsable VARCHAR(50),
    IN p_motivo TEXT
)
BEGIN
DECLARE v_cantidad_cajas_anterior INT;
DECLARE v_producto_nombre VARCHAR(60);
DECLARE v_categoria VARCHAR(40);

START TRANSACTION;

-- 1. Obtener datos actuales del producto y bloquear la fila
SELECT
 CANTIDAD_CAJAS, NOMBRE, CATEGORIA
INTO
v_cantidad_cajas_anterior, v_producto_nombre, v_categoria
FROM
productos
WHERE
ID = p_id_producto
FOR UPDATE;

-- Validación de existencia
IF v_producto_nombre IS NULL THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no encontrado para la actualización logística.';
END IF;

    --  2. AÑADIR VERIFICACIÓN DE CAMBIO 
    IF p_nueva_cantidad <> v_cantidad_cajas_anterior OR p_nuevo_limite IS NOT NULL OR p_nueva_unidad_medida IS NOT NULL THEN
        
        -- 3. Actualizar la tabla principal de productos (Solo si hay cambio en cantidad o en los otros campos opcionales)
        UPDATE productos
        SET LIMITE_DESCUENTO_CAJAS = COALESCE(p_nuevo_limite, LIMITE_DESCUENTO_CAJAS),
        CANTIDAD_CAJAS = p_nueva_cantidad,
        UNIDAD_MEDIDA_CAJAS = COALESCE(p_nueva_unidad_medida, UNIDAD_MEDIDA_CAJAS)
        WHERE
        ID = p_id_producto;

        -- 4. Registrar el cambio en la tabla de Log (Solo si hay cambio en cantidad)
        IF p_nueva_cantidad <> v_cantidad_cajas_anterior THEN
            INSERT INTO actualizacion_logistica_stock (
                responsable,
                fecha_hora_logistica, 
                id_producto,
                producto,
                categoria,
                cantidad_cajas,
                cantidad_actual,
                motivo
            ) VALUES (
                p_responsable,
                NOW(),
                p_id_producto,
                v_producto_nombre,
                v_categoria,
                v_cantidad_cajas_anterior,
                p_nueva_cantidad,
                p_motivo
            );
        END IF;

    END IF; 

   COMMIT;
END //
DELIMITER ;
--
select * from colaboradores;
SELECT * FROM productos;
SELECT * FROM actualizacion_logistica_stock;
--
CALL SP_ActualizarLogisticaStock (
    1,                   -- p_id_producto
    25,                  -- p_nuevo_limite
    30,                 -- p_nueva_cantidad
    'CAJAS',               -- p_nueva_unidad_medida
    'AUDITORIA_LOGISTICA', -- p_responsable
    'Ajuste por diferencia de conteo físico mensual' -- p_motivo
);

ALTER TABLE actualizacion_logistica_stock
MODIFY COLUMN fecha_hora_logistica DATETIME NOT NULL;


ALTER TABLE actualizacion_logistica_stock
MODIFY COLUMN cantidad_cajas INT NOT NULL COMMENT 'Cantidad antes de actualizar',
MODIFY COLUMN cantidad_actual INT NOT NULL COMMENT 'Cantidad después de actualizar';


--
-- CONSULTA SELECT PARA LA GENERACION DEL PDF APPSCRIPT/PYTHON
--
SELECT 
	ID AS ID_PRODUCTO, 
	CODIGO AS CODIGO_PRODUCTO, 
	NOMBRE AS PRODUCTO, 
	LIMITE_DESCUENTO_CAJAS, 
	CATEGORIA, 
	CANTIDAD_CAJAS, 
	UNIDAD_MEDIDA_CAJAS, 
	CATEGORIA_GUANTES
FROM productos
WHERE ESTADO = '1';
--
select * FROM productos;
--
-- #####################################################
--

--
-- Procediminto para obtener el historial stock general 
--
DELIMITER //
CREATE PROCEDURE ObtenerHistorialStockGeneral()
BEGIN
    SELECT
        hcs.id_historial,
        hcs.responsable,
        hcs.fecha_hora,
        hcs.producto,
        hcs.categoria,
        -- Cálculo del Stock Inicial: Es la cantidad_cajas_final del registro
        -- menos la cantidad_ingreso, más la cantidad_salida, más la cantidad_reservada.
        (hcs.cantidad_cajas_final - hcs.cantidad_ingreso + hcs.cantidad_salida + hcs.cantidad_reservada) AS stock_inicial,
        hcs.cantidad_salida,
        hcs.cantidad_reservada,
        hcs.motivo,
        CASE
            WHEN hcs.cantidad_ingreso > 0 THEN 'INGRESO'
            WHEN hcs.cantidad_salida > 0 THEN 'SALIDA'
            WHEN hcs.cantidad_reservada > 0 THEN 'RESERVA'
            ELSE 'OTRO' -- En caso de que se haya modificado el motivo sin afectar cantidades
        END AS tipo_accion
    FROM
        historial_cambios_stock hcs
    ORDER BY
        hcs.fecha_hora DESC;
END //
DELIMITER ;
--
CALL ObtenerHistorialStockGeneral();
--
-- Procedimiento para obtener las acciones realizadas en un producto por responsable
--
DELIMITER //
CREATE PROCEDURE ObtenerAccionesReservaPorResponsable(
    IN p_responsable VARCHAR(50),
    IN p_producto VARCHAR(60)
)
BEGIN
    SELECT
        hcpr.fecha_hora_actualizacion_hc AS fecha_hora,
        hcpr.responsable,
        hcpr.cantidad_salida_reserva AS cantidad_salida, -- Cantidad vendida o consumida de la reserva
        hcpr.cantidad_regreso,                         -- Cantidad devuelta al stock
        hcpr.motivo_actualizacion_hc AS motivo,
        CASE
            WHEN hcpr.cantidad_salida_reserva > 0 AND hcpr.cantidad_regreso = 0 THEN 'SALIDA_RESERVA/VENTA'
            WHEN hcpr.cantidad_regreso > 0 AND hcpr.cantidad_salida_reserva = 0 THEN 'REGRESO_STOCK/DEVOLUCION'
            ELSE 'ACTUALIZACION_RESERVA' -- Para otros casos
        END AS tipo_accion
    FROM
        historial_cambios_productos_reservados hcpr
    JOIN
        productos_reservados pr ON hcpr.id_reservados = pr.id_reservados
    WHERE
        pr.responsable = p_responsable
        AND pr.producto = p_producto
    ORDER BY
        hcpr.fecha_hora_actualizacion_hc DESC;
END //
DELIMITER ;
--
CALL ObtenerAccionesReservaPorResponsable('EVELYN', 'Arnes de Seguridad Amarillo');
--
select * from productos_reservados;
--
-- Procedimiento Almacenado para Actaulizacion de Stock Logistica
--
select * from actualizacion_logistica_stock;
--
DELIMITER //
CREATE PROCEDURE ListarLogisticaStock()
BEGIN
    SELECT
        id_historial_logistica,
        responsable,
        fecha_hora_logistica,
        producto,
        categoria,
        cantidad_cajas AS cantidad_antes_actualizar, -- Renombrado para mayor claridad
        cantidad_actual AS cantidad_despues_actualizar, -- Renombrado para mayor claridad
        motivo
    FROM
        actualizacion_logistica_stock
    ORDER BY
        fecha_hora_logistica DESC; -- Muestra los más recientes primero
END //
DELIMITER ;
--
CALL ListarLogisticaStock();
--
