-- PROCEDIMIENTOS ALMACENADOS SOLICITUDES/INCIDENCIAS (PARA LISTADOD DE SOLICITUDES POR AREA)
--
-- IMPLEMENTAR MAS RESPUESTAS EN LAS SOLICITUDES
--
select * from reprogramaciones;
select * from solicitudes;
select * from respuestas;
--
--
ALTER TABLE solicitudes
ADD REQUERIMIENTO_2 TEXT,
ADD FECHA_REQUERIMIENTO_2 DATETIME,
ADD INFORME_2 VARCHAR(255),
ADD FECHA_INFORME_2 DATETIME,
ADD REQUERIMIENTO_3 TEXT,
ADD FECHA_REQUERIMIENTO_3 DATETIME,
ADD INFORME_3 VARCHAR(255),
ADD FECHA_INFORME_3 DATETIME
--
-- PROCEDIMIENTO ALMACENADO PARA MAS RESPUESTA A LA SOLICITUD
--
DELIMITER $$
CREATE PROCEDURE actualizar_requerimientos (
    IN p_id_solicitud INT,
    IN p_requerimiento2 TEXT,
    IN p_informe2 VARCHAR(255),
    IN p_requerimiento3 TEXT,
    IN p_informe3 VARCHAR(255)
)
BEGIN
    DECLARE v_requerimiento2 TEXT;
    DECLARE v_informe2 VARCHAR(255);
    DECLARE v_requerimiento3 TEXT;
    DECLARE v_informe3 VARCHAR(255);

    -- Obtener valores actuales
    SELECT REQUERIMIENTO_2, INFORME_2, REQUERIMIENTO_3, INFORME_3
    INTO v_requerimiento2, v_informe2, v_requerimiento3, v_informe3
    FROM solicitudes
    WHERE ID_SOLICITUD = p_id_solicitud;

    -- Actualizar REQUERIMIENTO_2 solo si cambia
    IF NULLIF(TRIM(p_requerimiento2),'') IS NOT NULL 
       AND p_requerimiento2 <> IFNULL(v_requerimiento2, '')THEN
        UPDATE solicitudes
        SET REQUERIMIENTO_2 = p_requerimiento2,
            FECHA_REQUERIMIENTO_2 = NOW()
        WHERE ID_SOLICITUD = p_id_solicitud;
    END IF;

    -- Actualizar INFORME_2 solo si cambia
	IF NULLIF(TRIM(p_informe2),'') IS NOT NULL 
	   AND p_informe2 <> IFNULL(v_informe2,'') THEN
		UPDATE solicitudes
		SET INFORME_2 = p_informe2,
			FECHA_INFORME_2 = NOW()
	   WHERE ID_SOLICITUD = p_id_solicitud;
	END IF;

    -- Actualizar REQUERIMIENTO_3 solo si cambia
    IF NULLIF(TRIM(p_requerimiento3),'') IS NOT NULL 
       AND p_requerimiento3 <> IFNULL(v_requerimiento3,'') THEN
        UPDATE solicitudes
        SET REQUERIMIENTO_3 = p_requerimiento3,
            FECHA_REQUERIMIENTO_3 = NOW()
        WHERE ID_SOLICITUD = p_id_solicitud;
    END IF;

    -- Actualizar INFORME_3 solo si cambia
    IF NULLIF(TRIM(p_informe3),'') IS NOT NULL 
     AND p_informe3 <> IFNULL(v_informe3,'') THEN
      UPDATE solicitudes
       SET INFORME_3 = p_informe3,
         FECHA_INFORME_3 = NOW()
       WHERE ID_SOLICITUD = p_id_solicitud;
    END IF;
END$$
DELIMITER ;
--
-- PRUBEA DEL SP actualizar_requerimiento
--
CALL actualizar_requerimientos(
    254,                          -- ID_SOLICITUD
    'GAAAA',  -- REQUERIMIENTO_2
    '',                         -- INFORME_2 (no se actualiza)
    'XD',    -- REQUERIMIENTO_3
    ''            -- INFORME_3
);
--
--
--
select * from solicitudes;

CALL sp_listado_solicitudes_respuestas_administracion;
CALL sp_listado_solicitudes_respuestas;

