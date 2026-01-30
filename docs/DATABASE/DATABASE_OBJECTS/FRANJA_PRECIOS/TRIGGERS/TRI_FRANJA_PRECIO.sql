--
-- TRIGGER PARA SINCRONIZAR LA INSERSION DE UN PRODUCTO NUEVO PARA LOS 4 MERCADOS DISPONIBLES
--
DELIMITER //
CREATE TRIGGER despues_insertar_producto
AFTER INSERT ON Productos_franja
FOR EACH ROW
BEGIN
    -- Insertar en Malvinas_online
    INSERT INTO Malvinas_online (Codigo, texto_copiar) VALUES (NEW.Codigo, '');
    
    -- Insertar en Provincia_online
    INSERT INTO Provincia_online (Codigo, texto_copiar) VALUES (NEW.Codigo, '');
    
    -- Insertar en Ferreteria_online
    INSERT INTO Ferreteria_online (Codigo, texto_copiar) VALUES (NEW.Codigo, '');
    
    -- Insertar en Clientes_finales_online
    INSERT INTO Clientes_finales_online (Codigo, texto_copiar) VALUES (NEW.Codigo, '');
END //
DELIMITER ;
--
--
--
-- TRIGGER QUE ACTUALIZA AUTOMATICAMENTE EL CAMPO TEXTO_COPIAR EN BASE A LO QUE SE ACTUALIZA LOS TOROS CAMPOS
--
DELIMITER //
/* --- 1. MALVINAS: INSERT & UPDATE --- */
CREATE TRIGGER tg_ins_texto_malvinas BEFORE INSERT ON Malvinas_online FOR EACH ROW
BEGIN
    DECLARE v_prod VARCHAR(255); DECLARE v_cant VARCHAR(50);
    SELECT Producto, Cantidad_En_Caja INTO v_prod, v_cant FROM Productos_franja WHERE Codigo = NEW.Codigo;
    SET NEW.texto_copiar = CONCAT('⭐ ', IFNULL(v_prod, 'Producto'), ' : 🔸 1 caja - S/ ', IFNULL(NEW.Caja_1, 0), ' 🔸 5 cajas - S/ ', IFNULL(NEW.Caja_5, 0), ' 🔸 10 cajas - S/ ', IFNULL(NEW.Caja_10, 0), ' 🔸 20 cajas - S/ ', IFNULL(NEW.Caja_20, 0), ' 📦 Empaque: ', IFNULL(v_cant, 'Consultar'));
END //

CREATE TRIGGER tg_upd_texto_malvinas BEFORE UPDATE ON Malvinas_online FOR EACH ROW
BEGIN
    DECLARE v_prod VARCHAR(255); DECLARE v_cant VARCHAR(50);
    SELECT Producto, Cantidad_En_Caja INTO v_prod, v_cant FROM Productos_franja WHERE Codigo = NEW.Codigo;
    SET NEW.texto_copiar = CONCAT('⭐ ', IFNULL(v_prod, 'Producto'), ' : 🔸 1 caja - S/ ', IFNULL(NEW.Caja_1, 0), ' 🔸 5 cajas - S/ ', IFNULL(NEW.Caja_5, 0), ' 🔸 10 cajas - S/ ', IFNULL(NEW.Caja_10, 0), ' 🔸 20 cajas - S/ ', IFNULL(NEW.Caja_20, 0), ' 📦 Empaque: ', IFNULL(v_cant, 'Consultar'));
END //

/* --- 2. PROVINCIA: INSERT & UPDATE --- */
CREATE TRIGGER tg_ins_texto_provincia BEFORE INSERT ON Provincia_online FOR EACH ROW
BEGIN
    DECLARE v_prod VARCHAR(255); DECLARE v_cant VARCHAR(50);
    SELECT Producto, Cantidad_En_Caja INTO v_prod, v_cant FROM Productos_franja WHERE Codigo = NEW.Codigo;
    SET NEW.texto_copiar = CONCAT('✅ ', IFNULL(v_prod, 'Producto'), ' ✔️ Docena: S/ ', IFNULL(NEW.Docena, 0), ' ✔️ Caja 1: S/ ', IFNULL(NEW.Caja_1, 0), ' ✔️ Caja 5: S/ ', IFNULL(NEW.Caja_5, 0), ' 📦 Caja: ', IFNULL(v_cant, 'Consultar'));
