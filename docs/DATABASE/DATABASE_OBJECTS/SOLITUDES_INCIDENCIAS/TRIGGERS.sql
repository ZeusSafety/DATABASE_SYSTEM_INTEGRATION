--
-- TRIGGERS SOLICITUDES / INCIDENCIAS
--
select * from solicitudes;
select * from respuestas;
--
-- ***********************************************
-- trigger para sincronizar los estados de la tabla Solicitudes y Respuestas
-- ***********************************************
DELIMITER //
CREATE TRIGGER trg_sincronizar_estado_respuesta
AFTER INSERT ON respuestas
FOR EACH ROW
BEGIN
    -- Sincroniza el ESTADO de la solicitud después de INSERTAR una respuesta
    UPDATE solicitudes
    SET ESTADO = NEW.ESTADO
    WHERE ID_SOLICITUD = NEW.ID_SOLICITUD;
END //

CREATE TRIGGER trg_sincronizar_estado_respuesta_update
AFTER UPDATE ON respuestas
FOR EACH ROW
BEGIN
    -- SOLO si el ESTADO realmente cambió en la tabla respuestas
    IF OLD.ESTADO <> NEW.ESTADO THEN
        -- Sincroniza el ESTADO de la solicitud después de ACTUALIZAR una respuesta
        UPDATE solicitudes
        SET ESTADO = NEW.ESTADO
        WHERE ID_SOLICITUD = NEW.ID_SOLICITUD;
    END IF;
END //
DELIMITER ;
--
select * from respuetas;
select * from reprogramaciones;
--
-- ***********************************************
-- Trigger para actualizar los campos FH_RESPUESTA O FH_INFORME CADA VEZ QUE SE ACTUALIZA LOS CAMPOS DE RESPUESTA O INFORME EN LA TABLA REPROGRAMACIONES
-- ***********************************************
DROP TRIGGER IF EXISTS trg_actualizar_fechas_reprogramaciones;

DELIMITER //
CREATE TRIGGER trg_actualizar_fechas_reprogramaciones
BEFORE UPDATE ON reprogramaciones
FOR EACH ROW
BEGIN
    -- 1. Lógica para FH_RESPUESTA (Motivo)
    -- Si el valor de RESPUESTA ES DIFERENTE (negamos la igualdad Null-Safe)
    IF NOT (OLD.RESPUESTA <=> NEW.RESPUESTA) THEN
        SET NEW.FH_RESPUESTA = NOW();
    END IF;

    -- 2. Lógica para FH_INFORME
    -- Si el valor de INFORME ES DIFERENTE (negamos la igualdad Null-Safe)
    IF NOT (OLD.INFORME <=> NEW.INFORME) THEN
        SET NEW.FH_INFORME = NOW();
    END IF;
END //
DELIMITER ;