SHOW procedure status
--
--
--
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas()
BEGIN
    SELECT
        s.ID_SOLICITUD,
        s.FECHA_CONSULTA,
        s.REGISTRADO_POR,
        s.NUMERO_SOLICITUD,
        s.AREA,
        s.RES_INCIDENCIA,
        s.REQUERIMIENTOS,
        s.INFORME AS INFORME_SOLICITUD,
        -- Nuevos campos de solicitudes
        s.REQUERIMIENTO_2,
        s.FECHA_REQUERIMIENTO_2,
        s.REQUERIMIENTO_3,
        s.FECHA_REQUERIMIENTO_3,
        s.INFORME_2,
        s.FECHA_INFORME_2,
        s.INFORME_3,
        s.FECHA_INFORME_3,
        -- Campos originales
        s.AREA_RECEPCION,
        r.ID_RESPUESTA,
        r.FECHA_RESPUESTA,
        r.RESPONDIDO_POR,
        r.RESPUESTA AS RESPUESTA_R,
        r.INFORME AS INFORME_RESPUESTA,
        s.ESTADO,
        /* Agrupa las reprogramaciones en un array JSON */
        (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'ID_REPROGRAMACION', rp.ID_REPROGRAMACION,
                    'FECHA_REPROGRAMACION', rp.FECHA_REPROGRAMACION,
                    'RESPUESTA_REPROG', rp.RESPUESTA,
                    'FH_RESPUESTA', rp.FH_RESPUESTA,
                    'INFORME_REPROG', rp.INFORME,
                    'FH_INFORME', rp.FH_INFORME
                )
            )
            FROM reprogramaciones rp
            WHERE rp.ID_RESPUESTA = r.ID_RESPUESTA
        ) AS REPROGRAMACIONES
    FROM solicitudes s
    LEFT JOIN respuestas r ON s.ID_SOLICITUD = r.ID_SOLICITUD
    ORDER BY s.FECHA_CONSULTA DESC;
END$$
DELIMITER ;
--
CALL sp_listado_solicitudes_respuestas();
--
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_sistemas()
BEGIN
    SELECT
        s.ID_SOLICITUD,
        s.FECHA_CONSULTA,
        s.REGISTRADO_POR,
        s.NUMERO_SOLICITUD,
        s.AREA,
        s.RES_INCIDENCIA,
        s.REQUERIMIENTOS,
        s.INFORME AS INFORME_SOLICITUD,
		-- Nuevos campos de solicitudes
        s.REQUERIMIENTO_2,
        s.FECHA_REQUERIMIENTO_2,
        s.REQUERIMIENTO_3,
        s.FECHA_REQUERIMIENTO_3,
        s.INFORME_2,
        s.FECHA_INFORME_2,
        s.INFORME_3,
        s.FECHA_INFORME_3,
		--
        s.AREA_RECEPCION,
        r.ID_RESPUESTA,
        r.FECHA_RESPUESTA,
        r.RESPONDIDO_POR,
        r.RESPUESTA AS RESPUESTA_R,
        r.INFORME AS INFORME_RESPUESTA,
        s.ESTADO,
        -- Agrupa las reprogramaciones en un array JSON
        (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'ID_REPROGRAMACION', rp.ID_REPROGRAMACION,
                    'FECHA_REPROGRAMACION', rp.FECHA_REPROGRAMACION,
                    'RESPUESTA_REPROG', rp.RESPUESTA,
                    'FH_RESPUESTA', rp.FH_RESPUESTA,
                    'INFORME_REPROG', rp.INFORME,
                    'FH_INFORME', rp.FH_INFORME
                )
            )
            FROM reprogramaciones rp
            WHERE rp.ID_RESPUESTA = r.ID_RESPUESTA
        ) AS REPROGRAMACIONES
    FROM solicitudes s
    LEFT JOIN respuestas r ON s.ID_SOLICITUD = r.ID_SOLICITUD
    WHERE s.AREA_RECEPCION = 'SISTEMAS'
    ORDER BY s.FECHA_CONSULTA DESC;
