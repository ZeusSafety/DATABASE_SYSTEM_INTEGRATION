-- ============================================================================
-- SISTEMA DE INVENTARIO - BASE DE DATOS MySQL
-- ============================================================================
-- 
-- ============================================================================
-- TABLA: productos
-- Descripción: Catálogo maestro de productos pre-cargados en el sistema
-- ============================================================================
--
create TABLE productos_inventario (
    item INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del producto',
    producto VARCHAR(255) NOT NULL COMMENT 'Nombre del producto',
    codigo VARCHAR(100) NOT NULL COMMENT 'Código del producto',
    unidad_medida VARCHAR(50) NOT NULL COMMENT 'Unidad de medida (UNIDAD, DOCENAS, etc.)',
    estado ENUM('activo', 'inactivo') DEFAULT 'activo' COMMENT 'Estado del producto',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación del registro',
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de última modificación',
    UNIQUE KEY uk_codigo (codigo),
    INDEX idx_producto (producto),
    INDEX idx_estado (estado)
) ENGINE=InnoDB COMMENT='Catálogo maestro de productos';
--
-- ============================================================================
-- TABLA: inventarios
-- Descripción: Registro de inventarios asignados (sesiones de inventario)
-- ============================================================================
--
CREATE TABLE inventarios (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del inventario',
    numero_inventario VARCHAR(50) NOT NULL UNIQUE COMMENT 'Número identificador del inventario',
    contrasena VARCHAR(255) NOT NULL COMMENT 'Contraseña para acceder al inventario',
    area VARCHAR(100) NOT NULL COMMENT 'Área responsable del inventario',
    autorizado_por VARCHAR(150) NOT NULL COMMENT 'Persona que autorizó el inventario',
    fecha_hora_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora de asignación del inventario',
    estado ENUM('activo', 'cerrado', 'cancelado') DEFAULT 'activo' COMMENT 'Estado del inventario',
    fecha_cierre TIMESTAMP NULL COMMENT 'Fecha y hora de cierre del inventario',
    observaciones TEXT COMMENT 'Observaciones generales del inventario',
    INDEX idx_estado (estado),
    INDEX idx_fecha_asignacion (fecha_hora_asignacion)
) ENGINE=InnoDB COMMENT='Registro de sesiones de inventario';
--
-- ============================================================================
-- TABLA: colaboradores_inventario
-- Descripción: Colaboradores unidos a un inventario activo
-- ============================================================================
--
CREATE TABLE colaboradores_inventario (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único',
    inventario_id INT NOT NULL COMMENT 'ID del inventario',
    nombre_colaborador VARCHAR(150) NOT NULL COMMENT 'Nombre del colaborador',
    fecha_hora_union TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora en que se unió',
    rol VARCHAR(50) COMMENT 'Rol del colaborador (contador, supervisor, etc.)',
    FOREIGN KEY (inventario_id) REFERENCES inventarios(id) ON DELETE CASCADE,
    INDEX idx_inventario (inventario_id),
    INDEX idx_colaborador (nombre_colaborador)
) ENGINE=InnoDB COMMENT='Colaboradores participantes en inventarios';
--
-- ============================================================================
-- TABLA: almacenes
-- Descripción: Catálogo de almacenes
-- ============================================================================
--
CREATE TABLE almacenes (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del almacén',
    nombre VARCHAR(100) NOT NULL UNIQUE COMMENT 'Nombre del almacén',
    requiere_tienda BOOLEAN DEFAULT FALSE COMMENT 'Indica si requiere selección de tienda',
    estado ENUM('activo', 'inactivo') DEFAULT 'activo' COMMENT 'Estado del almacén',
    INDEX idx_nombre (nombre),
    INDEX idx_estado (estado)
) ENGINE=InnoDB COMMENT='Catálogo de almacenes';
--
-- ============================================================================
-- TABLA: tiendas
-- Descripción: Catálogo de tiendas (aplicable para almacén Malvinas)
-- ============================================================================
--
CREATE TABLE tiendas (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único de la tienda',
    almacen_id INT NOT NULL COMMENT 'ID del almacén al que pertenece',
    nombre_tienda VARCHAR(100) NOT NULL COMMENT '(3006, 3006B, etc.)',
    estado ENUM('activo', 'inactivo') DEFAULT 'activo' COMMENT 'Estado de la tienda',
    FOREIGN KEY (almacen_id) REFERENCES almacenes(id) ON DELETE CASCADE,
    UNIQUE KEY uk_almacen_codigo (almacen_id, nombre_tienda),
    INDEX idx_codigo (nombre_tienda),
    INDEX idx_estado (estado)
) ENGINE=InnoDB COMMENT='Catálogo de tiendas por almacén';
--
-- ============================================================================
-- TABLA: conteos
-- Descripción: Registro de conteos realizados dentro de un inventario
-- ============================================================================
--
CREATE TABLE conteos (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del conteo',
    inventario_id INT NOT NULL COMMENT 'ID del inventario al que pertenece',
    almacen_id INT NOT NULL COMMENT 'ID del almacén donde se realiza el conteo',
    tienda_id INT NULL COMMENT 'ID de la tienda (NULL para Callao, requerido para Malvinas)',
    numero_inventario VARCHAR(50) NOT NULL COMMENT 'Número del inventario (desnormalizado para consultas)',
    registrado_por VARCHAR(150) NOT NULL COMMENT 'Nombre de quien registra el conteo',
    tipo_conteo ENUM('por_cajas', 'por_stand') NOT NULL COMMENT 'Tipo de conteo realizado',
    fecha_hora_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora de inicio del conteo',
    fecha_hora_final TIMESTAMP NULL COMMENT 'Fecha y hora de finalización del conteo',
    archivo_pdf VARCHAR(500) COMMENT 'Ruta o referencia del PDF generado',
    origen_datos ENUM('sistema', 'excel') DEFAULT 'sistema' COMMENT 'Origen de los datos del conteo',
    estado ENUM('en_proceso', 'finalizado', 'cancelado') DEFAULT 'en_proceso' COMMENT 'Estado del conteo',
    observaciones TEXT COMMENT 'Observaciones del conteo',
    FOREIGN KEY (inventario_id) REFERENCES inventarios(id) ON DELETE CASCADE,
    FOREIGN KEY (almacen_id) REFERENCES almacenes(id),
    FOREIGN KEY (tienda_id) REFERENCES tiendas(id),
    INDEX idx_inventario (inventario_id),
    INDEX idx_almacen (almacen_id),
    INDEX idx_tienda (tienda_id),
    INDEX idx_tipo_conteo (tipo_conteo),
    INDEX idx_estado (estado),
    INDEX idx_fecha_inicio (fecha_hora_inicio)
) ENGINE=InnoDB COMMENT='Registro de conteos de inventario';
--
-- ============================================================================
-- TABLA: detalle_conteo
-- Descripción: Detalle de productos contados en cada conteo
-- ============================================================================
--
CREATE TABLE detalle_conteo (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del detalle',
    conteo_id INT NOT NULL COMMENT 'ID del conteo al que pertenece',
    item_producto INT NOT NULL COMMENT 'ITEM del producto (FK a productos)',
    producto VARCHAR(255) NOT NULL COMMENT 'Nombre del producto (desnormalizado)',
    codigo VARCHAR(100) NOT NULL COMMENT 'Código del producto (desnormalizado)',
    cantidad DECIMAL(15,3) DEFAULT 0 COMMENT 'Cantidad contada (editable)',
    unidad_medida VARCHAR(50) NOT NULL COMMENT 'Unidad de medida (editable)',
    fecha_hora_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de registro del detalle',
    fecha_hora_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha de última modificación',
    usuario_modificacion VARCHAR(150) COMMENT 'Usuario que realizó la última modificación',
    FOREIGN KEY (conteo_id) REFERENCES conteos(id) ON DELETE CASCADE,
    FOREIGN KEY (item_producto) REFERENCES productos_inventario(item),
    INDEX idx_conteo (conteo_id),
    INDEX idx_producto (item_producto),
    INDEX idx_codigo (codigo)
) ENGINE=InnoDB COMMENT='Detalle de productos por conteo';
--
-- ============================================================================
-- TABLA: archivos_excel_cargados
-- Descripción: Registro de archivos Excel cargados (opción emergencia)
-- ============================================================================
--
CREATE TABLE archivos_excel_cargados (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único',
    conteo_id INT NOT NULL COMMENT 'ID del conteo asociado',
    fecha_hora_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora de carga',
    registros_procesados INT DEFAULT 0 COMMENT 'Cantidad de registros procesados',
    registros_insertados INT DEFAULT 0 COMMENT 'Cantidad de registros insertados',
    observaciones TEXT COMMENT 'Observaciones del proceso de carga',
    FOREIGN KEY (conteo_id) REFERENCES conteos(id) ON DELETE CASCADE,
    INDEX idx_conteo (conteo_id),
    INDEX idx_fecha_carga (fecha_hora_carga)
) ENGINE=InnoDB COMMENT='Registro de archivos Excel cargados';
--
-- ============================================================================
-- TABLA: mapeo_unidades_excel
-- Descripción: Mapeo de unidades de medida de Excel a sistema
-- ============================================================================
--
CREATE TABLE mapeo_unidades_excel (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único',
    codigo_excel VARCHAR(50) NOT NULL UNIQUE COMMENT 'Código en Excel (NIU, DC, DZN, DZP)',
    unidad_sistema VARCHAR(50) NOT NULL COMMENT 'Unidad en el sistema (UNIDAD, DOCENAS)',
    activo BOOLEAN DEFAULT TRUE COMMENT 'Indica si el mapeo está activo',
    INDEX idx_codigo_excel (codigo_excel)
) ENGINE=InnoDB COMMENT='Mapeo de unidades de medida Excel a sistema';
--
-- ============================================================================
-- TABLA: tmp_excel_conteo
-- Descripción: Tabla temporal para los datos que se subiran desde el Excel
-- ============================================================================
--
CREATE TEMPORARY TABLE tmp_excel_conteo (
    codigo VARCHAR(100),
    cantidad DECIMAL(15,3),
    unidad_excel VARCHAR(50)
);
--
-- ============================================================================
-- TABLA: auditoria_cambios
-- Descripción: Tabla para seguimiento y reportes de cambios realizados en cada inventario
-- ============================================================================
--
CREATE TABLE auditoria_cambios (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único',
    detalle_conteo_id INT NOT NULL COMMENT 'ID del detalle modificado',
    conteo_id INT NOT NULL COMMENT 'ID del conteo',
    campo_modificado VARCHAR(100) NOT NULL COMMENT 'Campo que fue modificado',
    valor_anterior VARCHAR(500) COMMENT 'Valor anterior',
    valor_nuevo VARCHAR(500) COMMENT 'Valor nuevo',
    tipo_modificacion ENUM('individual', 'masiva') DEFAULT 'individual' COMMENT 'Tipo de modificación',
    usuario VARCHAR(150) NOT NULL COMMENT 'Usuario que realizó el cambio',
    fecha_hora_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora del cambio',
    FOREIGN KEY (detalle_conteo_id) REFERENCES detalle_conteo(id) ON DELETE CASCADE,
    FOREIGN KEY (conteo_id) REFERENCES conteos(id) ON DELETE CASCADE,
    INDEX idx_detalle (detalle_conteo_id),
    INDEX idx_conteo (conteo_id),
    INDEX idx_fecha_cambio (fecha_hora_cambio)
) ENGINE=InnoDB COMMENT='Auditoría de cambios en conteos';

