-- PROCEDIMIENTOS ALMACENADOS SOLICITUDES/INCIDENCIAS (PARA LISTADOD DE SOLICITUDES POR AREA)

sp_listado_solicitudes_respuestas_administracion;

CREATE DEFINER=`Edgar`@`%` PROCEDURE `sp_listado_solicitudes_respuestas_administracion`()
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
END


-----------------------------------------------------------------------
sp_listado_solicitudes_respuestas_facturacion;

CREATE DEFINER=`Edgar`@`%` PROCEDURE `sp_listado_solicitudes_respuestas_facturacion`()
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
END
-----------------------------------------------------------------------

sp_listado_solicitudes_respuestas_gerencia

CREATE DEFINER=`Edgar`@`%` PROCEDURE `sp_listado_solicitudes_respuestas_gerencia`()
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
END

-----------------------------------------------------------------------
sp_listado_solicitudes_respuestas_importacion

CREATE DEFINER=`Edgar`@`%` PROCEDURE `sp_listado_solicitudes_respuestas_importacion`()
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
END

-----------------------------------------------------------------------
sp_listado_solicitudes_respuestas_logistica

CREATE DEFINER=`Edgar`@`%` PROCEDURE `sp_listado_solicitudes_respuestas_logistica`()
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
END
-----------------------------------------------------------------------
sp_listado_solicitudes_respuestas_marketing

CREATE DEFINER=`Edgar`@`%` PROCEDURE `sp_listado_solicitudes_respuestas_marketing`()
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
END

-----------------------------------------------------------------------

sp_listado_solicitudes_respuestas_rrhh

CREATE DEFINER=`Edgar`@`%` PROCEDURE `sp_listado_solicitudes_respuestas_rrhh`()
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
END


sp_listado_solicitudes_respuestas_sistemas

CREATE DEFINER=`Edgar`@`%` PROCEDURE `sp_listado_solicitudes_respuestas_sistemas`()
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
END

-----------------------------------------------------------------------

sp_listado_solicitudes_respuestas_ventas

CREATE DEFINER=`Edgar`@`%` PROCEDURE `sp_listado_solicitudes_respuestas_ventas`()
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
END