END$$
DELIMITER ;
select * from SUB_VISTAS;
--
CALL sp_listado_solicitudes_respuestas_sistemas()
--
-- ADMIN VENTAS
--
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_ventas()
BEGIN
    SELECT
        s.ID_SOLICITUD,
        s.FECHA_CONSULTA,
        s.REGISTRADO_POR,
        s.NUMERO_SOLICITUD,
        s.AREA,
        s.RES_INCIDENCIA,
        s.REQUERIMIENTOS,
        s.INFORME AS INFORME_SOLICITUD,
		-- Nuevos campos de solicitudes
        s.REQUERIMIENTO_2,
        s.FECHA_REQUERIMIENTO_2,
        s.REQUERIMIENTO_3,
        s.FECHA_REQUERIMIENTO_3,
        s.INFORME_2,
        s.FECHA_INFORME_2,
        s.INFORME_3,
        s.FECHA_INFORME_3,
		--
        s.AREA_RECEPCION,
        r.ID_RESPUESTA,
        r.FECHA_RESPUESTA,
        r.RESPONDIDO_POR,
        r.RESPUESTA AS RESPUESTA_R,
        r.INFORME AS INFORME_RESPUESTA,
        s.ESTADO,
        -- Agrupa las reprogramaciones en un array JSON
        (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'ID_REPROGRAMACION', rp.ID_REPROGRAMACION,
                    'FECHA_REPROGRAMACION', rp.FECHA_REPROGRAMACION,
                    'RESPUESTA_REPROG', rp.RESPUESTA,
                    'FH_RESPUESTA', rp.FH_RESPUESTA,
                    'INFORME_REPROG', rp.INFORME,
                    'FH_INFORME', rp.FH_INFORME
                )
            )
            FROM reprogramaciones rp
            WHERE rp.ID_RESPUESTA = r.ID_RESPUESTA
        ) AS REPROGRAMACIONES
    FROM solicitudes s
    LEFT JOIN respuestas r ON s.ID_SOLICITUD = r.ID_SOLICITUD
    WHERE s.AREA_RECEPCION = 'VENTAS'
    ORDER BY s.FECHA_CONSULTA DESC;
END$$
DELIMITER ;
--
CALL sp_listado_solicitudes_respuestas_ventas();
--
-- ADMIN RECURSOS HUMANOS
--
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_rrhh()
BEGIN
    SELECT
        s.ID_SOLICITUD,
        s.FECHA_CONSULTA,
        s.REGISTRADO_POR,
        s.NUMERO_SOLICITUD,
        s.AREA,
        s.RES_INCIDENCIA,
        s.REQUERIMIENTOS,
        s.INFORME AS INFORME_SOLICITUD,
		-- Nuevos campos de solicitudes
        s.REQUERIMIENTO_2,
        s.FECHA_REQUERIMIENTO_2,
        s.REQUERIMIENTO_3,
        s.FECHA_REQUERIMIENTO_3,
        s.INFORME_2,
        s.FECHA_INFORME_2,
        s.INFORME_3,
        s.FECHA_INFORME_3,
		--
        s.AREA_RECEPCION,
        r.ID_RESPUESTA,
        r.FECHA_RESPUESTA,
        r.RESPONDIDO_POR,
        r.RESPUESTA AS RESPUESTA_R,
        r.INFORME AS INFORME_RESPUESTA,
        s.ESTADO,
        -- Agrupa las reprogramaciones en un array JSON
        (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'ID_REPROGRAMACION', rp.ID_REPROGRAMACION,
                    'FECHA_REPROGRAMACION', rp.FECHA_REPROGRAMACION,
                    'RESPUESTA_REPROG', rp.RESPUESTA,
                    'FH_RESPUESTA', rp.FH_RESPUESTA,
                    'INFORME_REPROG', rp.INFORME,
                    'FH_INFORME', rp.FH_INFORME
                )
            )
            FROM reprogramaciones rp
            WHERE rp.ID_RESPUESTA = r.ID_RESPUESTA
        ) AS REPROGRAMACIONES
    FROM solicitudes s
    LEFT JOIN respuestas r ON s.ID_SOLICITUD = r.ID_SOLICITUD
    WHERE s.AREA_RECEPCION = 'RECURSOS HUMANOS'
    ORDER BY s.FECHA_CONSULTA DESC;