-- ============================================================================
-- INSERCIÓN DE DATOS INICIALES
-- ============================================================================

-- Insertar almacenes
INSERT INTO almacenes (nombre, requiere_tienda) VALUES
('Callao', FALSE),
('Malvinas', TRUE);
select * from almacenes;

-- Insertar tiendas para almacén Malvinas
INSERT INTO tiendas (almacen_id, nombre_tienda) VALUES
(2, 'TIENDA 3006'),
(2, 'TIENDA 3006B'),
(2, 'TIENDA 3131'),
(2, 'TIENDA 3133'),
(2, 'TIENDA 412-A');
select * from tiendas;

-- Insertar mapeo de unidades Excel
INSERT INTO mapeo_unidades_excel (codigo_excel, unidad_sistema) VALUES
('NIU', 'UNIDAD'),
('DC', 'DOCENAS'),
('DZN', 'DOCENAS'),
('DZP', 'DOCENAS');

-- Insertar datos en la tabla productos_inventario 
INSERT INTO productos_inventario (producto, codigo, unidad_medida) VALUES
('Capotin Enjebado Negro', 'ZP-PS02N', 'UNIDAD'),
('Capotin Enjebado Azul Marino', 'ZP-PS02AM', 'UNIDAD'),
('Capotin Enjebado Amarillo', 'ZP-PS02A', 'UNIDAD'),
...

