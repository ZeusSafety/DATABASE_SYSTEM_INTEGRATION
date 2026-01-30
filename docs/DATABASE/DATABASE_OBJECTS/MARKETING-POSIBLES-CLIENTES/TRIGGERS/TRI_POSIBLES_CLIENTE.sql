--
-- TRIGGER PARA DETECTAR SI EN CASO ES UN CLIENTE NUEVO O ANTIGUO
-- SI EN CASO ES NUEVO LO REGISTRARA PARA LA TABLA POSIBLE_CLIENTE Y SI YA ES CLIENTE NO LO HARA Y SOLO 
-- GUARDARA LOS DATOS EN LA TABLA HISTORIAL_COTIZACION
--
DELIMITER //
CREATE TRIGGER after_cotizacion_insert
AFTER INSERT ON historial_cotizacion 
FOR EACH ROW
BEGIN
    -- Verificamos por NOMBRE, RUC o DNI si ya existe en clientes_ventas
    IF NOT EXISTS (SELECT 1 FROM clientes_ventas WHERE CLIENTE = NEW.NOMBRE_CLIENTE) THEN
        
        INSERT INTO posibles_clientes (
            ID_COTI_REF, COD_COTIZACION_REF, FECHA, NOMBRE_CLIENTE, 
            REGION, DISTRITO, CAMPANIA, ESTADO, OBSERVACIONES
        )
        VALUES (
            NEW.ID_COTI, NEW.COD_COTIZACION, NEW.FECHA_EMISION, NEW.NOMBRE_CLIENTE, 
            NEW.REGION, NEW.DISTRITO, NEW.CAMPANIA, 'PENDIENTE', 'REALIZO COTIZACION'
        );
    END IF;
END //
DELIMITER ;
--
-- TRIGGERS PARA CUANDO SE CREA UNA COTIZACION SE PUEDA RELACIONAR LOS CAMPOS ESTADOS 
-- DE LAS TABLAS HISTORIAL_COTIZACION Y POSIBLE_CLIENTE CUANDO SE GESTIONEN
--
DELIMITER //
CREATE TRIGGER tg_actualizar_posible_cliente
AFTER UPDATE ON historial_cotizacion
FOR EACH ROW
BEGIN
    DECLARE nuevo_estado_posible VARCHAR(20);

    -- Mapeo de estados según tu lógica
    IF NEW.ESTADO = 'PENDIENTE' THEN
        SET nuevo_estado_posible = 'PENDIENTE';
    ELSEIF NEW.ESTADO = 'ACEPTADO' THEN
        SET nuevo_estado_posible = 'CLIENTE';
    ELSEIF NEW.ESTADO = 'RECHAZADO' THEN
        SET nuevo_estado_posible = 'CLIENTE PERDIDO';
    END IF;

    -- Actualizar la tabla de posibles clientes basada en el código de cotización
    UPDATE posibles_clientes 
    SET ESTADO = nuevo_estado_posible
    WHERE COD_COTIZACION_REF = NEW.COD_COTIZACION;
END //
DELIMITER ;

select * from posibles_clientes;
select * from historial_cotizacion;
select * from clientes_ventas;
