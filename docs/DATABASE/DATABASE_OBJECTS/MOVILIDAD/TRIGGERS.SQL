-- CREACION DE TABLA GESTION DE COMBUSTIBLE 
USE Zeus_Safety_Data_Integration;

-- TABLA PRINCIPAL
CREATE TABLE REGISTRO_VIAJE (
    id_viaje INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    vehiculo VARCHAR(50),
    conductor VARCHAR(100),
    km_inicial INT,
    km_final INT,
    miembros_vehiculo TEXT, -- Aquí puedes guardar los nombres separados por comas
    esta_limpio BOOLEAN,
    en_buen_estado BOOLEAN,
    descripcion_estado TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLA DETALLE DEL COMBUSTIBLE
CREATE TABLE DETALLE_COMBUSTIBLE (
    id_combustible INT AUTO_INCREMENT PRIMARY KEY,
    id_viaje INT NOT NULL, -- Relación con la tabla principal
    tipo_combustible ENUM('Petróleo', 'Gasolina', 'Gas GNV', 'Gas GLP'),
    precio_total DECIMAL(10,2),
    precio_unitario DECIMAL(10,2),
    url_comprobante VARCHAR(255),
    FOREIGN KEY (id_viaje) REFERENCES REGISTRO_VIAJE(id_viaje) ON DELETE CASCADE
);

-- TABLA DETALLE DE LA COCHERA
CREATE TABLE DETALLE_COCHERA (
    id_cochera INT AUTO_INCREMENT PRIMARY KEY,
    id_viaje INT NOT NULL,
    monto_pagado DECIMAL(10,2),
    url_comprobante VARCHAR(255),
    FOREIGN KEY (id_viaje) REFERENCES REGISTRO_VIAJE(id_viaje) ON DELETE CASCADE
);

-- Agregar columna pagado_cochera a REGISTRO_VIAJE
ALTER TABLE REGISTRO_VIAJE 
ADD COLUMN pagado_cochera BOOLEAN DEFAULT FALSE;

-- Agregar columna tiempo_uso a DETALLE_COCHERA
ALTER TABLE DETALLE_COCHERA 
ADD COLUMN tiempo_uso VARCHAR(50);

-- PARA LA INSERCCIÓN
-- Escenario 1: El flujo completo (Llenó combustible y pagó cochera)
-- 1. Insertamos el viaje principal
INSERT INTO REGISTRO_VIAJE (fecha, vehiculo, conductor, km_inicial, km_final, miembros_vehiculo, esta_limpio, en_buen_estado, descripcion_estado)
VALUES ('2026-01-14', 'Apolo', 'Manuel', 10500, 10650, 'Manuel, Jhonson, Victor', 1, 1, NULL);

-- 2. Obtenemos el ID generado (suponiendo que es el ID 1) e insertamos combustible
INSERT INTO DETALLE_COMBUSTIBLE (id_viaje, tipo_combustible, precio_total, precio_unitario, url_comprobante)
VALUES (2, 'Gas GNV', 45.50, 1.55, 'facturas/combustible_001.jpg');

-- 3. Insertamos el pago de la cochera para el mismo viaje
INSERT INTO DETALLE_COCHERA (id_viaje, monto_pagado, url_comprobante)
VALUES (1, 10.00, 'facturas/cochera_001.jpg');


-- Escenario 2: Solo combustible (Marcó "No" en cochera)
-- 1. Insertamos el viaje
INSERT INTO REGISTRO_VIAJE (fecha, vehiculo, conductor, km_inicial, km_final, miembros_vehiculo, esta_limpio, en_buen_estado, descripcion_estado)
VALUES ('2026-01-14', 'Ares', 'Jhosep', 8200, 8300, 'Jhosep, Victor', 0, 1, NULL);

-- 2. Insertamos combustible (suponiendo que el ID generado es el 2)
INSERT INTO DETALLE_COMBUSTIBLE (id_viaje, tipo_combustible, precio_total, precio_unitario, url_comprobante)
VALUES (2, 'Gasolina', 120.00, 18.50, 'facturas/combustible_002.jpg');

-- Nota: Como no pagó cochera, simplemente NO se hace el insert en DETALLE_COCHERA.

--  Escenario 3: 
-- 1. Insertamos el viaje con descripción de daño
INSERT INTO REGISTRO_VIAJE (fecha, vehiculo, conductor, km_inicial, km_final, miembros_vehiculo, esta_limpio, en_buen_estado, descripcion_estado)
VALUES ('2026-01-14', 'Poseidon', 'Hervin', 15000, 15010, 'Hervin', 1, 0, 'Raspadura leve en el parachoques trasero izquierdo');

-- Nota: Aquí termina el proceso. No hay inserts en las otras tablas.

-- PARA VER TODA LA INFORMACIÓN
SELECT 
    V.id_viaje, V.vehiculo, V.conductor, 
    C.tipo_combustible, C.precio_total AS gasto_gas,
    P.monto_pagado AS gasto_cochera
FROM REGISTRO_VIAJE V
LEFT JOIN DETALLE_COMBUSTIBLE C ON V.id_viaje = C.id_viaje
LEFT JOIN DETALLE_COCHERA P ON V.id_viaje = P.id_viaje;

select * from REGISTRO_VIAJE;

-- Ver todos los registros con todos los detalles (consulta principal)
SELECT 
    V.id_viaje,
    V.fecha,
    V.vehiculo,
    V.conductor,
    V.km_inicial,
    V.km_final,
    V.miembros_vehiculo,
    V.esta_limpio,
    V.en_buen_estado,
    V.descripcion_estado,
    V.fecha_registro,
    C.tipo_combustible,
    V.pagado_cochera,  -- Corregido: punto en lugar de guion
    C.precio_total AS gasto_gas,
    C.precio_unitario,
    C.url_comprobante AS url_combustible,
    P.monto_pagado AS gasto_cochera,
    P.tiempo_uso,  -- Este campo está en DETALLE_COCHERA
    P.url_comprobante AS url_cochera
FROM REGISTRO_VIAJE V
LEFT JOIN DETALLE_COMBUSTIBLE C ON V.id_viaje = C.id_viaje
LEFT JOIN DETALLE_COCHERA P ON V.id_viaje = P.id_viaje
ORDER BY V.fecha_registro DESC
LIMIT 0, 50;

-- Ver solo registros con combustible (útil para verificar el tipo)
SELECT 
    V.id_viaje,
    V.fecha,
    V.vehiculo,
    V.conductor,
    C.tipo_combustible,
    C.precio_total,
    C.precio_unitario,
    C.url_comprobante
FROM REGISTRO_VIAJE V
INNER JOIN DETALLE_COMBUSTIBLE C ON V.id_viaje = C.id_viaje
ORDER BY V.fecha_registro DESC;

-- Ver registros específicos de "Gas GNV"
SELECT 
    V.id_viaje,
    V.fecha,
    V.vehiculo,
    V.conductor,
    C.tipo_combustible,
    C.precio_total,
    C.precio_unitario
FROM REGISTRO_VIAJE V
INNER JOIN DETALLE_COMBUSTIBLE C ON V.id_viaje = C.id_viaje
WHERE C.tipo_combustible = 'Gas GNV'
ORDER BY V.fecha_registro DESC;

-- Ver conteo por tipo de combustible
SELECT 
    tipo_combustible,
    COUNT(*) as cantidad,
    SUM(precio_total) as total_gastado,
    AVG(precio_unitario) as precio_promedio
FROM DETALLE_COMBUSTIBLE
GROUP BY tipo_combustible;

-- Ver los últimos 10 registros
SELECT 
    V.id_viaje,
    V.fecha,
    V.vehiculo,
    V.conductor,
    C.tipo_combustible,
    C.precio_total,
    P.monto_pagado
FROM REGISTRO_VIAJE V
LEFT JOIN DETALLE_COMBUSTIBLE C ON V.id_viaje = C.id_viaje
LEFT JOIN DETALLE_COCHERA P ON V.id_viaje = P.id_viaje
ORDER BY V.fecha_registro DESC
LIMIT 10;

-- ver solo la tabla principal
SELECT * FROM REGISTRO_VIAJE ORDER BY fecha_registro DESC;

-- ver solo combustibles
SELECT * FROM DETALLE_COMBUSTIBLE ORDER BY id_combustible DESC;

-- ver solo cocheras
SELECT * FROM DETALLE_COCHERA ORDER BY id_cochera DESC;

SELECT * FROM REGISTRO_VIAJE
ORDER BY fecha DESC, id_viaje DESC;

-- Ver los últimos 200 registros
SELECT * FROM REGISTRO_VIAJE
ORDER BY id_viaje DESC
LIMIT 200;

-- Ver por vehículo específico
SELECT * FROM REGISTRO_VIAJE
WHERE vehículo = 'Apolo'
ORDER BY fecha DESC;

-- Ver registros con pagado_cochera = 1
SELECT * FROM REGISTRO_VIAJE
WHERE pagado_cochera = 1
ORDER BY id_viaje DESC;

-- 1. Ver los 97 registros que faltan (IDs 1-97)
SELECT * FROM REGISTRO_VIAJE
WHERE id_viaje BETWEEN 1 AND 97
ORDER BY id_viaje DESC;

-- 2. Ver cuántos registros hay en total realmente
SELECT COUNT(*) as total_real FROM REGISTRO_VIAJE;

-- 3. Ver el ID mínimo real
SELECT MIN(id_viaje) as minimo_id_real FROM REGISTRO_VIAJE;

-- 4. Ver todos ordenados desde el más antiguo
SELECT * FROM REGISTRO_VIAJE
ORDER BY id_viaje ASC
LIMIT 100;  -- Primera página

SELECT 
    MIN(id_viaje) as id_minimo,
    MAX(id_viaje) as id_maximo,
    COUNT(*) as total_registros,
    COUNT(DISTINCT id_viaje) as ids_unicos,
    DATEDIFF(MAX(fecha), MIN(fecha)) as dias_cubiertos
FROM REGISTRO_VIAJE;