/* ============================================================
   ALTER TABLE: Nuevos campos para requerimientos e informes
============================================================ */
ALTER TABLE solicitudes
ADD REQUERIMIENTO_2 TEXT,
ADD FECHA_REQUERIMIENTO_2 DATETIME,
ADD INFORME_2 VARCHAR(255),
ADD FECHA_INFORME_2 DATETIME,
ADD REQUERIMIENTO_3 TEXT,
ADD FECHA_REQUERIMIENTO_3 DATETIME,
ADD INFORME_3 VARCHAR(255),
ADD FECHA_INFORME_3 DATETIME;

---------------------------------------------------------------
-- PROCEDIMIENTO: ACTUALIZAR REQUERIMIENTOS/INFORMES
---------------------------------------------------------------
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

    SELECT REQUERIMIENTO_2, INFORME_2, REQUERIMIENTO_3, INFORME_3
    INTO v_requerimiento2, v_informe2, v_requerimiento3, v_informe3
    FROM solicitudes
    WHERE ID_SOLICITUD = p_id_solicitud;

    IF NULLIF(TRIM(p_requerimiento2),'') IS NOT NULL
       AND p_requerimiento2 <> IFNULL(v_requerimiento2,'') THEN
        UPDATE solicitudes
        SET REQUERIMIENTO_2 = p_requerimiento2,
            FECHA_REQUERIMIENTO_2 = NOW()
        WHERE ID_SOLICITUD = p_id_solicitud;
    END IF;

    IF NULLIF(TRIM(p_informe2),'') IS NOT NULL
       AND p_informe2 <> IFNULL(v_informe2,'') THEN
        UPDATE solicitudes
        SET INFORME_2 = p_informe2,
            FECHA_INFORME_2 = NOW()
        WHERE ID_SOLICITUD = p_id_solicitud;
    END IF;

    IF NULLIF(TRIM(p_requerimiento3),'') IS NOT NULL
       AND p_requerimiento3 <> IFNULL(v_requerimiento3,'') THEN
        UPDATE solicitudes
        SET REQUERIMIENTO_3 = p_requerimiento3,
            FECHA_REQUERIMIENTO_3 = NOW()
        WHERE ID_SOLICITUD = p_id_solicitud;
    END IF;

    IF NULLIF(TRIM(p_informe3),'') IS NOT NULL
       AND p_informe3 <> IFNULL(v_informe3,'') THEN
        UPDATE solicitudes
        SET INFORME_3 = p_informe3,
            FECHA_INFORME_3 = NOW()
        WHERE ID_SOLICITUD = p_id_solicitud;
    END IF;

END$$

DELIMITER ;

---------------------------------------------------------------
-- PROTOTIPO BASE PARA LISTADOS (REUTILIZADO EN TODOS LOS SP)
---------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE sp_listado_solicitudes_respuestas_base (IN p_area VARCHAR(100))
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
        s.REQUERIMIENTO_2,
        s.FECHA_REQUERIMIENTO_2,
        s.REQUERIMIENTO_3,
        s.FECHA_REQUERIMIENTO_3,
        s.INFORME_2,
        s.FECHA_INFORME_2,
        s.INFORME_3,
        s.FECHA_INFORME_3,
        s.AREA_RECEPCION,
        r.ID_RESPUESTA,
        r.FECHA_RESPUESTA,
        r.RESPONDIDO_POR,
        r.RESPUESTA AS RESPUESTA_R,
        r.INFORME AS INFORME_RESPUESTA,
        s.ESTADO,
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
    WHERE (p_area IS NULL OR s.AREA_RECEPCION = p_area)
    ORDER BY s.FECHA_CONSULTA DESC;
END$$

DELIMITER ;

---------------------------------------------------------------
-- SP PRINCIPAL (SIN FILTRO)
---------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE sp_listado_solicitudes_respuestas()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base(NULL);
END$$

DELIMITER ;

---------------------------------------------------------------
-- SP POR ÁREA RECEPCIÓN
---------------------------------------------------------------

/* SISTEMAS */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_sistemas()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('SISTEMAS');
END$$
DELIMITER ;

/* VENTAS */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_ventas()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('VENTAS');
END$$
DELIMITER ;

/* RRHH */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_rrhh()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('RRHH');
END$$
DELIMITER ;

/* MARKETING */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_marketing()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('MARKETING');
END$$
DELIMITER ;

/* LOGISTICA */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_logistica()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('LOGISTICA');
END$$
DELIMITER ;

/* IMPORTACION */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_importacion()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('IMPORTACION');
END$$
DELIMITER ;

/* EXPORTACION */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_exportacion()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('EXPORTACION');
END$$
DELIMITER ;

/* CONTABILIDAD */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_contabilidad()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('CONTABILIDAD');
END$$
DELIMITER ;

/* ATENCION AL CLIENTE */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_atencion()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('ATENCION AL CLIENTE');
END$$
DELIMITER ;

/* PRODUCCION */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_produccion()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('PRODUCCION');
END$$
DELIMITER ;

/* CALIDAD */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_calidad()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('CALIDAD');
END$$
DELIMITER ;

/* MANTENIMIENTO */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_mantenimiento()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('MANTENIMIENTO');
END$$
DELIMITER ;

/* SEGURIDAD INDUSTRIAL */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_seguridad()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('SEGURIDAD INDUSTRIAL');
END$$
DELIMITER ;

/* OTROS */
DELIMITER $$
CREATE PROCEDURE sp_listado_solicitudes_respuestas_otros()
BEGIN
    CALL sp_listado_solicitudes_respuestas_base('OTROS');
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS PRODUCTOS_PAGINA_ESTATICA;
DELIMITER $$;
CREATE PROCEDURE PRODUCTOS_PAGINA_ESTATICA(IN METHOD VARCHAR(30))
BEGIN
	IF METHOD = "LISTADO_FRANJA_PRECIOS" THEN
        SELECT ID, NOMBRE, CATEGORIA, TIPO_PRODUCTO, COLOR_TIPO, PARES_POR_CAJA, FICHA_TECNICA_ENLACE, IMG_URL
		FROM productos
		WHERE ESTADO = 1;
    END IF;
END $$;
DELIMITER ;

select * from productos limit 20;
CALL PRODUCTOS_PAGINA_ESTATICA("LISTADO_FRANJA_PRECIOS")