END$$
DELIMITER ;
--
CALL sp_listado_solicitudes_respuestas_rrhh();
--
-- ADMIN MARKETING
--
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_marketing()
BEGIN
    SELECT
        s.ID_SOLICITUD,
        s.FECHA_CONSULTA,
        s.REGISTRADO_POR,
        s.NUMERO_SOLICITUD,
        s.AREA,
        s.RES_INCIDENCIA,
        s.REQUERIMIENTOS,
        s.INFORME AS INFORME_SOLICITUD,
		-- Nuevos campos de solicitudes
        s.REQUERIMIENTO_2,
        s.FECHA_REQUERIMIENTO_2,
        s.REQUERIMIENTO_3,
        s.FECHA_REQUERIMIENTO_3,
        s.INFORME_2,
        s.FECHA_INFORME_2,
        s.INFORME_3,
        s.FECHA_INFORME_3,
		--
        s.AREA_RECEPCION,
        r.ID_RESPUESTA,
        r.FECHA_RESPUESTA,
        r.RESPONDIDO_POR,
        r.RESPUESTA AS RESPUESTA_R,
        r.INFORME AS INFORME_RESPUESTA,
        s.ESTADO,
        -- Agrupa las reprogramaciones en un array JSON
        (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'ID_REPROGRAMACION', rp.ID_REPROGRAMACION,
                    'FECHA_REPROGRAMACION', rp.FECHA_REPROGRAMACION,
                    'RESPUESTA_REPROG', rp.RESPUESTA,
                    'FH_RESPUESTA', rp.FH_RESPUESTA,
                    'INFORME_REPROG', rp.INFORME,
                    'FH_INFORME', rp.FH_INFORME
                )
            )
            FROM reprogramaciones rp
            WHERE rp.ID_RESPUESTA = r.ID_RESPUESTA
        ) AS REPROGRAMACIONES
    FROM solicitudes s
    LEFT JOIN respuestas r ON s.ID_SOLICITUD = r.ID_SOLICITUD
    WHERE s.AREA_RECEPCION = 'MARKETING'
    ORDER BY s.FECHA_CONSULTA DESC;
END$$
DELIMITER ;
--
CALL sp_listado_solicitudes_respuestas_marketing();
--
-- LOGISTICA
--
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_logistica()
BEGIN
    SELECT
        s.ID_SOLICITUD,
        s.FECHA_CONSULTA,
        s.REGISTRADO_POR,
        s.NUMERO_SOLICITUD,
        s.AREA,
        s.RES_INCIDENCIA,
        s.REQUERIMIENTOS,
        s.INFORME AS INFORME_SOLICITUD,
		-- Nuevos campos de solicitudes
        s.REQUERIMIENTO_2,
        s.FECHA_REQUERIMIENTO_2,
        s.REQUERIMIENTO_3,
        s.FECHA_REQUERIMIENTO_3,
        s.INFORME_2,
        s.FECHA_INFORME_2,
        s.INFORME_3,
        s.FECHA_INFORME_3,
		--
        s.AREA_RECEPCION,
        r.ID_RESPUESTA,
        r.FECHA_RESPUESTA,
        r.RESPONDIDO_POR,
        r.RESPUESTA AS RESPUESTA_R,
        r.INFORME AS INFORME_RESPUESTA,
        s.ESTADO,
        -- Agrupa las reprogramaciones en un array JSON
        (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'ID_REPROGRAMACION', rp.ID_REPROGRAMACION,
                    'FECHA_REPROGRAMACION', rp.FECHA_REPROGRAMACION,
                    'RESPUESTA_REPROG', rp.RESPUESTA,
                    'FH_RESPUESTA', rp.FH_RESPUESTA,
                    'INFORME_REPROG', rp.INFORME,
                    'FH_INFORME', rp.FH_INFORME
                )
            )
            FROM reprogramaciones rp
            WHERE rp.ID_RESPUESTA = r.ID_RESPUESTA
        ) AS REPROGRAMACIONES
    FROM solicitudes s
    LEFT JOIN respuestas r ON s.ID_SOLICITUD = r.ID_SOLICITUD
    WHERE s.AREA_RECEPCION = 'LOGISTICA'
    ORDER BY s.FECHA_CONSULTA DESC;
