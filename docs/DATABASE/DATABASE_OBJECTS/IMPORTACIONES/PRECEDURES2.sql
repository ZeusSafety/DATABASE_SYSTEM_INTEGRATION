Table: IMPORTACIONES
Columns:
ID_IMPORTACIONES int AI PK 
FECHA_REGISTRO datetime 
NUMERO_DESPACHO varchar(20) 
RESPONSABLE varchar(20) 
PRODUCTOS text 
ARCHIVO_PDF_URL text 
FECHA_LLEGADA_PRODUCTOS date 
TIPO_CARGA text 
ESTADO_IMPORTACION varchar(25) 
ESTADO char(1) 
CANAL varchar(20) 
FECHA_RECEPCION date 
INCIDENCIAS varchar(5) 
ESTADO_REGISTRO varchar(25) 
ESTADO_REGISTRO_FACTURACION varchar(25) 
FECHA_REGISTRO_FACTURACION datetime 
OBSERVACIONES_FACTURACION text 
INCIDENCIA_REGISTRO datetime 
FECHA_ALMACEN date

Table: ficha_importacion
Columns:
ID int AI PK 
NUMERO_DESPACHO varchar(30) 
GENERADO_POR varchar(20) 
FECHA datetime 
ARCHIVO_PDF text 
ESTADO char(1) 
FECHA_ACTUALIZACION datetime 
version_pdf int 
TIPO_CARGA varchar(30)

Table: ficha_importacion_detalle
Columns:
ID int AI PK 
ITEM int 
PRODUCTO varchar(60) 
CODIGO varchar(15) 
UNIDAD_MEDIDA varchar(15) 
CANTIDAD int 
ESTADO char(1) 
ID_FICHA_IMPORTACION int 
version_producto int

select * from IMPORTACIONES;
select * from ficha_importacion;
select * from ficha_importacion_detalle;
select * from ficha_importacion_renovacion;

-- PRECEDIMIENTOS ALAMACENADOS PARA REGISTRO DE IMPORTACIONES/LISTADO/ACTUALIZACION

DELIMITER //
CREATE PROCEDURE sp_insertar_importacion(
    IN p_fecha_registro DATETIME,
    IN p_numero_despacho VARCHAR(20),
    IN p_responsable VARCHAR(20),
    IN p_productos TEXT,
    IN p_fecha_llegada DATE,
    IN p_tipo_carga TEXT,
    IN p_estado_importacion VARCHAR(25)
)
BEGIN
    INSERT INTO IMPORTACIONES (
        FECHA_REGISTRO, NUMERO_DESPACHO, RESPONSABLE, 
        PRODUCTOS, FECHA_LLEGADA_PRODUCTOS, TIPO_CARGA, ESTADO_IMPORTACION
    )
    VALUES (p_fecha_registro, p_numero_despacho, p_responsable, 
            p_productos, p_fecha_llegada, p_tipo_carga, p_estado_importacion);
END //
--
DROP PROCEDURE IF EXISTS sp_insertar_ficha_importacion;
DELIMITER //
CREATE PROCEDURE sp_insertar_ficha_importacion(
    IN p_numero_despacho VARCHAR(30),
    IN p_tipo_carga VARCHAR(30),
    IN p_generado_por VARCHAR(20),
    IN p_fecha DATETIME,
    IN p_archivo_pdf TEXT
)
BEGIN
    INSERT INTO ficha_importacion (
        NUMERO_DESPACHO, TIPO_CARGA, GENERADO_POR, 
        FECHA, ARCHIVO_PDF, ESTADO
    )
    VALUES (
        p_numero_despacho, p_tipo_carga, p_generado_por, 
        p_fecha, p_archivo_pdf, '1'
    );
    
    -- Devolvemos el ID como un conjunto de resultados normal
    SELECT LAST_INSERT_ID() AS last_id;
END //
DELIMITER ;
--
-- PROCEDEMIENTO PARA OBTENER  Y LISTAR DESPACHO CON DETALLES --
--
DELIMITER //
CREATE PROCEDURE sp_obtener_despacho_con_detalles(IN p_numero_despacho VARCHAR(30))
BEGIN
    -- 1. Obtener la cabecera (La última ficha activa para ese despacho)
    SELECT 
        I.ID_IMPORTACIONES, 
        I.NUMERO_DESPACHO, 
        F.ARCHIVO_PDF AS ARCHIVO_PDF_URL
    FROM IMPORTACIONES I
    LEFT JOIN ficha_importacion F ON I.NUMERO_DESPACHO = F.NUMERO_DESPACHO
    WHERE I.NUMERO_DESPACHO = p_numero_despacho 
      AND I.ESTADO = 1 
      AND (F.ESTADO = 1 OR F.ESTADO IS NULL)
    ORDER BY F.ID DESC LIMIT 1;

    -- 2. Obtener los detalles de esa misma ficha
    SELECT ITEM, PRODUCTO, CODIGO, UNIDAD_MEDIDA, CANTIDAD
    FROM ficha_importacion_detalle
    WHERE ESTADO = 1 
      AND ID_FICHA_IMPORTACION = (
          SELECT MAX(ID) FROM ficha_importacion 
          WHERE NUMERO_DESPACHO = p_numero_despacho AND ESTADO = 1
      );
END //
--
-- SP PARA LISTAS FICHAS DE IMPORTACION
--
DELIMITER //
CREATE PROCEDURE sp_listar_fichas_importacion()
BEGIN
    SELECT NUMERO_DESPACHO, FECHA, TIPO_CARGA, GENERADO_POR, ARCHIVO_PDF
    FROM ficha_importacion
    WHERE ESTADO = 1
    ORDER BY FECHA DESC;
END //

--  PROCEDIMIENTOS PARA ACTUALIZAR LAS IMPORTACIONES

DELIMITER //
CREATE PROCEDURE sp_actualizar_importacion_por_area(
    IN p_area VARCHAR(20),
    IN p_id INT,
    IN p_dato1 TEXT, -- Reutilizados según el área
    IN p_dato2 TEXT,
    IN p_dato3 TEXT,
    IN p_dato4 TEXT,
    IN p_dato5 TEXT,
    IN p_dato6 TEXT
)
BEGIN
    IF p_area = 'logistica' THEN
        UPDATE IMPORTACIONES 
        SET FECHA_RECEPCION = p_dato1, 
            INCIDENCIAS = p_dato2,
            INCIDENCIA_REGISTRO = DATE_SUB(NOW(), INTERVAL 5 HOUR)
        WHERE ID_IMPORTACIONES = p_id AND ESTADO = 1;

    ELSEIF p_area = 'importacion' THEN
        UPDATE IMPORTACIONES 
        SET PRODUCTOS = p_dato1,
            FECHA_LLEGADA_PRODUCTOS = p_dato2,
            TIPO_CARGA = p_dato3,
            ESTADO_IMPORTACION = p_dato4,
            CANAL = p_dato5,
            FECHA_ALMACEN = p_dato6
        WHERE ID_IMPORTACIONES = p_id;

    ELSEIF p_area = 'facturacion' THEN
        UPDATE IMPORTACIONES 
        SET ESTADO_REGISTRO_FACTURACION = p_dato1,
            OBSERVACIONES_FACTURACION = p_dato2,
            FECHA_REGISTRO_FACTURACION = DATE_SUB(NOW(), INTERVAL 5 HOUR)
        WHERE ID_IMPORTACIONES = p_id AND ESTADO = 1;
    END IF;
END //
DELIMITER ;


