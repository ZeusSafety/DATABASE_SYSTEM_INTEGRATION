use Zeus_Safety_Data_Integration;
########################################
-- PROCEDIMIENTO INCIDENCIAS IMPORTACIÓN
########################################
DELIMITER $$
DROP PROCEDURE IF EXISTS extraccion_importacion $$
CREATE PROCEDURE extraccion_importacion(IN AREA_IN VARCHAR(30))
BEGIN
    -- -----> PROCEDIMIENTO PARA VISTAS DE IMPORTACIÓN
    IF AREA_IN = 'IMPORTACION' THEN
        SELECT NOW();
    -- -----> PROCEDIMIENTO PARA VISTAS DE IMPORTACIÓN
    ELSEIF AREA_IN = 'LOGISTICA' THEN
        WITH pdf as (
                SELECT ID,NUMERO_DESPACHO, ARCHIVO_PDF FROM ficha_importacion
                WHERE ESTADO = 1
                                )
                SELECT ID_IMPORTACIONES,FECHA_REGISTRO,	I.NUMERO_DESPACHO,	RESPONSABLE,	PRODUCTOS,	ficha.ARCHIVO_PDF as ARCHIVO_PDF_URL,	FECHA_LLEGADA_PRODUCTOS,	I.TIPO_CARGA, ESTADO_IMPORTACION,	CANAL,	FECHA_RECEPCION, FECHA_ALMACEN,	INCIDENCIAS, INCIDENCIA_REGISTRO 
                                FROM IMPORTACIONES as I
                                inner join ficha_importacion AS ficha
                                                ON ficha.ID = (SELECT MAX(ID) FROM pdf
                                                        WHERE NUMERO_DESPACHO=I.NUMERO_DESPACHO
                                                        ORDER BY ID DESC)
                                                WHERE I.ESTADO = 1
                                ORDER BY FECHA_REGISTRO DESC 
                                LIMIT 20;
    -- -----> PROCEDIMIENTO PARA VISTAS DE IMPORTACIÓN
    ELSEIF AREA_IN = "FACTURACION" THEN
     WITH pdf as (
                SELECT ID,NUMERO_DESPACHO, ARCHIVO_PDF FROM ficha_importacion
                WHERE ESTADO = 1
                                )
                SELECT I.ID_IMPORTACIONES, I.FECHA_REGISTRO,I.NUMERO_DESPACHO, ficha.ARCHIVO_PDF as ARCHIVO_PDF_URL, INCIDENCIAS, INCIDENCIA_REGISTRO, inci.ESTADO_INCIDENCIA AS ESTADO_VERIFICACION,ESTADO_REGISTRO_FACTURACION, FECHA_REGISTRO_FACTURACION, OBSERVACIONES_FACTURACION
                                FROM IMPORTACIONES  as I
                                inner join ficha_importacion AS ficha
                                                ON ficha.ID = (SELECT MAX(ID) FROM pdf
                                                        WHERE NUMERO_DESPACHO=I.NUMERO_DESPACHO
                                                        ORDER BY ID DESC)
                                -- inner join unir con incidencias (primero vaciar las tablas)
                                left join incidencia_importacion as inci
                                ON I.ID_IMPORTACIONES = inci.ID_IMPORTACIONES
                                                WHERE I.ESTADO = 1
                                                ORDER BY FECHA_REGISTRO DESC;
    ELSE
        WITH pdf as (
                SELECT ID,NUMERO_DESPACHO, ARCHIVO_PDF FROM ficha_importacion
                WHERE ESTADO = 1
                 )
                SELECT I.ID_IMPORTACIONES,FECHA_REGISTRO,I.NUMERO_DESPACHO, RESPONSABLE, PRODUCTOS,ficha.ARCHIVO_PDF as ARCHIVO_PDF_URL, FECHA_LLEGADA_PRODUCTOS,I.TIPO_CARGA, I.FECHA_ALMACEN,ESTADO_IMPORTACION, CANAL,FECHA_RECEPCION,INCIDENCIAS
                                FROM IMPORTACIONES as I
                                inner join ficha_importacion AS ficha
                                ON ficha.ID = (SELECT MAX(ID) FROM pdf
                                        WHERE NUMERO_DESPACHO=I.NUMERO_DESPACHO
                                        ORDER BY ID DESC)
                                WHERE I.ESTADO = 1
                                ORDER BY FECHA_REGISTRO DESC 
                                LIMIT 20;
    END IF;