-- ===============================================================================================================
-- ===============================================================================================================
-- TABLAS PARA EL MODULO DE COMPARACIÓN
-- ===============================================================================================================
-- ===============================================================================================================
--
-- ============================================================================
-- TABLA: datos_sistema_callao
-- Descripción: Almacena los datos del sistema (Excel) para almacén Callao
-- ============================================================================
--
CREATE TABLE datos_sistema_callao (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID único del registro',
    inventario_id INT NOT NULL COMMENT 'Referencia al inventario',
    producto_item INT COMMENT 'Referencia al catálogo de productos',
    producto VARCHAR(255) NOT NULL COMMENT 'Nombre del producto',
    codigo VARCHAR(100) NOT NULL COMMENT 'Código del producto',
    cantidad_sistema INT NOT NULL DEFAULT 0 COMMENT 'Cantidad según el sistema (Excel)',
    unidad_medida VARCHAR(50) NOT NULL COMMENT 'Unidad de medida (UNIDAD, DOCENAS)',
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de carga del archivo Excel',
    archivo_origen VARCHAR(255) COMMENT 'Nombre del archivo Excel origen',
    usuario_carga VARCHAR(100) COMMENT 'Usuario que cargó el archivo',
    estado ENUM('activo', 'modificado', 'inactivo') DEFAULT 'activo' COMMENT 'Estado del registro',
    
    FOREIGN KEY (inventario_id) REFERENCES inventarios(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_item) REFERENCES productos_inventario(item),
    INDEX idx_inventario (inventario_id),
    INDEX idx_codigo (codigo),
    INDEX idx_estado (estado)
) ENGINE=InnoDB COMMENT='Datos del sistema (Excel) para Callao';
--
-- ============================================================================
-- TABLA: datos_sistema_malvinas
-- Descripción: Almacena los datos del sistema (Excel) para almacén Malvinas
-- ============================================================================
--
CREATE TABLE datos_sistema_malvinas (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID único del registro',
    inventario_id INT NOT NULL COMMENT 'Referencia al inventario',
    producto_item INT COMMENT 'Referencia al catálogo de productos',
    producto VARCHAR(255) NOT NULL COMMENT 'Nombre del producto',
    codigo VARCHAR(100) NOT NULL COMMENT 'Código del producto',
    cantidad_sistema INT NOT NULL DEFAULT 0 COMMENT 'Cantidad según el sistema (Excel)',
    unidad_medida VARCHAR(50) NOT NULL COMMENT 'Unidad de medida (UNIDAD, DOCENAS)',
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de carga del archivo Excel',
    archivo_origen VARCHAR(255) COMMENT 'Nombre del archivo Excel origen',
    usuario_carga VARCHAR(100) COMMENT 'Usuario que cargó el archivo',
    estado ENUM('ACTIVO', 'MODIFICADO', 'INACTIVO') DEFAULT 'ACTIVO' COMMENT 'Estado del registro',
    
    FOREIGN KEY (inventario_id) REFERENCES inventarios(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_item) REFERENCES productos_inventario(item),
    INDEX idx_inventario (inventario_id),
    INDEX idx_codigo (codigo),
    INDEX idx_estado (estado)
) ENGINE=InnoDB COMMENT='Datos del sistema (Excel) para Malvinas';
--
-- ============================================================================
-- TABLA: comparaciones_callao
-- Descripción: Tabla consolidada de comparación para almacén Callao
-- ============================================================================
--
CREATE TABLE comparaciones_callao (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID único de la comparación',
    inventario_id INT NOT NULL COMMENT 'Referencia al inventario',
    producto_item INT COMMENT 'Referencia al catálogo de productos',
    producto VARCHAR(255) NOT NULL COMMENT 'Nombre del producto',
    codigo VARCHAR(100) NOT NULL COMMENT 'Código del producto',
    cantidad_sistema INT NOT NULL DEFAULT 0 COMMENT 'Cantidad del sistema (Excel)',
    cantidad_fisica INT NOT NULL DEFAULT 0 COMMENT 'Suma de conteo cajas + stand',
    resultado INT DEFAULT 0 COMMENT 'Diferencia (física - sistema)',
    estado ENUM('CONFORME', 'SOBRANTE', 'FALTANTE') COMMENT 'Estado de la comparación',
    unidad_medida VARCHAR(50) NOT NULL COMMENT 'Unidad de medida',
    fecha_comparacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de la comparación',
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (inventario_id) REFERENCES inventarios(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_item) REFERENCES productos_inventario(item),
    INDEX idx_inventario (inventario_id),
    INDEX idx_codigo (codigo),
    INDEX idx_estado (estado)
) ENGINE=InnoDB COMMENT='Comparaciones consolidadas para Callao';
--
-- ============================================================================
-- TABLA: comparaciones_malvinas
-- Descripción: Tabla consolidada de comparación para almacén Malvinas
-- ============================================================================
--
CREATE TABLE comparaciones_malvinas (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID único de la comparación',
    inventario_id INT NOT NULL COMMENT 'Referencia al inventario',
    producto_item INT COMMENT 'Referencia al catálogo de productos',
    producto VARCHAR(255) NOT NULL COMMENT 'Nombre del producto',
    codigo VARCHAR(100) NOT NULL COMMENT 'Código del producto',
    cantidad_sistema INT NOT NULL DEFAULT 0 COMMENT 'Cantidad del sistema (Excel)',
    cantidad_fisica INT NOT NULL DEFAULT 0 COMMENT 'Suma de conteo cajas + stand (todas tiendas)',
    resultado INT DEFAULT 0 COMMENT 'Diferencia (física - sistema)',
    estado ENUM('CONFORME', 'SOBRANTE', 'FALTANTE') COMMENT 'Estado de la comparación',
    unidad_medida VARCHAR(50) NOT NULL COMMENT 'Unidad de medida',
    fecha_comparacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de la comparación',
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (inventario_id) REFERENCES inventarios(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_item) REFERENCES productos_inventario(item),
    INDEX idx_inventario (inventario_id),
    INDEX idx_codigo (codigo),
    INDEX idx_estado (estado)
) ENGINE=InnoDB COMMENT='Comparaciones consolidadas para Malvinas';
--
-- ============================================================================
-- TABLA: ediciones_cantidad_fisica
-- Descripción: Registro de ediciones a la cantidad física
-- ============================================================================
--
CREATE TABLE ediciones_cantidad_fisica (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID único de la edición',
    comparacion_id INT NOT NULL COMMENT 'ID de la comparación editada',
    almacen ENUM('callao', 'malvinas') NOT NULL COMMENT 'Almacén afectado',
    inventario_id INT NOT NULL COMMENT 'Referencia al inventario',
    producto_item INT COMMENT 'Referencia al producto',
    codigo_producto VARCHAR(100) NOT NULL COMMENT 'Código del producto',
    producto VARCHAR(255) NOT NULL COMMENT 'Nombre del producto',
    cantidad_fisica_anterior INT COMMENT 'Cantidad física antes de la edición',
    cantidad_fisica_nueva INT NOT NULL COMMENT 'Nueva cantidad física',
    motivo TEXT COMMENT 'Motivo de la edición',
    registrado_por VARCHAR(100) NOT NULL COMMENT 'Usuario que realizó la edición',
    error_de VARCHAR(255) COMMENT 'Origen del error (sistema, logística, etc.)',
    observaciones TEXT COMMENT 'Observaciones adicionales',
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora de la edición',
    
    FOREIGN KEY (inventario_id) REFERENCES inventarios(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_item) REFERENCES productos_inventario(item),
    INDEX idx_comparacion (comparacion_id, almacen),
    INDEX idx_inventario (inventario_id),
    INDEX idx_fecha (fecha_hora)
) ENGINE=InnoDB COMMENT='Historial de ediciones de cantidad física';
--
-- ============================================================================
-- TABLA: ediciones_cantidad_sistema
-- Descripción: Registro de ediciones a la cantidad del sistema
-- ============================================================================
--
CREATE TABLE ediciones_cantidad_sistema (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID único de la edición',
    comparacion_id INT NOT NULL COMMENT 'ID de la comparación editada',
    almacen ENUM('callao', 'malvinas') NOT NULL COMMENT 'Almacén afectado',
    inventario_id INT NOT NULL COMMENT 'Referencia al inventario',
    producto_item INT COMMENT 'Referencia al producto',
    codigo_producto VARCHAR(100) NOT NULL COMMENT 'Código del producto',
    producto VARCHAR(255) NOT NULL COMMENT 'Nombre del producto',
    cantidad_sistema_anterior INT COMMENT 'Cantidad sistema antes de la edición',
    cantidad_sistema_nueva INT NOT NULL COMMENT 'Nueva cantidad sistema',
    motivo TEXT COMMENT 'Motivo de la edición',
    registrado_por VARCHAR(100) NOT NULL COMMENT 'Usuario que realizó la edición',
    error_de VARCHAR(255) COMMENT 'Origen del error',
    observaciones TEXT COMMENT 'Observaciones adicionales',
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora de la edición',
    
    FOREIGN KEY (inventario_id) REFERENCES inventarios(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_item) REFERENCES productos_inventario(item),
    INDEX idx_comparacion (comparacion_id, almacen),
    INDEX idx_inventario (inventario_id),
    INDEX idx_fecha (fecha_hora)
) ENGINE=InnoDB COMMENT='Historial de ediciones de cantidad sistema';
--
-- ============================================================================
-- TABLA: verificaciones
-- Descripción: Registro de verificaciones detalladas de productos
-- ============================================================================
--
CREATE TABLE verificaciones (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID único de la verificación',
    comparacion_id INT NOT NULL COMMENT 'ID de la comparación verificada',
    almacen ENUM('callao', 'malvinas') NOT NULL COMMENT 'Almacén verificado',
    inventario_id INT NOT NULL COMMENT 'Referencia al inventario',
    producto_item INT COMMENT 'Referencia al producto',
    codigo_producto VARCHAR(100) NOT NULL COMMENT 'Código del producto',
    producto VARCHAR(255) NOT NULL COMMENT 'Nombre del producto',
    
    -- Sección COMPRAS
    fecha_ingreso_compra DATE COMMENT 'Fecha de ingreso de compra',
    hora_ingreso_compra TIME COMMENT 'Hora de ingreso de compra',
    numero_acta VARCHAR(100) COMMENT 'Número de acta',
    fecha_descarga_compra DATE COMMENT 'Fecha de descarga de compra',
    hora_descarga_compra TIME COMMENT 'Hora de descarga de compra',
    
    -- Sección VENTAS
    fecha_descarga_ventas DATE COMMENT 'Fecha de descarga de ventas',
    hora_descarga_ventas TIME COMMENT 'Hora de descarga de ventas',
    fecha_descarga_sistema DATE COMMENT 'Fecha de descarga en sistema',
    hora_descarga_sistema TIME COMMENT 'Hora de descarga en sistema',
    
    -- Sección RESULTADO GENERAL
    compras_totales DECIMAL(10,2) DEFAULT 0 COMMENT 'Total de compras',
    ventas_totales DECIMAL(10,2) DEFAULT 0 COMMENT 'Total de ventas',
    stock_existencia DECIMAL(10,2) DEFAULT 0 COMMENT 'Stock = Compras - Ventas',
    
    -- Sección RESULTADO DE VERIFICACIÓN
    stock_fisico INT DEFAULT 0 COMMENT 'Stock del conteo físico',
    stock_sistema INT DEFAULT 0 COMMENT 'Stock del sistema (Excel)',
    estado_verificacion ENUM(
        'CONFORME',
        'ERROR_SISTEMA',
        'ERROR_LOGISTICA',
        'NUEVO_CONTEO_REQUERIDO'
    ) COMMENT 'Resultado de la verificación',
    mensaje_estado TEXT COMMENT 'Mensaje detallado del estado',
    
    -- Metadatos
    registrado_por VARCHAR(100) NOT NULL COMMENT 'Usuario que realizó la verificación',
    observaciones TEXT COMMENT 'Observaciones adicionales',
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora de la verificación',
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (inventario_id) REFERENCES inventarios(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_item) REFERENCES productos_inventario(item),
    INDEX idx_comparacion (comparacion_id, almacen),
    INDEX idx_inventario (inventario_id),
    INDEX idx_estado (estado_verificacion),
    INDEX idx_fecha (fecha_hora)
) ENGINE=InnoDB COMMENT='Verificaciones detalladas de productos';
--
-- ============================================================================
-- TABLA: historial_acciones_comparacion
-- Descripción: Registro de todas las acciones realizadas en comparaciones
-- ============================================================================
--
CREATE TABLE historial_acciones_comparacion (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID único de la acción',
    inventario_id INT NOT NULL COMMENT 'Referencia al inventario',
    producto_item INT COMMENT 'Referencia al producto',
    producto VARCHAR(255) NOT NULL COMMENT 'Nombre del producto',
    codigo VARCHAR(100) NOT NULL COMMENT 'Código del producto',
    almacen ENUM('callao', 'malvinas') NOT NULL COMMENT 'Almacén afectado',
    tipo_accion ENUM(
        'EDITAR_CANTIDAD_FISICA',
        'EDITAR_CANTIDAD_SISTEMA',
        'VERIFICACION',
        'CARGAR_SISTEMA',
        'GENERAR_COMPARACION'
    ) NOT NULL COMMENT 'Tipo de acción realizada',
    motivo TEXT COMMENT 'Motivo de la acción',
    cantidad_afectada INT COMMENT 'Cantidad modificada',
    error_de VARCHAR(255) COMMENT 'Origen del error identificado',
    registrado_por VARCHAR(100) NOT NULL COMMENT 'Usuario que realizó la acción',
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora de la acción',
    detalles JSON COMMENT 'Detalles adicionales en formato JSON',
    
    FOREIGN KEY (inventario_id) REFERENCES inventarios(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_item) REFERENCES productos_inventario(item),
    INDEX idx_inventario (inventario_id),
    INDEX idx_almacen (almacen),
    INDEX idx_tipo_accion (tipo_accion),
    INDEX idx_fecha (fecha_hora)
) ENGINE=InnoDB COMMENT='Historial completo de acciones en comparaciones';
--
