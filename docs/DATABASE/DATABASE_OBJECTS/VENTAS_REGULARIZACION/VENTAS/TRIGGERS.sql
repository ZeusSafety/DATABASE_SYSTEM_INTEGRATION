###############################################
-- TRIGGER DE VENTAS
###############################################
DROP TRIGGER IF EXISTS INSERT_VENTAS;
DELIMITER $$;
CREATE TRIGGER INSERT_VENTAS
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
	-- Insertamos en la tabla de pagos
    INSERT INTO pagos(N_COMPROBANTE, REGULARIZADO, CANCELADO, ID_VENTA) VALUES (NEW.N_COMPROBANTE,"NO","NO",NEW.ID_VENTA);
END $$;
DELIMITER ;
show triggers;

###############################################
-- TRIGGERS AUDITORIA
###############################################
DROP TRIGGER IF EXISTS AUDITORIA_VENTAS;
DELIMITER $$;
CREATE TRIGGER AUDITORIA_VENTAS
AFTER UPDATE ON ventas
FOR EACH ROW
BEGIN
	-- Insertamos a la tabla de auditorías de ventas
END $$;
DELIMITER ;

DROP TRIGGER IF EXISTS AUDITORIA_REGULARIZACION;
DELIMITER $$;
DELIMITER $$;
CREATE TRIGGER AUDITORIA_REGULARIZACION
AFTER UPDATE ON ventas
FOR EACH ROW
BEGIN
	-- Insertamos a la tabla de auditorías de ventas
END $$;
DELIMITER ;