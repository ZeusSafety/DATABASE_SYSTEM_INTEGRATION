--
-- TABLAS USADAS EN LOS PROCEDIMIENTOS DE DESCUENTO CAJAS MALVINAS
--

CREATE TABLE productos (
    CODIGO VARCHAR(15) NOT NULL,
    NOMBRE VARCHAR(60),
    CATEGORIA VARCHAR(40),
    TIPO_PRODUCTO VARCHAR(40),
    COLOR_TIPO VARCHAR(40),
    TAMAÑO VARCHAR(10),
    PARES_POR_CAJA INT,
    FICHA_TECNICA_ENLACE TEXT,
    ESTADO CHAR(1),
    ID INT AUTO_INCREMENT,
    CANTIDAD_CAJAS INT,
    LIMITE_DESCUENTO_CAJAS INT,
    UNIDAD_MEDIDA_CAJAS VARCHAR(20),
    CATEGORIA_GUANTES VARCHAR(50),
    UNIDAD_MEDIDA ENUM('UNIDAD','KG'),
    PRIMARY KEY (CODIGO),
    UNIQUE KEY (ID)
) 

CREATE TABLE historial_cambios_stock (
    id_historial INT AUTO_INCREMENT PRIMARY KEY, 
    responsable VARCHAR(50) NOT NULL,           
    fecha_hora DATETIME NOT NULL,               
    id_producto INT NOT NULL,                   
    producto VARCHAR(60) NOT NULL,              
    categoria VARCHAR(40) NOT NULL,             
    cantidad_ingreso INT DEFAULT 0,             
    cantidad_salida INT DEFAULT 0,              
    cantidad_reservada INT DEFAULT 0,           
    motivo VARCHAR(800),                                
    cantidad_cajas_final INT NOT NULL,          
    FOREIGN KEY (id_producto) REFERENCES productos(ID)
);

CREATE TABLE productos_reservados (
    id_reservados INT AUTO_INCREMENT PRIMARY KEY, -- A ID_RESERVADOS (Autoincrementable)
    id_historial INT NOT NULL,                    -- B ID_HISTORIAL (Clave Foránea a historial_cambios_stock.id_historial)
    id_producto INT NOT NULL,                     -- C ID_PRODUCTO (Clave Foránea a productos.ID)
    producto VARCHAR(60) NOT NULL,                -- D PRODUCTO
    categoria VARCHAR(40) NOT NULL,               -- E CATEGORIA
    fecha_hora DATETIME NOT NULL,                 -- F FECHA_HORA
    responsable VARCHAR(50) NOT NULL,             -- G RESPONSABLE
    cantidad_reservada INT NOT NULL,              -- H CANTIDAD_RESERVADA (Cantidad actual en reserva)
    unidad_medida VARCHAR(20) NOT NULL,           -- I UNIDAD_MEDIDA

    -- Definición de Claves Foráneas
    FOREIGN KEY (id_historial) REFERENCES historial_cambios_stock(id_historial),
    FOREIGN KEY (id_producto) REFERENCES productos(ID)
);

CREATE TABLE historial_cambios_productos_reservados (
    id_historial_reservados INT AUTO_INCREMENT PRIMARY KEY, -- A ID_HISTORIAL_RESERVADOS (Autoincrementable)
    id_reservados INT NOT NULL,                             -- B ID_RESERVADOS (Clave Foránea a productos_reservados.id_reservados)
    id_producto INT NOT NULL,                               -- C ID_PRODUCTO
    producto VARCHAR(60) NOT NULL,                          -- D PRODUCTO
    categoria VARCHAR(40) NOT NULL,                         -- E CATEGORIA
    responsable VARCHAR(50) NOT NULL,                       -- F RESPONSABLE
    cantidad_salida_reserva INT DEFAULT 0,                  -- G CANTIDAD_SALIDA_RESERVA
    cantidad_regreso INT DEFAULT 0,                         -- H CANTIDAD_REGRESO
    motivo_actualizacion_hc TEXT,                           -- I MOTIVO_ACTUALIZACION_HC
    fecha_hora_actualizacion_hc DATETIME NOT NULL,          -- J FECHA_HORA_ACTUALIZACION_HC

    -- Definición de Clave Foránea
    FOREIGN KEY (id_reservados) REFERENCES productos_reservados(id_reservados)
);

CREATE TABLE actualizacion_logistica_stock (
    id_historial_logistica INT AUTO_INCREMENT PRIMARY KEY,
    responsable VARCHAR(50) NOT NULL,
    fecha_hora_logistica TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_producto INT NOT NULL,
    producto VARCHAR(60) NOT NULL,
    categoria VARCHAR(40),
    cantidad_cajas DECIMAL(10,2) NOT NULL COMMENT 'Cantidad antes de actualizar',
    cantidad_actual DECIMAL(10,2) NOT NULL COMMENT 'Cantidad después de actualizar',
    motivo TEXT,
    FOREIGN KEY (id_producto) REFERENCES productos(ID)
);