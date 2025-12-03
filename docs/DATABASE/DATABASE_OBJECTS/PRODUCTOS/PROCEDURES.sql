USE Zeus_Safety_Data_Integration;

-- ============================================
-- PROCEDIMIENTO 1: EXTRACCIÓN GENERAL
-- ============================================

DELIMITER $$

DROP PROCEDURE IF EXISTS extraccion_productos_2026 $$
CREATE PROCEDURE extraccion_productos_2026(IN METHOD VARCHAR(50))
BEGIN
    IF METHOD = 'LISTADO_NORMAL' THEN
        
        SELECT NOMBRE, CODIGO 
        FROM productos 
        WHERE ESTADO = 1 
        ORDER BY NOMBRE;

    ELSEIF METHOD = 'LISTADO_INVENTARIO' THEN

        SELECT ID, NOMBRE, CODIGO, UNIDAD_MEDIDA 
        FROM productos 
        WHERE ESTADO = 1 
        ORDER BY NOMBRE;

    END IF;
END $$

DELIMITER ;



-- ============================================
-- PROCEDIMIENTO 2: LISTADO GENERAL
-- ============================================

DELIMITER $$

DROP PROCEDURE IF EXISTS listar_productos_general $$
CREATE PROCEDURE listar_productos_general()
BEGIN
    SELECT 
        ID,
        NOMBRE,
        CODIGO,
        UNIDAD_MEDIDA,
        ESTADO
    FROM productos
    ORDER BY NOMBRE;
END $$

DELIMITER ;



-- ============================================
-- PROCEDIMIENTO 3: BUSCAR POR LIKE
-- ============================================

DELIMITER $$

DROP PROCEDURE IF EXISTS listar_producto_nombre_codigo $$
CREATE PROCEDURE listar_producto_nombre_codigo(IN BUSQUEDA VARCHAR(100))
BEGIN
    SELECT 
        NOMBRE,
        CODIGO
    FROM productos
    WHERE ESTADO = 1
      AND (NOMBRE LIKE CONCAT('%', BUSQUEDA, '%')
        OR CODIGO LIKE CONCAT('%', BUSQUEDA, '%'))
    ORDER BY NOMBRE;
END $$

DELIMITER ;



-- ============================================
-- PROCEDIMIENTO 4: CRUD PRODUCTOS
-- ============================================

DELIMITER $$

DROP PROCEDURE IF EXISTS crud_productos $$
CREATE PROCEDURE crud_productos(
    IN P_ID INT,
    IN P_NOMBRE VARCHAR(200),
    IN P_CODIGO VARCHAR(100),
    IN P_UNIDAD_MEDIDA VARCHAR(50),
    IN P_ESTADO TINYINT
)
BEGIN
    IF P_ID = 0 THEN
        
        INSERT INTO productos (NOMBRE, CODIGO, UNIDAD_MEDIDA, ESTADO)
        VALUES (P_NOMBRE, P_CODIGO, P_UNIDAD_MEDIDA, 1);

    ELSE
        
        UPDATE productos
        SET 
            NOMBRE = P_NOMBRE,
            CODIGO = P_CODIGO,
            UNIDAD_MEDIDA = P_UNIDAD_MEDIDA,
            ESTADO = P_ESTADO
        WHERE ID = P_ID;

    END IF;
END $$

DELIMITER ;

SELECT DISTINCT UNIDAD_MEDIDA FROM productos;

-- Nuevo paso (corrigiendo)
CREATE TABLE productos_backup AS SELECT * FROM productos;

ALTER TABLE productos
ADD COLUMN unidad_new VARCHAR(50) NULL;

UPDATE productos
SET unidad_new = UNIDAD_MEDIDA;

UPDATE productos
SET unidad_new = TRIM(UPPER(unidad_new))
WHERE unidad_new IS NOT NULL;

UPDATE productos
SET unidad_new = CASE
    WHEN unidad_new IN ('KG','KILO','KILOS','KILOGRAMO','KILOGRAMOS') THEN 'KG'
    WHEN unidad_new IN ('UNIDAD','UNI','UND','UN') THEN 'UNIDAD'
    ELSE 'UNIDAD'
END;

SELECT DISTINCT unidad_new FROM productos;

ALTER TABLE productos DROP COLUMN UNIDAD_MEDIDA;

ALTER TABLE productos 
CHANGE unidad_new UNIDAD_MEDIDA VARCHAR(50) NULL;

ALTER TABLE productos 
MODIFY UNIDAD_MEDIDA ENUM('UNIDAD', 'KG') NOT NULL;

DELIMITER $$
DROP PROCEDURE IF EXISTS listar_productos_general $$
CREATE PROCEDURE listar_productos_general()
BEGIN
    SELECT ID, NOMBRE, CODIGO, UNIDAD_MEDIDA, ESTADO
    FROM productos
    ORDER BY NOMBRE;
END $$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS listar_producto_nombre_codigo $$
CREATE PROCEDURE listar_producto_nombre_codigo(IN BUSQUEDA VARCHAR(100))
BEGIN
    SELECT NOMBRE, CODIGO
    FROM productos
    WHERE ESTADO = 1
      AND (NOMBRE LIKE CONCAT('%', BUSQUEDA, '%')
        OR CODIGO LIKE CONCAT('%', BUSQUEDA, '%'))
    ORDER BY NOMBRE;
END $$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS crud_productos $$
CREATE PROCEDURE crud_productos(
    IN P_ID INT,
    IN P_NOMBRE VARCHAR(200),
    IN P_CODIGO VARCHAR(100),
    IN P_UNIDAD_MEDIDA VARCHAR(50),
    IN P_ESTADO TINYINT
)
BEGIN
    IF P_ID = 0 THEN
        INSERT INTO productos (NOMBRE, CODIGO, UNIDAD_MEDIDA, ESTADO)
        VALUES (P_NOMBRE, P_CODIGO, P_UNIDAD_MEDIDA, 1);
    ELSE
        UPDATE productos
        SET NOMBRE = P_NOMBRE,
            CODIGO = P_CODIGO,
            UNIDAD_MEDIDA = P_UNIDAD_MEDIDA,
            ESTADO = P_ESTADO
        WHERE ID = P_ID;
    END IF;
END $$
DELIMITER ;

CALL crud_productos(0, 'Producto Test', 'PRD999', 'KG', 1);

CALL crud_productos(5, 'Producto Modificado', 'PRD555', 'UNIDAD', 1);

SHOW CREATE TABLE productos;
