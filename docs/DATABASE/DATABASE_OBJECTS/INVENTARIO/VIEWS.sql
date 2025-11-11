-- #########################################################
-- #########################################################
-- #########################################################
CREATE VIEW LISTADO_CONTEOS_VISTA AS
WITH ALMACENX AS (
    SELECT 
        T.ID_PUNTO_OPERACION AS ID_TIENDA,
        PA.NOMBRE AS NOMBRE_ALMACEN
    FROM TIENDAS AS T
    INNER JOIN ALMACENES AS A ON T.ID_ALMACEN = A.ID
    INNER JOIN PUNTO_OPERACION AS PA ON PA.ID = A.ID_PUNTO_OPERACION
)
SELECT 
    L.ID AS ID,
    L.FECHA_INICIO,
    L.FECHA_FINAL,
    I.NOMBRE,
    O.NOMBRE AS REGISTRADO_POR,
    P.NOMBRE AS PUNTO_OPERACION,
    COALESCE(A.NOMBRE_ALMACEN, P.NOMBRE) AS ALMACEN, -- fallback si es un almacén directo
    P.TIPO,
    L.LINK_ARCHIVO_PDF
FROM LISTADO_CONTEOS AS L
INNER JOIN INVENTARIO AS I ON I.ID = L.ID_INVENTARIO
INNER JOIN PUNTO_OPERACION AS P ON P.ID = L.ID_PUNTO_OPERACION
INNER JOIN colaboradores AS O ON O.ID_PERSONA = L.REGISTRADO_POR_ID
LEFT JOIN ALMACENX AS A ON A.ID_TIENDA = P.ID
WHERE L.ESTADO = 1;
-- #########################################################
-- #########################################################
-- #########################################################
DROP VIEW IF EXISTS TIENDAS_VISTA;
CREATE VIEW TIENDAS_VISTA AS
with ALMACENX AS(
SELECT P.ID, P.NOMBRE FROM PUNTO_OPERACION AS P
INNER JOIN ALMACENES AS A
ON P.ID = A.ID_PUNTO_OPERACION
)
SELECT P.ID, P.NOMBRE, P.TIPO,X.NOMBRE AS ALMACEN FROM TIENDAS AS T
INNER JOIN PUNTO_OPERACION AS P
ON T.ID_PUNTO_OPERACION = P.ID
-- JOIN CON EL WITH
INNER JOIN ALMACENX AS X
ON X.ID = T.ID_ALMACEN
WHERE T.ESTADO = 1;
-- #########################################################
-- #########################################################
-- #########################################################
CREATE OR REPLACE VIEW VISTA_PERMISOS_COLABORADORES AS
SELECT C.ID_PERSONA, C.NOMBRE, A.NOMBRE AS AREA, C.ID_ROL
from colaboradores as C
inner join AREAS AS A
ON C.AREA_PRINCIPAL = A.ID
WHERE C.ESTADO = 1
AND C.CULMINACION = "ACTUALMENTE";