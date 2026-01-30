--
--
-- PROCEDIMIENSTOS ALMACENADOS
-- 
-- SP PARA LISTAR LA FRANJA SEGUN TIPO DE MERCADO
--
DELIMITER //
CREATE PROCEDURE ListarProductosPorMercado(IN tipo_mercado VARCHAR(50))
BEGIN
    -- Mercado: MALVINAS
    IF tipo_mercado = 'Malvinas_online' THEN
        SELECT 
            p.Producto, 
            m.Codigo, 
            p.ficha_tecnica,
            m.Caja_1, 
            m.Caja_5, 
            m.Caja_10, 
            m.Caja_20, 
            m.texto_copiar
        FROM Productos_franja p
        INNER JOIN Malvinas_online m ON p.Codigo = m.Codigo;

    -- Mercado: PROVINCIA
    ELSEIF tipo_mercado = 'Provincia_online' THEN
        SELECT 
            p.Producto, 
            pr.Codigo, 
            p.ficha_tecnica,
            pr.Docena, 
            pr.Caja_1, 
            pr.Caja_5, 
            pr.Caja_10, 
            pr.texto_copiar
        FROM Productos_franja p
        INNER JOIN Provincia_online pr ON p.Codigo = pr.Codigo;

    -- Mercado: FERRETERIA
    ELSEIF tipo_mercado = 'Ferreteria_online' THEN
        SELECT 
            p.Producto, 
            f.Codigo, 
            p.ficha_tecnica,
            f.Docena, 
            f.Caja_1, 
            f.texto_copiar
        FROM Productos_franja p
        INNER JOIN Ferreteria_online f ON p.Codigo = f.Codigo;

    -- Mercado: CLIENTES FINALES
    ELSEIF tipo_mercado = 'Clientes_finales_online' THEN
        SELECT 
            p.Producto, 
            c.Codigo, 
            p.ficha_tecnica,
            c.Docena, 
            c.Caja_1, 
            c.Caja_5, 
            c.texto_copiar
        FROM Productos_franja p
        INNER JOIN Clientes_finales_online c ON p.Codigo = c.Codigo;
    
    ELSE
        SELECT 'Error: El mercado especificado no existe.' AS Mensaje;
    END IF;
END //
DELIMITER ;
--
-- PRUEBAS DEL PROCEDIMIENTO
--
-- Para Malvinas: 
CALL ListarProductosPorMercado('Malvinas_online');
-- Para Provincia: 
CALL ListarProductosPorMercado('Provincia_online');
-- Para Ferretería:
CALL ListarProductosPorMercado('Ferreteria_online');
-- Para Clientes Finales: 
CALL ListarProductosPorMercado('Clientes_finales_online');
--
-- PROCEDIMIENTO PARA ACTUALIZAR MASIVA COMO INDIVIDAULMENTE BAJO LA LOGICA UPSERT
--
DELIMITER //
CREATE PROCEDURE ActualizarPreciosMercado(
    IN p_mercado VARCHAR(50),
    IN p_codigo VARCHAR(50),
    IN p_docena DECIMAL(10,2),
    IN p_caja1 DECIMAL(10,2),
    IN p_caja5 DECIMAL(10,2),
    IN p_caja10 DECIMAL(10,2),
    IN p_caja20 DECIMAL(10,2),
    IN p_texto TEXT
)
BEGIN
    -- 1. MALVINAS
    IF p_mercado = 'Malvinas_online' THEN
        INSERT INTO Malvinas_online (Codigo, Caja_1, Caja_5, Caja_10, Caja_20, texto_copiar)
        VALUES (p_codigo, p_caja1, p_caja5, p_caja10, p_caja20, p_texto)
        ON DUPLICATE KEY UPDATE 
            Caja_1 = p_caja1, Caja_5 = p_caja5, Caja_10 = p_caja10, Caja_20 = p_caja20, texto_copiar = p_texto;

    -- 2. PROVINCIA
    ELSEIF p_mercado = 'Provincia_online' THEN
        INSERT INTO Provincia_online (Codigo, Docena, Caja_1, Caja_5, Caja_10, texto_copiar)
        VALUES (p_codigo, p_docena, p_caja1, p_caja5, p_caja10, p_texto)
        ON DUPLICATE KEY UPDATE 
            Docena = p_docena, Caja_1 = p_caja1, Caja_5 = p_caja5, Caja_10 = p_caja10, texto_copiar = p_texto;

    -- 3. FERRETERIA
    ELSEIF p_mercado = 'Ferreteria_online' THEN
        INSERT INTO Ferreteria_online (Codigo, Docena, Caja_1, texto_copiar)
        VALUES (p_codigo, p_docena, p_caja1, p_texto)
        ON DUPLICATE KEY UPDATE 
            Docena = p_docena, Caja_1 = p_caja1, texto_copiar = p_texto;

    -- 4. CLIENTES FINALES
    ELSEIF p_mercado = 'Clientes_finales_online' THEN
        INSERT INTO Clientes_finales_online (Codigo, Docena, Caja_1, Caja_5, texto_copiar)
        VALUES (p_codigo, p_docena, p_caja1, p_caja5, p_texto)
        ON DUPLICATE KEY UPDATE 
            Docena = p_docena, Caja_1 = p_caja1, Caja_5 = p_caja5, texto_copiar = p_texto;
            
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mercado no válido';
    END IF;
END //
DELIMITER ;
--
-- PRUEBAS 
--
-- ACTUALIZAR PRODUCTO DE FERRETERIA(ACTUALIZACION INDIVIDUAL)
CALL ActualizarPreciosMercado('Ferreteria_online', 'GZ-L102-8', 39.00, 35.00, NULL, NULL, NULL, '✅ Precio Guantes Duraflex: ✔️ 1 docena - S/ 39 ✔️ 1 caja - S/ 350 (35 soles cada docena🔥) ✔️ En una caja vienen 10 docenas');
--
select * from Ferreteria_online;
--