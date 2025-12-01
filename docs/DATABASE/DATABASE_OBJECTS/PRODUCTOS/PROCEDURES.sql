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
CALL extraccion_productos_2026('LISTADO_NORMAL');

-- xd
-- tundique

use Zeus_Safety_Data_Integration;