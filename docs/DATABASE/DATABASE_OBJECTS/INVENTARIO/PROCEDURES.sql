-- ============================================================================
-- STORED PROCEDURES PARA INVENTARIO
-- ============================================================================

-- 
-- SP: Asignar nuevo inventario
-- 
DELIMITER //
CREATE PROCEDURE sp_asignar_inventario(
    IN p_numero_inventario VARCHAR(50),
    IN p_contrasena VARCHAR(255),
    IN p_area VARCHAR(100),
    IN p_autorizado_por VARCHAR(150),
    OUT p_resultado INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    DECLARE v_existe INT DEFAULT 0;
    DECLARE v_activo INT DEFAULT 0;
    
    -- Verificar si existe un inventario activo
    SELECT COUNT(*) INTO v_activo 
    FROM inventarios 
    WHERE estado = 'activo';
    
    IF v_activo > 0 THEN
        SET p_resultado = 0;
        SET p_mensaje = 'Ya existe un inventario activo. Debe cerrarlo antes de crear uno nuevo.';
    ELSE
        -- Verificar si el número de inventario ya existe
        SELECT COUNT(*) INTO v_existe 
        FROM inventarios 
        WHERE numero_inventario = p_numero_inventario;
        
        IF v_existe > 0 THEN
            SET p_resultado = 0;
            SET p_mensaje = 'El número de inventario ya existe.';
        ELSE
            -- Insertar nuevo inventario
            INSERT INTO inventarios (numero_inventario, contrasena, area, autorizado_por)
            VALUES (p_numero_inventario, p_contrasena, p_area, p_autorizado_por);
            
            SET p_resultado = LAST_INSERT_ID();
            SET p_mensaje = 'Inventario asignado correctamente.';
        END IF;
    END IF;
END//

-- 
-- SP: Unir colaborador a inventario
-- 
DELIMITER //
CREATE PROCEDURE sp_unir_colaborador_inventario(
    IN p_numero_inventario VARCHAR(50),
    IN p_nombre_colaborador VARCHAR(150),
    IN p_rol VARCHAR(50),
    OUT p_resultado INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    DECLARE v_inventario_id INT DEFAULT 0;
    DECLARE v_estado VARCHAR(20);
    
    -- Buscar inventario por número
    SELECT id, estado INTO v_inventario_id, v_estado
    FROM inventarios 
    WHERE numero_inventario = p_numero_inventario;
    
    IF v_inventario_id = 0 THEN
        SET p_resultado = 0;
        SET p_mensaje = 'No se encontró el inventario con ese número.';
    ELSEIF v_estado != 'activo' THEN
        SET p_resultado = 0;
        SET p_mensaje = 'El inventario no está activo.';
    ELSE
        -- Insertar colaborador
        INSERT INTO colaboradores_inventario (inventario_id, nombre_colaborador, rol)
        VALUES (v_inventario_id, p_nombre_colaborador, p_rol);
        
        SET p_resultado = LAST_INSERT_ID();
        SET p_mensaje = 'Colaborador unido correctamente al inventario.';
    END IF;
END//

-- 
-- SP: Iniciar conteo
-- 
DELIMITER //
CREATE PROCEDURE sp_iniciar_conteo(
    IN p_numero_inventario VARCHAR(50),
    IN p_almacen_id INT,
    IN p_tienda_id INT,
    IN p_registrado_por VARCHAR(150),
    IN p_tipo_conteo ENUM('por_cajas', 'por_stand'),
    IN p_origen_datos ENUM('sistema', 'excel'),
    OUT p_resultado INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    DECLARE v_inventario_id INT DEFAULT 0;
    DECLARE v_requiere_tienda BOOLEAN DEFAULT FALSE;
    
    -- Obtener ID del inventario
    SELECT id INTO v_inventario_id
    FROM inventarios 
    WHERE numero_inventario = p_numero_inventario AND estado = 'activo';
    
    IF v_inventario_id = 0 THEN
        SET p_resultado = 0;
        SET p_mensaje = 'No se encontró un inventario activo con ese número.';
    ELSE
        -- Verificar si el almacén requiere tienda
        SELECT requiere_tienda INTO v_requiere_tienda
        FROM almacenes
        WHERE id = p_almacen_id;
        
        -- Validar tienda
        IF v_requiere_tienda AND p_tienda_id IS NULL THEN
            SET p_resultado = 0;
            SET p_mensaje = 'Este almacén requiere seleccionar una tienda.';
        ELSE
            -- Insertar conteo
            INSERT INTO conteos (
                inventario_id, almacen_id, tienda_id, numero_inventario,
                registrado_por, tipo_conteo, origen_datos
            ) VALUES (
                v_inventario_id, p_almacen_id, p_tienda_id, p_numero_inventario,
                p_registrado_por, p_tipo_conteo, p_origen_datos
            );
            
            SET p_resultado = LAST_INSERT_ID();
            SET p_mensaje = 'Conteo iniciado correctamente.';
        END IF;
    END IF;
END//

-- 
-- SP: Cargar productos iniciales al conteo (desde sistema)
-- 
DELIMITER //
DROP PROCEDURE IF EXISTS sp_cargar_productos_conteo//
CREATE PROCEDURE sp_cargar_productos_conteo(
    IN p_conteo_id INT,
    OUT p_resultado INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    DECLARE v_registros INT DEFAULT 0;
    
    -- Insertar todos los productos activos al detalle del conteo
    INSERT INTO detalle_conteo (
        conteo_id, item_producto, producto, codigo, cantidad, unidad_medida
    )
    SELECT 
        p_conteo_id,
        item,
        producto,
        codigo,
        0, -- Cantidad inicial en 0
        unidad_medida
    FROM productos_inventario
    WHERE estado = 'activo';
    
    SET v_registros = ROW_COUNT();
    SET p_resultado = v_registros;
    SET p_mensaje = CONCAT('Se cargaron ', v_registros, ' productos al conteo.');
END//

-- 
-- SP: Finalizar conteo
--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_finalizar_conteo//
CREATE PROCEDURE sp_finalizar_conteo(
    IN p_conteo_id INT,
    IN p_archivo_pdf VARCHAR(500),
    OUT p_resultado INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    DECLARE v_existe INT DEFAULT 0;
    
    -- Verificar que el conteo existe
    SELECT COUNT(*) INTO v_existe
    FROM conteos
    WHERE id = p_conteo_id AND estado = 'en_proceso';
    
    IF v_existe = 0 THEN
        SET p_resultado = 0;
        SET p_mensaje = 'No se encontró el conteo o ya está finalizado.';
    ELSE
        -- Actualizar conteo
        UPDATE conteos
        SET estado = 'finalizado',
            fecha_hora_final = CURRENT_TIMESTAMP,
            archivo_pdf = p_archivo_pdf
        WHERE id = p_conteo_id;
        
        SET p_resultado = 1;
        SET p_mensaje = 'Conteo finalizado correctamente.';
    END IF;
END//

-- 
-- SP: Actualizar cantidad de producto (individual)
--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_actualizar_cantidad_producto//
CREATE PROCEDURE sp_actualizar_cantidad_producto(
    IN p_detalle_id INT,
    IN p_nueva_cantidad DECIMAL(15,3),
    IN p_usuario VARCHAR(150),
    OUT p_resultado INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    DECLARE v_cantidad_anterior DECIMAL(15,3);
    DECLARE v_conteo_id INT;
    
    -- Obtener cantidad anterior
    SELECT cantidad, conteo_id INTO v_cantidad_anterior, v_conteo_id
    FROM detalle_conteo
    WHERE id = p_detalle_id;
    
    IF v_conteo_id IS NULL THEN
        SET p_resultado = 0;
        SET p_mensaje = 'No se encontró el detalle del conteo.';
    ELSE
        -- Actualizar cantidad
        UPDATE detalle_conteo
        SET cantidad = p_nueva_cantidad,
            usuario_modificacion = p_usuario
        WHERE id = p_detalle_id;
        
        -- Registrar auditoría
        INSERT INTO auditoria_cambios (
            detalle_conteo_id, conteo_id, campo_modificado, 
            valor_anterior, valor_nuevo, tipo_modificacion, usuario
        ) VALUES (
            p_detalle_id, v_conteo_id, 'cantidad',
            CAST(v_cantidad_anterior AS CHAR), CAST(p_nueva_cantidad AS CHAR),
            'individual', p_usuario
        );
        
        SET p_resultado = 1;
        SET p_mensaje = 'Cantidad actualizada correctamente.';
    END IF;
END//

-- 
-- SP: Obtener inventario activo
--
DELIMITER //
CREATE PROCEDURE sp_obtener_inventario_activo(
    OUT p_inventario_id INT,
    OUT p_numero_inventario VARCHAR(50)
)
BEGIN
    SELECT id, numero_inventario 
    INTO p_inventario_id, p_numero_inventario
    FROM inventarios
    WHERE estado = 'activo'
    LIMIT 1;
END//

-- 
-- SP: Obtener datos desde el excel
--
DELIMITER //
CREATE PROCEDURE sp_cargar_conteo_desde_excel (
    IN p_conteo_id INT,
    IN p_usuario VARCHAR(150),
    OUT p_registros_procesados INT,
    OUT p_registros_actualizados INT
)
BEGIN
    DECLARE v_estado VARCHAR(20);

    -- 1️ Validar conteo
    SELECT estado INTO v_estado
    FROM conteos
    WHERE id = p_conteo_id;

    IF v_estado IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El conteo no existe';
    END IF;

    IF v_estado <> 'en_proceso' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El conteo no está en proceso';
    END IF;

    -- 2️ Total de registros procesados
    SELECT COUNT(*) INTO p_registros_procesados
    FROM tmp_excel_conteo;

    -- 3️ Actualizar detalle_conteo desde Excel
    UPDATE detalle_conteo dc
    INNER JOIN tmp_excel_conteo te
        ON dc.codigo = te.codigo
    INNER JOIN mapeo_unidades_excel mu
        ON mu.codigo_excel = te.unidad_excel
       AND mu.activo = TRUE
    SET
        dc.cantidad = te.cantidad,
        dc.unidad_medida = mu.unidad_sistema,
        dc.usuario_modificacion = p_usuario,
        dc.fecha_hora_modificacion = CURRENT_TIMESTAMP
    WHERE dc.conteo_id = p_conteo_id;

    -- 4️ Registros realmente actualizados
    SET p_registros_actualizados = ROW_COUNT();

    -- 5️ Registrar la carga
    INSERT INTO archivos_excel_cargados (
        conteo_id,
        registros_procesados,
        registros_insertados,
        observaciones
    ) VALUES (
        p_conteo_id,
        p_registros_procesados,
        p_registros_actualizados,
        CONCAT('Carga desde Excel por ', p_usuario)
    );
END//

--
-- ============================================================================
-- STORED PROCEDURES PARA INVENTARIO (MODULO COMPARACIÓN)
-- ============================================================================
--

-- 
-- SP: Cargar datos del sistema desde Excel (Callao)
-- 
DELIMITER //
CREATE PROCEDURE sp_cargar_sistema_callao(
    IN p_inventario_id INT,
    IN p_usuario VARCHAR(100),
    IN p_archivo VARCHAR(255),
    OUT p_registros_procesados INT,
    OUT p_mensaje VARCHAR(500)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_mensaje = 'Error al cargar datos del sistema';
        SET p_registros_procesados = 0;
    END;
    
    START TRANSACTION;
    
    -- Nota: Los datos deben ser insertados previamente en una tabla temporal
    -- desde Python después de procesar el Excel
    
    -- Contar registros procesados
    SELECT COUNT(*) INTO p_registros_procesados
    FROM datos_sistema_callao
    WHERE inventario_id = p_inventario_id;
    
    SET p_mensaje = CONCAT('Se cargaron ', p_registros_procesados, ' productos del sistema');
    
    COMMIT;
END //
DELIMITER ;

-- 
-- SP: Generar comparación automática (Callao)
-- 
DELIMITER //
CREATE PROCEDURE sp_generar_comparacion_callao(
    IN p_inventario_id INT,
    OUT p_registros_procesados INT,
    OUT p_mensaje VARCHAR(500)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_mensaje = 'Error al generar comparación';
        SET p_registros_procesados = 0;
    END;
    
    START TRANSACTION;
    
    -- Limpiar comparaciones anteriores para este inventario
    DELETE FROM comparaciones_callao WHERE inventario_id = p_inventario_id;
    
    -- Generar comparaciones
    INSERT INTO comparaciones_callao (
        inventario_id,
        producto_item,
        producto,
        codigo,
        cantidad_sistema,
        cantidad_fisica,
        resultado,
        estado,
        unidad_medida
    )
    SELECT 
        ds.inventario_id,
        ds.producto_item,
        ds.producto,
        ds.codigo,
        COALESCE(ds.cantidad_sistema, 0) as cantidad_sistema,
        COALESCE(
            (SELECT SUM(dc.cantidad) 
             FROM detalle_conteo_callao dc
             JOIN conteos_callao cc ON dc.conteo_id = cc.id
             WHERE cc.inventario_id = p_inventario_id 
             AND dc.codigo = ds.codigo
             AND cc.estado = 'finalizado'),
            0
        ) as cantidad_fisica,
        COALESCE(
            (SELECT SUM(dc.cantidad) 
             FROM detalle_conteo_callao dc
             JOIN conteos_callao cc ON dc.conteo_id = cc.id
             WHERE cc.inventario_id = p_inventario_id 
             AND dc.codigo = ds.codigo
             AND cc.estado = 'finalizado'),
            0
        ) - COALESCE(ds.cantidad_sistema, 0) as resultado,
        CASE
            WHEN COALESCE(
                (SELECT SUM(dc.cantidad) 
                 FROM detalle_conteo_callao dc
                 JOIN conteos_callao cc ON dc.conteo_id = cc.id
                 WHERE cc.inventario_id = p_inventario_id 
                 AND dc.codigo = ds.codigo
                 AND cc.estado = 'finalizado'),
                0
            ) = COALESCE(ds.cantidad_sistema, 0) THEN 'CONFORME'
            WHEN COALESCE(
                (SELECT SUM(dc.cantidad) 
                 FROM detalle_conteo_callao dc
                 JOIN conteos_callao cc ON dc.conteo_id = cc.id
                 WHERE cc.inventario_id = p_inventario_id 
                 AND dc.codigo = ds.codigo
                 AND cc.estado = 'finalizado'),
                0
            ) > COALESCE(ds.cantidad_sistema, 0) THEN 'SOBRANTE'
            ELSE 'FALTANTE'
        END as estado,
        ds.unidad_medida
    FROM datos_sistema_callao ds
    WHERE ds.inventario_id = p_inventario_id
    AND ds.estado = 'activo';
    
    SET p_registros_procesados = ROW_COUNT();
    SET p_mensaje = CONCAT('Comparación generada: ', p_registros_procesados, ' productos procesados');
    
    COMMIT;
END //
DELIMITER ;

--
-- SP: Generar comparación automática (Malvinas)
-- 
DELIMITER //
CREATE PROCEDURE sp_generar_comparacion_malvinas(
    IN p_inventario_id INT,
    OUT p_registros_procesados INT,
    OUT p_mensaje VARCHAR(500)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_mensaje = 'Error al generar comparación';
        SET p_registros_procesados = 0;
    END;
    
    START TRANSACTION;
    
    -- Limpiar comparaciones anteriores para este inventario
    DELETE FROM comparaciones_malvinas WHERE inventario_id = p_inventario_id;
    
    -- Generar comparaciones
    INSERT INTO comparaciones_malvinas (
        inventario_id,
        producto_item,
        producto,
        codigo,
        cantidad_sistema,
        cantidad_fisica,
        resultado,
        estado,
        unidad_medida
    )
    SELECT 
        ds.inventario_id,
        ds.producto_item,
        ds.producto,
        ds.codigo,
        COALESCE(ds.cantidad_sistema, 0) as cantidad_sistema,
        COALESCE(
            (SELECT SUM(dm.cantidad) 
             FROM detalle_conteo_malvinas dm
             JOIN conteos_malvinas cm ON dm.conteo_id = cm.id
             WHERE cm.inventario_id = p_inventario_id 
             AND dm.codigo = ds.codigo
             AND cm.estado = 'finalizado'),
            0
        ) as cantidad_fisica,
        COALESCE(
            (SELECT SUM(dm.cantidad) 
             FROM detalle_conteo_malvinas dm
             JOIN conteos_malvinas cm ON dm.conteo_id = cm.id
             WHERE cm.inventario_id = p_inventario_id 
             AND dm.codigo = ds.codigo
             AND cm.estado = 'finalizado'),
            0
        ) - COALESCE(ds.cantidad_sistema, 0) as resultado,
        CASE
            WHEN COALESCE(
                (SELECT SUM(dm.cantidad) 
                 FROM detalle_conteo_malvinas dm
                 JOIN conteos_malvinas cm ON dm.conteo_id = cm.id
                 WHERE cm.inventario_id = p_inventario_id 
                 AND dm.codigo = ds.codigo
                 AND cm.estado = 'finalizado'),
                0
            ) = COALESCE(ds.cantidad_sistema, 0) THEN 'CONFORME'
            WHEN COALESCE(
                (SELECT SUM(dm.cantidad) 
                 FROM detalle_conteo_malvinas dm
                 JOIN conteos_malvinas cm ON dm.conteo_id = cm.id
                 WHERE cm.inventario_id = p_inventario_id 
                 AND dm.codigo = ds.codigo
                 AND cm.estado = 'finalizado'),
                0
            ) > COALESCE(ds.cantidad_sistema, 0) THEN 'SOBRANTE'
            ELSE 'FALTANTE'
        END as estado,
        ds.unidad_medida
    FROM datos_sistema_malvinas ds
    WHERE ds.inventario_id = p_inventario_id
    AND ds.estado = 'activo';
    
    SET p_registros_procesados = ROW_COUNT();
    SET p_mensaje = CONCAT('Comparación generada: ', p_registros_procesados, ' productos procesados');
    
    COMMIT;
END //
DELIMITER ;

-- 
-- SP: Calcular estado de verificación
-- 
DELIMITER //
CREATE PROCEDURE sp_calcular_estado_verificacion(
    IN p_stock_existencia DECIMAL(10,2),
    IN p_stock_fisico DECIMAL(10,2),
    IN p_stock_sistema DECIMAL(10,2),
    OUT p_estado VARCHAR(50),
    OUT p_mensaje TEXT
)
BEGIN
    -- Caso 1: Stock existencia coincide con físico pero no con sistema
    IF p_stock_existencia = p_stock_fisico AND p_stock_existencia != p_stock_sistema THEN
        SET p_estado = 'ERROR_SISTEMA';
        SET p_mensaje = 'El sistema está mal, pero el conteo físico es correcto';
        
    -- Caso 2: Stock existencia coincide con sistema pero no con físico
    ELSEIF p_stock_existencia = p_stock_sistema AND p_stock_existencia != p_stock_fisico THEN
        SET p_estado = 'ERROR_LOGISTICA';
        SET p_mensaje = 'El sistema refleja bien, pero el conteo físico no coincide';
        
    -- Caso 3: Stock existencia no coincide con ninguno
    ELSEIF p_stock_existencia != p_stock_fisico AND p_stock_existencia != p_stock_sistema THEN
        SET p_estado = 'NUEVO_CONTEO_REQUERIDO';
        SET p_mensaje = 'Ambos están mal respecto a la existencia calculada. Se requiere nuevo conteo';
        
    -- Caso 4: Todos coinciden
    ELSE
        SET p_estado = 'CONFORME';
        SET p_mensaje = 'Todo está correcto';
    END IF;
END //
DELIMITER ;

-- 
-- VISTA: Historial completo de acciones por inventario (COMPARACIÓN)
-- 
CREATE OR REPLACE VIEW v_historial_completo_comparaciones AS
SELECT 
    h.id,
    h.inventario_id,
    i.numero_inventario,
    h.producto_item,
    h.producto,
    h.codigo,
    h.almacen,
    h.tipo_accion,
    h.motivo,
    h.cantidad_afectada,
    h.error_de,
    h.registrado_por,
    h.fecha_hora,
    DATE_FORMAT(h.fecha_hora, '%d/%m/%Y %H:%i:%s') as fecha_hora_formateada
FROM historial_acciones_comparacion h
JOIN inventarios i ON h.inventario_id = i.id
ORDER BY h.fecha_hora DESC;