END $$
DELIMITER ;



DROP PROCEDURE IF EXISTS extraccion_importacion_2026;
DELIMITER $$
CREATE PROCEDURE extraccion_importacion_2026(IN AREA_IN VARCHAR(30))
BEGIN
    -- -----> PROCEDIMIENTO PARA VISTAS DE IMPORTACIÓN
    IF AREA_IN = 'IMPORTACION' THEN
        SELECT NOW();
    -- -----> PROCEDIMIENTO PARA VISTAS DE IMPORTACIÓN
    ELSEIF AREA_IN = 'LOGISTICA' THEN
        WITH pdf as (
                SELECT ID,NUMERO_DESPACHO, ARCHIVO_PDF FROM ficha_importacion
                WHERE ESTADO = 1
                                )
                SELECT ID_IMPORTACIONES,FECHA_REGISTRO,	I.NUMERO_DESPACHO,	RESPONSABLE,	PRODUCTOS,	ficha.ARCHIVO_PDF as ARCHIVO_PDF_URL,	FECHA_LLEGADA_PRODUCTOS,	I.TIPO_CARGA, ESTADO_IMPORTACION,	CANAL,	FECHA_RECEPCION, FECHA_ALMACEN,	INCIDENCIAS, INCIDENCIA_REGISTRO 
                                FROM IMPORTACIONES as I
                                inner join ficha_importacion AS ficha
                                                ON ficha.ID = (SELECT MAX(ID) FROM pdf
                                                        WHERE NUMERO_DESPACHO=I.NUMERO_DESPACHO
                                                        ORDER BY ID DESC)
                                                WHERE I.ESTADO = 1
                                ORDER BY FECHA_REGISTRO DESC 
                                LIMIT 20;
    -- -----> PROCEDIMIENTO PARA VISTAS DE IMPORTACIÓN
    ELSEIF AREA_IN = "FACTURACION" THEN
     WITH pdf as (
                SELECT ID,NUMERO_DESPACHO, ARCHIVO_PDF FROM ficha_importacion
                WHERE ESTADO = 1
                                )
                SELECT I.ID_IMPORTACIONES, I.FECHA_REGISTRO,I.NUMERO_DESPACHO, ficha.ARCHIVO_PDF as ARCHIVO_PDF_URL, INCIDENCIAS, INCIDENCIA_REGISTRO, inci.ESTADO_INCIDENCIA AS ESTADO_VERIFICACION,ESTADO_REGISTRO_FACTURACION, FECHA_REGISTRO_FACTURACION, OBSERVACIONES_FACTURACION
                                FROM IMPORTACIONES  as I
                                inner join ficha_importacion AS ficha
                                                ON ficha.ID = (SELECT MAX(ID) FROM pdf
                                                        WHERE NUMERO_DESPACHO=I.NUMERO_DESPACHO
                                                        ORDER BY ID DESC)
                                -- inner join unir con incidencias (primero vaciar las tablas)
                                left join incidencia_importacion as inci
                                ON I.ID_IMPORTACIONES = inci.ID_IMPORTACIONES
                                                WHERE I.ESTADO = 1
                                                ORDER BY FECHA_REGISTRO DESC;
    ELSE
        WITH pdf as (
                SELECT ID,NUMERO_DESPACHO, ARCHIVO_PDF FROM ficha_importacion
                WHERE ESTADO = 1
                 )
                SELECT I.ID_IMPORTACIONES,FECHA_REGISTRO,I.NUMERO_DESPACHO, RESPONSABLE, PRODUCTOS,ficha.ARCHIVO_PDF as ARCHIVO_PDF_URL, FECHA_LLEGADA_PRODUCTOS,I.TIPO_CARGA, I.FECHA_ALMACEN,ESTADO_IMPORTACION, CANAL,FECHA_RECEPCION,INCIDENCIAS
                                FROM IMPORTACIONES as I
                                inner join ficha_importacion AS ficha
                                ON ficha.ID = (SELECT MAX(ID) FROM pdf
                                        WHERE NUMERO_DESPACHO=I.NUMERO_DESPACHO
                                        ORDER BY ID DESC)
                                WHERE I.ESTADO = 1
                                ORDER BY FECHA_REGISTRO DESC 
                                LIMIT 20;
    END IF;
END $$
DELIMITER ;