END$$
DELIMITER ;
--
CALL sp_listado_solicitudes_respuestas_logistica();
--
-- ADMIN IMPORTACION
--
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_importacion()
BEGIN
    SELECT
        s.ID_SOLICITUD,
        s.FECHA_CONSULTA,
        s.REGISTRADO_POR,
        s.NUMERO_SOLICITUD,
        s.AREA,
        s.RES_INCIDENCIA,
        s.REQUERIMIENTOS,
        s.INFORME AS INFORME_SOLICITUD,
		-- Nuevos campos de solicitudes
        s.REQUERIMIENTO_2,
        s.FECHA_REQUERIMIENTO_2,
        s.REQUERIMIENTO_3,
        s.FECHA_REQUERIMIENTO_3,
        s.INFORME_2,
        s.FECHA_INFORME_2,
        s.INFORME_3,
        s.FECHA_INFORME_3,
		--
        s.AREA_RECEPCION,
        r.ID_RESPUESTA,
        r.FECHA_RESPUESTA,
        r.RESPONDIDO_POR,
        r.RESPUESTA AS RESPUESTA_R,
        r.INFORME AS INFORME_RESPUESTA,
        s.ESTADO,
        -- Agrupa las reprogramaciones en un array JSON
        (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'ID_REPROGRAMACION', rp.ID_REPROGRAMACION,
                    'FECHA_REPROGRAMACION', rp.FECHA_REPROGRAMACION,
                    'RESPUESTA_REPROG', rp.RESPUESTA,
                    'FH_RESPUESTA', rp.FH_RESPUESTA,
                    'INFORME_REPROG', rp.INFORME,
                    'FH_INFORME', rp.FH_INFORME
                )
            )
            FROM reprogramaciones rp
            WHERE rp.ID_RESPUESTA = r.ID_RESPUESTA
        ) AS REPROGRAMACIONES
    FROM solicitudes s
    LEFT JOIN respuestas r ON s.ID_SOLICITUD = r.ID_SOLICITUD
    WHERE s.AREA_RECEPCION = 'IMPORTACION'
    ORDER BY s.FECHA_CONSULTA DESC;
END$$
DELIMITER ;
--
CALL sp_listado_solicitudes_respuestas_importacion();
--
-- ADMIN GERENCIA
--
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_gerencia()
BEGIN
    SELECT
        s.ID_SOLICITUD,
        s.FECHA_CONSULTA,
        s.REGISTRADO_POR,
        s.NUMERO_SOLICITUD,
        s.AREA,
        s.RES_INCIDENCIA,
        s.REQUERIMIENTOS,
        s.INFORME AS INFORME_SOLICITUD,
		-- Nuevos campos de solicitudes
        s.REQUERIMIENTO_2,
        s.FECHA_REQUERIMIENTO_2,
        s.REQUERIMIENTO_3,
        s.FECHA_REQUERIMIENTO_3,
        s.INFORME_2,
        s.FECHA_INFORME_2,
        s.INFORME_3,
        s.FECHA_INFORME_3,
		--
        s.AREA_RECEPCION,
        r.ID_RESPUESTA,
        r.FECHA_RESPUESTA,
        r.RESPONDIDO_POR,
        r.RESPUESTA AS RESPUESTA_R,
        r.INFORME AS INFORME_RESPUESTA,
        s.ESTADO,
        -- Agrupa las reprogramaciones en un array JSON
        (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'ID_REPROGRAMACION', rp.ID_REPROGRAMACION,
                    'FECHA_REPROGRAMACION', rp.FECHA_REPROGRAMACION,
                    'RESPUESTA_REPROG', rp.RESPUESTA,
                    'FH_RESPUESTA', rp.FH_RESPUESTA,
                    'INFORME_REPROG', rp.INFORME,
                    'FH_INFORME', rp.FH_INFORME
                )
            )
            FROM reprogramaciones rp
            WHERE rp.ID_RESPUESTA = r.ID_RESPUESTA
        ) AS REPROGRAMACIONES
    FROM solicitudes s
    LEFT JOIN respuestas r ON s.ID_SOLICITUD = r.ID_SOLICITUD
    WHERE s.AREA_RECEPCION = 'GERENCIA'
    ORDER BY s.FECHA_CONSULTA DESC;