END //

CREATE TRIGGER tg_upd_texto_provincia BEFORE UPDATE ON Provincia_online FOR EACH ROW
BEGIN
    DECLARE v_prod VARCHAR(255); DECLARE v_cant VARCHAR(50);
    SELECT Producto, Cantidad_En_Caja INTO v_prod, v_cant FROM Productos_franja WHERE Codigo = NEW.Codigo;
    SET NEW.texto_copiar = CONCAT('✅ ', IFNULL(v_prod, 'Producto'), ' ✔️ Docena: S/ ', IFNULL(NEW.Docena, 0), ' ✔️ Caja 1: S/ ', IFNULL(NEW.Caja_1, 0), ' ✔️ Caja 5: S/ ', IFNULL(NEW.Caja_5, 0), ' 📦 Caja: ', IFNULL(v_cant, 'Consultar'));
END //

/* --- 3. FERRETERIA: INSERT & UPDATE --- */
CREATE TRIGGER tg_ins_texto_ferreteria BEFORE INSERT ON Ferreteria_online FOR EACH ROW
BEGIN
    DECLARE v_prod VARCHAR(255); DECLARE v_cant VARCHAR(50);
    SELECT Producto, Cantidad_En_Caja INTO v_prod, v_cant FROM Productos_franja WHERE Codigo = NEW.Codigo;
    SET NEW.texto_copiar = CONCAT('🔘 ', IFNULL(v_prod, 'Producto'), ' ✅ Docena: S/ ', IFNULL(NEW.Docena, 0), ' ✅ Caja: S/ ', IFNULL(NEW.Caja_1, 0), ' 📦 Unidades x Caja: ', IFNULL(v_cant, 'Consultar'));
END //

CREATE TRIGGER tg_upd_texto_ferreteria BEFORE UPDATE ON Ferreteria_online FOR EACH ROW
BEGIN
    DECLARE v_prod VARCHAR(255); DECLARE v_cant VARCHAR(50);
    SELECT Producto, Cantidad_En_Caja INTO v_prod, v_cant FROM Productos_franja WHERE Codigo = NEW.Codigo;
    SET NEW.texto_copiar = CONCAT('🔘 ', IFNULL(v_prod, 'Producto'), ' ✅ Docena: S/ ', IFNULL(NEW.Docena, 0), ' ✅ Caja: S/ ', IFNULL(NEW.Caja_1, 0), ' 📦 Unidades x Caja: ', IFNULL(v_cant, 'Consultar'));
END //

/* --- 4. CLIENTES FINALES: INSERT & UPDATE --- */
CREATE TRIGGER tg_ins_texto_finales BEFORE INSERT ON Clientes_finales_online FOR EACH ROW
BEGIN
    DECLARE v_prod VARCHAR(255); DECLARE v_cant VARCHAR(50);
    SELECT Producto, Cantidad_En_Caja INTO v_prod, v_cant FROM Productos_franja WHERE Codigo = NEW.Codigo;
    SET NEW.texto_copiar = CONCAT('👤 ', IFNULL(v_prod, 'Producto'), ' ✔️ Docena: S/ ', IFNULL(NEW.Docena, 0), ' ✔️ Caja: S/ ', IFNULL(NEW.Caja_1, 0), ' 📦 Empaque: ', IFNULL(v_cant, 'Consultar'));
END //

CREATE TRIGGER tg_upd_texto_finales BEFORE UPDATE ON Clientes_finales_online FOR EACH ROW
BEGIN
    DECLARE v_prod VARCHAR(255); DECLARE v_cant VARCHAR(50);
    SELECT Producto, Cantidad_En_Caja INTO v_prod, v_cant FROM Productos_franja WHERE Codigo = NEW.Codigo;
    SET NEW.texto_copiar = CONCAT('👤 ', IFNULL(v_prod, 'Producto'), ' ✔️ Docena: S/ ', IFNULL(NEW.Docena, 0), ' ✔️ Caja: S/ ', IFNULL(NEW.Caja_1, 0), ' 📦 Empaque: ', IFNULL(v_cant, 'Consultar'));
END //
DELIMITER ;