END$$
DELIMITER ;
--
CALL sp_listado_solicitudes_respuestas_gerencia();
--
-- ADMIN FACTURACION
--
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_facturacion()
BEGIN
    SELECT
        s.ID_SOLICITUD,
        s.FECHA_CONSULTA,
        s.REGISTRADO_POR,
        s.NUMERO_SOLICITUD,
        s.AREA,
        s.RES_INCIDENCIA,
        s.REQUERIMIENTOS,
        s.INFORME AS INFORME_SOLICITUD,
		-- Nuevos campos de solicitudes
        s.REQUERIMIENTO_2,
        s.FECHA_REQUERIMIENTO_2,
        s.REQUERIMIENTO_3,
        s.FECHA_REQUERIMIENTO_3,
        s.INFORME_2,
        s.FECHA_INFORME_2,
        s.INFORME_3,
        s.FECHA_INFORME_3,
		--
        s.AREA_RECEPCION,
        r.ID_RESPUESTA,
        r.FECHA_RESPUESTA,
        r.RESPONDIDO_POR,
        r.RESPUESTA AS RESPUESTA_R,
        r.INFORME AS INFORME_RESPUESTA,
        s.ESTADO,
        -- Agrupa las reprogramaciones en un array JSON
        (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'ID_REPROGRAMACION', rp.ID_REPROGRAMACION,
                    'FECHA_REPROGRAMACION', rp.FECHA_REPROGRAMACION,
                    'RESPUESTA_REPROG', rp.RESPUESTA,
                    'FH_RESPUESTA', rp.FH_RESPUESTA,
                    'INFORME_REPROG', rp.INFORME,
                    'FH_INFORME', rp.FH_INFORME
                )
            )
            FROM reprogramaciones rp
            WHERE rp.ID_RESPUESTA = r.ID_RESPUESTA
        ) AS REPROGRAMACIONES
    FROM solicitudes s
    LEFT JOIN respuestas r ON s.ID_SOLICITUD = r.ID_SOLICITUD
    WHERE s.AREA_RECEPCION = 'FACTURACION'
    ORDER BY s.FECHA_CONSULTA DESC;
END$$
DELIMITER ;
--
CALL sp_listado_solicitudes_respuestas_facturacion();
--
-- ADMIN ADMINISTRACION 
--
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_administracion()
BEGIN
    SELECT
        s.ID_SOLICITUD,
        s.FECHA_CONSULTA,
        s.REGISTRADO_POR,
        s.NUMERO_SOLICITUD,
        s.AREA,
        s.RES_INCIDENCIA,
        s.REQUERIMIENTOS,
        s.INFORME AS INFORME_SOLICITUD,
		-- Nuevos campos de solicitudes
        s.REQUERIMIENTO_2,
        s.FECHA_REQUERIMIENTO_2,
        s.REQUERIMIENTO_3,
        s.FECHA_REQUERIMIENTO_3,
        s.INFORME_2,
        s.FECHA_INFORME_2,
        s.INFORME_3,
        s.FECHA_INFORME_3,
		--
        s.AREA_RECEPCION,
        r.ID_RESPUESTA,
        r.FECHA_RESPUESTA,
        r.RESPONDIDO_POR,
        r.RESPUESTA AS RESPUESTA_R,
        r.INFORME AS INFORME_RESPUESTA,
        s.ESTADO,
        -- Agrupa las reprogramaciones en un array JSON
        (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'ID_REPROGRAMACION', rp.ID_REPROGRAMACION,
                    'FECHA_REPROGRAMACION', rp.FECHA_REPROGRAMACION,
                    'RESPUESTA_REPROG', rp.RESPUESTA,
                    'FH_RESPUESTA', rp.FH_RESPUESTA,
                    'INFORME_REPROG', rp.INFORME,
                    'FH_INFORME', rp.FH_INFORME
                )
            )
            FROM reprogramaciones rp
            WHERE rp.ID_RESPUESTA = r.ID_RESPUESTA
        ) AS REPROGRAMACIONES
    FROM solicitudes s
    LEFT JOIN respuestas r ON s.ID_SOLICITUD = r.ID_SOLICITUD
    WHERE s.AREA_RECEPCION = 'ADMINISTRACION'
    ORDER BY s.FECHA_CONSULTA DESC;
END$$
DELIMITER ;
--
CALL sp_listado_solicitudes_respuestas_administracion();
--