--
-- FRANJA DE PRECIOS NUEVA --
--
-- TABLA PRINCIPAL
CREATE TABLE Productos_franja (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Codigo VARCHAR(50) UNIQUE NOT NULL, 
    Producto VARCHAR(255) NOT NULL,
    Cantidad_En_Caja VARCHAR(50),
    INDEX (Codigo) -- Índice para búsquedas rápidas durante la sincronización
);
ALTER TABLE Productos_franja ADD COLUMN ficha_tecnica VARCHAR(250);
--
INSERT INTO Productos_franja (Codigo, Producto, Cantidad_En_Caja) VALUES
('GZ-L102-8', 'GUANTES DURAFLEX ', '10 DOCENAS'),
('GZ-L202-8', 'GUANTES ECONOFLEX ', '10 DOCENAS'),
('GZ-L210-8', 'GUANTES WORKFLEX ', '10 DOCENAS'),
('GZ-L410-8', 'GUANTES FORTFLEX ', '10 DOCENAS'),
('GZ-L401-9', 'GUANTES SUPERFORT ', '10 DOCENAS'),
('GZ-L501-9', 'GUANTES DUMAX ', '20 DOCENAS'),
('GZ-L511-9', 'GUANTES TRIMAX ', '20 DOCENAS'),
('GZ-N310-8', 'GUANTES IMPERMEABLE ', '10 DOCENAS'),
('GZ-PU103-6', 'GUANTES PUFLEX ', '20 DOCENAS'),
('GZ-PU203-7', 'GUANTES PUFLEX FLOREADO', '20 DOCENAS'),
('GZ-L601-9', 'GUANTES LASTIFLEX ', '20 DOCENAS'),
('GZ-N103-9', 'GUANTES NITRIFLEX ', '25 DOCENAS'),
('GZ-L303-8', 'GUANTES STIFLEX ', '20 DOCENAS'),
('GZ-N201-9', 'GUANTES NITRON AZUL PUÑO CERRADO', '10 DOCENAS'),
('GZ-N202-9', 'GUANTES NITRON AZUL PUÑO ABIERTO ', '10 DOCENAS'),
('GZ-A102-9', 'GUANTES UN LADO PVC ', '25 DOCENAS'),
('GZ-A201-9', 'GUANTES DOBLE LADO PVC', '25 DOCENAS'),
('GZ-AC01-7', 'GUANTES EXTREMO CUT 5 ', '10 DOCENAS'),
('GZ-AC10-9', 'GUANTES ANTI-IMPACTO', '10 DOCENAS'),
('GZ-AC20-9', 'GUANTES ANTIVIBRACIÓN ', '10 DOCENAS'),
('GZ-R101-10', 'GUANTES ULTRAFLEX ', '20 DOCENAS'),
('GZ-C25-7', 'GUANTES INDUSTRIAL CALIBRE 25 ', '12 DOCENAS'),
('GZ-C35-7', 'GUANTES INDUSTRIAL CALIBRE 35 ', '12 DOCENAS'),
('GZ-C500-14', 'GUANTES SOLDADOR WELLDING ', '5 DOCENAS'),
('GZ-C511-14', 'GUANTES SOLDADOR PREMIUN ', '5 DOCENAS'),
('GZ-CN101-9', 'GUANTES CROMO REFORZADO', '10 DOCENAS'),
('GZ-C204-9', 'GUANTES DE BADANA MODELO NACIONAL BLANCO O AMARIILLO', '10 DOCENAS'),
('GZ-C202-9', 'GUANTES CUERO BADANA AMARILLO ', '10 DOCENAS'),
('GZ-C201-9', 'GUANTES CUERO BADANA BLANCO ', '10 DOCENAS'),
('GZ-C102-9', 'GUANTES CUERO CARNAZA', '10 DOCENAS'),
('GZ-C301-9', 'GUANTES CUERO DRIVER ', '10 DOCENAS'),
('GZ-A301-9', 'GUANTES DE HILO BLANCO ', '10 DOCENAS'),
('LZ-AF102-O', 'LENTES INTENSITY AF - OSCURO / CLARO', '25 DOCENAS'),
('LZ-AFSL102-O', 'LENTES INTENSITY AF S/L - OSCURO / CLARO', '25 DOCENAS'),
('LZ-HC202', 'LENTES SPORT VISION HC - OSCURO / CLARO', '25 DOCENAS'),
('LZ-AF201-C', 'LENTES SPORT VISION AF - OSCURO / CLARO', '25 DOCENAS'),
('LZ-HC102-O', 'LENTES INTENSITY HC - OSCURO / CLARO', '25 DOCENAS'),
('LZ-AFSL102-C', 'LENTES INTENSITY AF - OSCURO / CLARO', '25 DOCENAS'),
('ZP-PS01-AM', 'PONCHO ENJEBADO 🟡/🔵/⚫/🟢', '20 UNIDADES'),
('OZ-M1001-L', 'SAFEGUARD OVEROL BLANCO L / XL', '50 UNIDADES'),
('ZP-PS02A', 'CAPOTIN 🟡/🔵/⚫/🟢', '20 UNIDADES'),
('CZ-C01A', 'CASCO DE SEGURIDAD ', '50 UNIDADES'),
('BZ-Z01N', 'BARBIQUEJO PARA CASCO NEGRO', '500 UNIDADES'),
('MZ-M101', 'MALLAS DE SEGURIDAD', '6 UNIDADES'),
('TZ-T001', 'TAPÓN AUDITIVO EN BOLSA', '1000 UNIDADES'),
('RZ-S2097', 'RESPIRADOR 7502 + FILTRO 2097', '40 UNIDADES'),
('RZ-S6003', 'RESPIRADOR 7502 + FILTRO 6003', '40 UNIDADES'),
('RZ-S7093', 'RESPIRADOR 7502 + FILTRO 7093', '40 UNIDADES'),
('RZ-C2097', 'RESPIRADOR 6200 + FILTRO 2097', '40 UNIDADES'),
('RZ-C6003', 'RESPIRADOR 6200 + FILTRO 6003', '40 UNIDADES'),
('RZ-C7093', 'RESPIRADOR 6200 + FILTRO 7093', '40 UNIDADES'),
('RZ-3200', 'RESPIRADOR MONOVIA', '40 UNIDADES'),
('RF-2097', 'REPUESTO FILTRO 2097', '10 UNIDADES'),
('RF-6003', 'REPUESTO FILTRO 6003', '5 UNIDADES'),
('RF-7093', 'REPUESTO FILTRO 7093', '10 UNIDADES'),
('RF-3701', 'PREFILTRO MONOVIA 3701', '20 UNIDADES'),
('ARZ-359', 'ARNES + LINEA DE VIDA', '10 UNIDADES'),
('ZC-C18', 'CONO DE SEGURIDAD 18', '5 UNIDADES'),
('ZC-CS28', 'CONO PVC 28"" CON CINTA ', '5 UNIDADES'),
('ZC-C28', 'CONO PVC 28""', '5 UNIDADES'),
('ZC-C36', 'CONO DE SEGURIDAD 36', '5 UNIDADES'),
('ZC-CS36', 'CONO PVC 36"" CON CINTA', '5 UNIDADES'),
('ZP-P101', 'LETRERO DE PISO MOJADO', '20 UNIDADES'),
('ZB-B101', 'BARRA RETRACTIL', '50 UNIDADES'),
('RZ-R01', 'RODILLERA', '50 UNIDADES'),
('BZ-MS01-36', 'ZAPATO MODELO TOKIO - TALLA 36 - 42', '10 PARES'),
('ZCH-N80', 'CHALECO NARANJA DE 2 BANDAS 80 G', '20 UNIDADES'),
('VZ-R01P', 'VARA LUMINOSA NARANJA CON PILAS ', '50 UNIDADES'),
('VZ-R01R', 'VARA LUMINOSA NARANJA RECARGABLE', '50 UNIDADES'),
('CZ-A01', 'CINTA AMARILLO Y NEGRO ANTI DESLIZANTE 2 CM x 18 M', '50 UNIDADES'),
('CZ-A02', 'CINTA AMARILLO Y NEGRO ANTI DESLIZANTE 5 CM x 18M', '24 UNIDADES'),
('CZ-P101', 'CINTA DE PELIGRO AMARILLO 180MT', '0 DOCENAS'),
('CZ-P102', 'CINTA DE PELIGRO ROJO 180MT', '0 DOCENAS'),
('ZE-001', 'INTERRUPTOR SIMPLE ', '10 UNIDADES'),
('ZE-002', 'INTERRUPTOR DOBLE', '10 UNIDADES'),
('ZE-003', 'INTERRUPTOR TRIPLE', '10 UNIDADES'),
('ZE-004', 'CONMUTADOR SIMPLE', '10 UNIDADES'),
('ZE-005', 'CONMUTADOR DOBLE', '10 UNIDADES'),
('ZE-006', 'CONMUTADOR TRIPLE', '10 UNIDADES'),
('ZE-007', 'TOMACORRIENTE SIMPLE S ', '10 UNIDADES'),
('ZE-008', 'TOMACORRIENTE DOBLE S ', '10 UNIDADES'),
('ZE-009', 'TOMACORRIENTE TRIPLE S', '10 UNIDADES'),
('ZE-010', 'TOMACORRIENTE SIMPLE A', '10 UNIDADES'),
('ZE-011', 'TOMACORRIENTE DOBLE A', '10 UNIDADES'),
('ZE-012', 'TOMACORRIENTE TRIPLE A', '10 UNIDADES'),
('CZ-SPB10', 'CAMILLA DE SEGURIDAD NARANJA', '1 UNIDAD'),
('LZ-ILM20', 'LINTERNA MINERA KJ13.5LM', '36 UNIDADES'),
('PZ-SFS01', 'PROTECTOR FACIAL AJUSTABLE', '40 UNIDADES'),
('PZ-SFS03', 'CARETA PARA SOLDAR', '40 UNIDADES'),
('PZ-SFS02', 'VISOR FACIAL', '40 UNIDADES'),
('MZ-FBK500', 'MANTA IGNIFUGA', '50 UNIDADES'),
('IC-HIM200', 'INMOVILIZADOR DE CABEZA', '10 UNIDADES'),
('SZ-SST300', 'CORREA DE ARAÑA', '20 UNIDADES'),
('CZ-CNB400', 'COLLARIN CERVICAL', '20 UNIDADES'),
('GZ-N410-9', 'GUANTES THERMO PLUS', '10 DOCENAS'),
('GZ-A60-9', 'GUANTES ULTRABLUE', '6 DECENAS'),
('GZ-PVC30-9', 'GUANTES FLEXIBLUE', '10 DOCENAS');
--
-- TABLAS DE LOS TIPOS DE MERCADOS DISPONIBLES
--
-- MALVINAS - ONLINE
CREATE TABLE Malvinas_online (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Codigo VARCHAR(50) NOT NULL,
    Caja_1 DECIMAL(10, 2),
    Caja_5 DECIMAL(10, 2),
    Caja_10 DECIMAL(10, 2),
    Caja_20 DECIMAL(10, 2),
    texto_copiar TEXT,
    FOREIGN KEY (Codigo) REFERENCES Productos_franja(Codigo) ON DELETE CASCADE
);
--
INSERT INTO Malvinas_online (Codigo, Caja_1, Caja_5, Caja_10, Caja_20, texto_copiar) VALUES
('GZ-L102-8', 29.50, 28.50, 28.00, 27.50, '⭐ Precio Guantes Duraflex : 🔸 1 caja - S/ 295 (29.50 soles la docena💘) 🔸 5 caja - S/ 285 (28.50 soles la docena💘) 🔸 10 caja - S/ 280 (28 soles la docena💘) 🔸 20 caja - S/ 275 (27.50 soles la docena💘)  🔸 En una caja vienen 10 docenas'),
('GZ-L202-8', 23.80, 23.50, 23.00, 22.50, '⭐ Precio Guantes Econoflex :🔸 1 caja - S/ 238.50 (23.85 soles la docena💘) 🔸 5 cajas - S/ 235 (23.50 soles la docena💘) 🔸 10 cajas - S/ 230 (23 soles la docena💘) 🔸 20 cajas - S/ 225 (22.50 soles la docena💘)  🔸 En una caja vienen 10 docenas'),
('GZ-L410-8', 34.00, 33.50, 32.50, NULL, '⭐ Precio Guantes Fortflex : 🔸 1 caja - S/ 340 (34.00 soles la docena💘) 🔸 5 cajas - S/ 350 (33.50 soles la docena💘) 🔸 10 cajas - S/ 325 (32.50 soles la docena💘) 🔸 En una caja vienen 10 docenas'),
('GZ-L401-9', NULL, NULL, NULL, NULL, ''),
('GZ-L501-9', 26.00, 25.00, 24.50, NULL, '⭐ Precio Guantes Dumax : 🔸 1 caja - S/ 520 (26.00 soles la docena💘) 🔸 5 cajas - S/ 500 (25.00 soles la docena💘) 🔸 10 cajas - S/ 490 (24.50 soles la docena💘) 🔸 En una caja vienen 20 docenas'),
('GZ-L511-9', 30.00, 29.00, 28.50, NULL, '⭐ Precio Guantes Trimax : 🔸 1 caja - S/ 600 (30.00 soles la docena💘) 🔸 5 cajas - S/ 580 (29.00 soles la docena💘) 🔸 10 cajas - S/ 570 (28.50 soles la docena💘) 🔸 En una caja vienen 20 docenas'),
('GZ-N310-8', 34.00, 33.00, 32.00, NULL, '⭐ Precio Guantes Impermeable : 🔸 1 caja - S/ 340 (34.00 soles la docena💘) 🔸 5 cajas - S/ 330 (33.00 soles la docena💘) 🔸 10 cajas - S/ 320 (32.00 soles la docena💘) 🔸 En una caja vienen 10 docenas'),
('GZ-PU103-6', 18.80, 18.20, 17.50, NULL, '⭐ Precio Guantes Puflex : 🔸 1 caja - S/ 376 (18.80 soles la docena💘) 🔸 5 cajas - S/ 364 (18.20 soles la docena💘) 🔸 10 cajas - S/ 350 (17.50 soles la docena💘) 🔸 En una caja vienen 20 docenas'),
('GZ-PU203-7', 16.00, NULL, NULL, NULL, '⭐ Precio Guantes Puflex Floreado: 🔸 1 caja - S/ 320 (16.00 soles la docena💘)  🔸 En una caja vienen 20 docenas'),
('GZ-L601-9', 28.00, 26.00, NULL, NULL, '⭐ Precio Guantes Lastiflex : 🔸 1 caja - S/ 560 (28.00 soles la docena💘) 🔸 5 cajas - S/ 520 (26.00 soles la docena💘) 🔸 En una caja vienen 20 docenas'),
('GZ-N103-9', 21.00, 20.00, 19.50, NULL, '⭐ Precio Guantes Nitriflex : 🔸 1 caja - S/ 525 (21.00 soles la docena💘) 🔸 5 cajas - S/ 500 (20.00 soles la docena💘) 🔸 10 cajas - S/ 487.5 (19.50 soles la docena💘) 🔸 En una caja vienen 25 docenas'),
('GZ-L303-8', 21.00, 20.00, NULL, NULL, '⭐ Precio Guantes Stiflex : 🔸 1 caja - S/ 420 (21.00 soles la docena💘) 🔸 5 cajas - S/ 400 (20.00 soles la docena💘) 🔸 En una caja vienen 20 docenas'),
('GZ-N201-9', 51.00, 50.00, 49.50, NULL, '⭐ Precio Guantes Nitron Cerrado: 🔸 1 caja - S/ 510 (51.00 soles la docena💘) 🔸 5 cajas - S/ 500 (50.00 soles la docena💘) 🔸 10 cajas - S/ 495 (49.50 soles la docena💘) 🔸 En una caja vienen 10 docenas'),
('GZ-N202-9', 52.00, 51.00, 50.50, NULL, '⭐ Precio Guantes Nitron Abierto: 🔸 1 caja - S/ 520 (52.00 soles la docena💘) 🔸 5 cajas - S/ 510 (51.00 soles la docena💘) 🔸 10 cajas - S/ 505 (50.50 soles la docena💘) 🔸 En una caja vienen 10 docenas'),
('GZ-AC01-7', 75.00, 74.50, 74.00, NULL, '⭐ Precio Guantes CUT 5 : 🔸 1 caja - S/ 750 (75.00 soles la docena💘) 🔸 5 cajas - S/ 745 (74.50 soles la docena💘) 🔸 10 cajas - S/ 740 (74.00 soles la docena💘) 🔸 En una caja vienen 10 docenas'),
('GZ-AC10-9', 28.50, 27.50, NULL, NULL, '⭐ Precio Guantes Anti-Impacto: 🔸 Desde 1 docena - S/ 28.50 cada par 🥺  🔸 En una caja vienen 10 docenas'),
('GZ-AC20-9', 38.00, 37.00, NULL, NULL, '⭐ Precio Guantes Anti-Vibración: 🔸 Desde 1 docena - S/ 38.00 cada Par🥺 🔸 En una caja vienen 10 docenas'),
('GZ-R101-10', 47.00, 46.50, NULL, NULL, '⭐ Precio Guantes Ultraflex : 🔸 1 caja - S/ 940 (47.00 soles la docena💘) 🔸 5 cajas - S/ 930 (46.50 soles la docena💘) 🔸 En una caja vienen 20 docenas'),
('GZ-C25-7', 57.00, 56.00, NULL, NULL, '⭐ Precio Guantes Jebe Calibre 25 : 🔸 1 caja - S/ 684 (57.00 soles la docena💘) 🔸 5 cajas - S/ 672 (56.00 soles la docena💘) 🔸 En una caja vienen 12 docenas'),
('GZ-C35-7', 59.50, 58.70, NULL, NULL, '⭐ Precio Guantes Jebe Calibre 35 : 🔸 1 caja - S/ 714 (59.50 soles la docena💘) 🔸 5 cajas - S/ 704.4 (58.70 soles la docena💘) 🔸 En una caja vienen 12 docenas'),
('GZ-C500-14', 105.00, 103.00, NULL, NULL, '⭐ Precio Guantes Soldador Wellding:🔸 1 caja - S/ 515 (103.00 soles la docena💘) 🔸 5 cajas - S/ 505 (101.00 soles la docena💘) 🔸 En una caja vienen 5 docenas'),
('GZ-C511-14', 120.00, 118.00, NULL, NULL, '⭐ Precio Guantes Soldador Naranja India: 🔸 1 caja - S/ 590 (118.00 soles la docena💘) 🔸 5 cajas - S/ 570 (114.00 soles la docena💘) 🔸 10 cajas - S/ 540 (108.00 soles la docena💘) 🔸 En una caja vienen 5 docenas'),
('GZ-C204-9', 50.30, 49.50, NULL, NULL, '⭐ Precio Badana Blanco Nacional Amarillo o Blanco: 🔸 1 caja - S/ 503 (50.30 soles la docena💘) 🔸 5 cajas - S/ 495 (49.50 soles la docena💘) 🔸 10 cajas - S/ 485 (48.50 soles la docena💘) 🔸 En una caja vienen 10 docenas'),
('GZ-C201-9', 55.00, 54.50, 54.30, NULL, '⭐ Precio Badana Blanco : 🔸 1 caja - S/ 550 (55.00 soles la docena💘) 🔸 5 cajas - S/ 545 (54.50 soles la docena💘) 🔸 10 cajas - S/ 543 (54.30 soles la docena💘) 🔸 En una caja vienen 10 docenas'),
('GZ-C202-9', 56.00, 55.50, 55.30, NULL, '⭐ Precio Badana Amarillo : 🔸 1 caja - S/ 560 (56.00 soles la docena💘) 🔸 5 cajas - S/ 555 (55.50 soles la docena💘) 🔸 10 cajas - S/ 553 (55.30 soles la docena💘) 🔸 En una caja vienen 10 docenas'),
('GZ-C102-9', 48.50, 47.00, 46.50, NULL, '⭐ Precio Carnaza : 🔸 1 caja - S/ 485 (48.50 soles la docena💘) 🔸 5 cajas - S/ 470 (47.00 soles la docena💘) 🔸 10 cajas - S/ 465 (46.50 soles la docena💘) 🔸 En una caja vienen 10 docenas'),
('GZ-C301-9', 58.50, NULL, NULL, NULL, '⭐ Precio Driver : 🔸 1 caja - S/ 585 (58.50 soles la docena💘) 🔸 En una caja vienen 10 docenas'),
('LZ-AF102-O', 27.00, NULL, NULL, NULL, '⭐ Precio Lentes AF Oscuro: 🔸 1 caja - S/ 810 (27.00 soles la docena💘) 🔸 En una caja vienen 25 docenas'),
('LZ-HC102-O', 14.00, NULL, NULL, NULL, '⭐ Precio Lentes HC Intensity Oscuro: 🔸 1 caja - S/ 420 (14.00 soles la docena💘) 🔸 En una caja vienen 25 docenas'),
('LZ-HC202', 18.50, NULL, NULL, NULL, '⭐ Precio Sport Vision HC Oscuro / Claro: 🔸 1 caja - S/ 462.5 (18.50 soles la docena💘) 🔸 En una caja vienen 25 docenas'),
('LZ-AF201-C', 27.00, 26.00, NULL, NULL, '⭐ Precio Sport Vision AF Oscuro / Claro : 🔸 1 caja - S/ 650 (26.00 soles la docena💘) 🔸 En una caja vienen 25 docenas'),
('OZ-M1001-L', 4.50, 4.20, NULL, NULL, '⭐ Precio Overol Blanco L: 🔸 1 caja - S/ 210 (4.20 soles la unidad💘) 🔸 En una caja vienen 50 unidades'),
('ZP-PS02A', 13.80, 13.30, NULL, NULL, '⭐ Precio Capotin Enjebado: 🔸 1 unidad - S/ 13.80 🔸 1 caja - S/ 13.30  c/u 🔸 En una caja vienen 20 unidades'),
('ZP-PS01-AM', 13.50, 13.00, NULL, NULL, '⭐ Precio Poncho Enjebado: 🔸 1 unidad - S/ 13.50 🔸 1 caja - S/ 13.00  c/u 🔸 En una caja vienen 20 unidades ⚠️ En poncho color verde camuflado vienen 25 Unidades ⚠️'),
('CZ-C01A', 4.50, NULL, NULL, NULL, '⭐ Precio Casco Amarillo: 🔸 1 caja - S/ 225 (4.50 soles la unidad💘) 🔸 En una caja vienen 50 unidades'),
('BZ-Z01N', 1.00, 0.90, NULL, NULL, '⭐ Precio Barbuquejo: 🔸 1 caja - S/ 500 (1.00 soles la unidad💘) 🔸 En una caja vienen 500 unidades'),
('MZ-M101', 22.50, 22.00, NULL, NULL, '⭐ Precio Mallas de Seguridad:🔸 6 a 120 rollos - S/ 22.50 c/u 🔸 120 a 500 rollos - S/ 22.00 c/u  🔸 En una caja vienen 6 unidades'),
('TZ-T001', 48.00, 47.00, NULL, NULL, '⭐ Precio Tapón de Oído: 🔸 1 caja - S/ 48.00 (la cajita de 100 uni) 🔸 5 cajas - S/ 47.00 (la cajita de 100 uni) 🔸 En una caja vienen 1000 unidades'),
('RZ-S2097', 20.00, 18.80, NULL, NULL, '⭐ Respiradores 7502 + Filtro 2097: 🔸 1 caja - S/ 20.00 c/u 🔸 5 cajas - S/ 18.80 c/u 🔸 En una caja vienen 40 unidades'),
('RZ-S6003', 23.00, 22.50, NULL, NULL, '⭐ Respiradores 7502 + Filtro 6003: 🔸 1 caja - S/ 23.00 c/u 🔸 5 cajas - S/ 22.50 c/u 🔸 En una caja vienen 40 unidades'),
('RZ-S7093', 22.00, 21.00, NULL, NULL, '⭐ Respiradores 7502 + Filtro 7093: 🔸 1 caja - S/ 22.00 c/u 🔸 5 cajas - S/ 21.00 c/u 🔸 En una caja vienen 40 unidades'),
('RZ-C2097', 19.00, 18.50, NULL, NULL, '⭐ Respiradores 6200 + Filtro 2097: 🔸 1 caja - S/ 19.00 c/u 🔸 5 cajas - S/ 18.50 c/u 🔸 En una caja vienen 40 unidades'),
('RZ-C6003', 21.00, 20.00, NULL, NULL, '⭐ Respiradores 6200 + Filtro 6003: 🔸 1 caja - S/ 21.00 c/u 🔸 5 cajas - S/ 20.00 c/u 🔸 En una caja vienen 40 unidades'),
('RZ-C7093', 20.00, 19.50, NULL, NULL, '⭐ Respiradores 6200 + Filtro 7093:🔸 1 caja - S/ 20.00 c/u 🔸 5 cajas - S/ 19.50 c/u 🔸 En una caja vienen 40 unidades'),
('RZ-3200', 13.00, 12.50, NULL, NULL, '⭐ Respirador Monovia:🔸 1 caja - S/ 13.00 c/u 🔸 5 cajas - S/ 12.50 c/u 🔸 En una caja vienen 40 unidades'),
('RF-2097', 10.00, 9.00, NULL, NULL, '⭐ Repuesto Filtro 2097: 🔸 S/ 10.00 (hasta 39 unidades) 🔸 S/ 9.00 (desde 40 unidades a +) 🔸 En una caja vienen 10 unidades'),
('RF-6003', 12.00, 11.00, NULL, NULL, '⭐ Repuesto Filtro 6003: 🔸 S/ 12.00 (hasta 39 unidades) 🔸 S/ 11.00 (desde 40 unidades a + ) 🔸 En una caja vienen 5 unidades'),
('RF-7093', 11.00, 10.00, NULL, NULL, '⭐ Repuesto Filtro 7093: 🔸 S/ 11.00 (hasta 39 unidades) 🔸 S/ 10.00 (desde 40 unidades a +) 🔸 En una caja vienen 10 unidades'),
('RF-3701', 9.00, 8.00, NULL, NULL, '⭐ Repuesto Prefiltro Monovía 3701: 🔸 S/ 9.00 (hasta 39 unidades) 🔸 S/ 8.00 (desde 40 unidades) 🔸 En una caja vienen 20 unidades'),
('ARZ-359', 99.00, 98.00, NULL, NULL, '⭐ Precio Arnés + Línea de Vida: 🔸 1 caja - S/ 990 (99.00 soles c/u💘) 🔸 5 cajas - S/ 980 (98.00 soles c/u💘) 🔸 En una caja vienen 10 unidades'),
('ZC-CS28', 18.00, 17.00, NULL, NULL, '⭐ Precio Cono PVC 28" con Cinta: 🔸 5 a 30 unidades - S/ 18.00 c/u 🔸 30 a 100 unidades - S/ 17.00 c/u 🔸 En una caja vienen 5 unidades'),
('ZC-C28', 17.50, 17.00, NULL, NULL, '⭐ Precio Cono PVC 28": 🔸 5 a 30 unidades - S/ 17.50 c/u 🔸 30 a 100 unidades - S/ 17.00 c/u 🔸 En una caja vienen 5 unidades'),
('ZC-CS36', 35.00, 34.00, NULL, NULL, '⭐ Precio Cono PVC 36" con Cinta: 🔸 10 a 50 unidades - S/ 35.00 c/u 🔸 50 a 150 unidades - S/ 34.00 c/u 🔸 En una caja vienen 5 unidades'),
('ZP-P101', 9.50, 9.00, NULL, NULL, '⭐ Precio Señal "Piso Mojado": 🔸 20 a 60 unidades - S/ 9.50 c/u 🔸 60 a 140 unidades - S/ 9.00 c/u 🔸 En una caja vienen 20 unidades'),
('ZB-B101', 8.00, 7.60, NULL, NULL, '⭐ Precio Barra Retráctil: 🔸 10 a 200 unidades - S/ 8.00 c/u 🔸 200 a 400 unidades - S/ 7.60 c/u 🔸 En una caja vienen 50 unidades'),
('RZ-R01', 18.00, NULL, NULL, NULL, '⭐ Precio Rodillera: 🔸 1 caja - S/ 900 (18.00 soles c/u💘) 🔸 En una caja vienen 50 unidades'),
('BZ-MS01-36', 55.00, 54.50, NULL, NULL, '⭐ Precio Zapato de Seguridad Tokio (TALLA 36 - 42): 🔸 1 caja - S/ 555 (55.50 soles el par💘) 🔸 5 cajas - S/ 545 (54.50 soles el par💘)  🔸 En una caja vienen 10 pares'),
('ZCH-N80', 3.80, 3.50, NULL, NULL, '⭐ Precio Chaleco Naranja 2 Bandas (80g): 🔸 - S/ 3.80 c/u 🔸 Por 5 cajas - S/ 3.50 c/u 🔸 En una caja vienen 20 unidades'),
('VZ-R01P', 10.00, 9.00, NULL, NULL, '⭐ Precio Vara Luminosa Naranja con Pilas: 🔸 Por una caja - S/ 10.00 c/u 🔸 Por 5 cajas - S/ 9.00 c/u 🔸 En una caja vienen 50 unidades'),
('VZ-R01R', 21.00, 20.00, NULL, NULL, '⭐ Precio Vara Luminosa Naranja Recargable: 🔸Por una caja - S/ 21.00 c/u 🔸 Por 5 cajas - S/ 20.00 c/u 🔸 En una caja vienen 50 unidades'),
('CZ-A01', 12.00, 11.50, NULL, NULL, '⭐ Cinta Antideslizante A/N 2cm x 18m: 🔸 Por Caja - S/ 12.00 c/u 🔸 Por 5 cajas - S/ 11.50 c/u 🔸 En una caja vienen 50 unidades'),
('CZ-A02', 22.50, 21.50, NULL, NULL, '⭐ Cinta Antideslizante A/N 5cm x 18m: 🔸 Por Caja - S/ 22.50 c/u 🔸 Por 5 Cajas - S/ 21.50 c/u 🔸 En una caja vienen 50 unidades'),
('ZE-001', 18.90, 18.70, NULL, NULL, '🔄 Interruptor Simple ZE-01 – ⭐ Ideal para cualquier ambiente. 📦 Caja x10 unidades → S/18.90 Soles'),
('ZE-002', 26.00, 25.80, NULL, NULL, '🔄 Interruptor Doble ZE-02 – ⭐ Controla 2 puntos de luz desde un solo lugar. 📦 Caja x10 unidades → S/26.00 Soles'),
('ZE-003', 32.00, 31.80, NULL, NULL, '🔄 Interruptor Triple ZE-03 – ⭐ Controla hasta 3 puntos de luz con un solo dispositivo. 📦 Caja x10 unidades → S/32 Soles'),
('ZE-004', 20.50, 20.30, NULL, NULL, '🔄 Conmutador Simple ZE-04 – ⭐ Control de una misma luz desde dos lugares. 📦 Caja x10 → S/20.50 Soles'),
('ZE-005', 29.20, 29.00, NULL, NULL, '🔄 Conmutador Doble ZE-05 – ⭐ Versatilidad para manejar 2 circuitos desde diferentes accesos. 📦 Caja x10 → S/29.20 Soles'),
('ZE-006', 36.60, 36.40, NULL, NULL, '🔄 Conmutador Triple ZE-06 – ⭐ Máxima funcionalidad para espacios con múltiples accesos. 📦 Caja x10 → S/36.60 Soles'),
('ZE-007', 20.50, 20.30, NULL, NULL, '🔄 ZE-07 – Tomacorriente Simple S – ⭐ Seguridad y resistencia, fabricado con materiales de alta calidad. 📦 Caja x10 → S/20.50 Soles'),
('ZE-008', 27.40, 27.20, NULL, NULL, '🔄 ZE-08 – Tomacorriente Doble S –  ⭐ Mayor capacidad, permite conectar dos dispositivos a la vez de manera segura. 📦 Caja x10 → S/27.40 Soles'),
('ZE-009', 36.60, 36.40, NULL, NULL, '🔄 ZE-09 – Tomacorriente Triple S –  ⭐ Solución práctica y eficiente para múltiples conexiones en un solo punto. 📦 Caja x10 → S/36.60 Soles'),
('ZE-010', 21.40, 21.20, NULL, NULL, '🔄 ZE-10 – Tomacorriente Simple A –  ⭐ Modelo clásico y funcional, ideal para cualquier espacio. 📦 Caja x10 → S/21.40 Soles'),
('ZE-011', 29.20, 29.00, NULL, NULL, '🔄 ZE-11 – Tomacorriente Doble A – ⭐ Permite conectar dos dispositivos al mismo tiempo. 📦 Caja x10 → S/29.20 Soles'),
('ZE-012', 44.50, 44.30, NULL, NULL, '🔄 ZE-12 – Tomacorriente Triple A – ⭐ Máxima funcionalidad, permite conectar hasta tres equipos. 📦 Caja x10 → S/44.50 Soles'),
('CZ-SPB10', 120.00, 118.00, NULL, NULL, '⭐ Camilla de Seguridad Naranja 🔸 1 caja - S/ 120.00 (1 unidad💘) 🔸 5 cajas - S/ 118.00 (1 unidad💘) 🔸 En una caja viene 1 unidad'),
('LZ-ILM20', 59.00, 58.00, NULL, NULL, '⭐ Linterna Minera KJ13.5LM 🔸 1 caja - S/ 59.00 Cada una 🔸 5 cajas - S/ 58.00 Cada una 🔸 En una caja vienen 36 unidades'),
('PZ-SFS01', 6.50, 5.50, NULL, NULL, '⭐ Protector Facial Ajustable 🔸 1 caja - S/ 6.50 Cada una 🔸 5 cajas - S/ 5.50 Cada una 🔸 En una caja vienen 40 unidades'),
('PZ-SFS03', 6.50, 5.50, NULL, NULL, '⭐ Careta para Soldar 🔸 1 caja - S/ 6.50 Cada una 🔸 5 cajas - S/ 5.50 Cada una 🔸 En una caja vienen 40 unidades'),
('PZ-SFS02', 6.50, 5.50, NULL, NULL, '⭐ Visor Facial 🔸 1 caja - S/ 6.50 Cada una 🔸 5 cajas - S/ 5.50 Cada una 🔸 En una caja vienen 40 unidades'),
('MZ-FBK500', 80.00, 75.00, NULL, NULL, '⭐ Manta Ignífuga 🔸 1 caja - S/ 80.00 Cada una 🔸 5 cajas - S/ 75.00 Cada una 🔸 En una caja vienen 50 unidades'),
('IC-HIM200', 140.00, 138.00, NULL, NULL, '⭐ Inmovilizador de Cabeza 🔸 1 caja - S/ 140.00 Cada una 🔸 5 cajas - S/ 138.00 Cada una 🔸 En una caja vienen 10 unidades'),
('SZ-SST300', 35.00, 33.00, NULL, NULL, '⭐ Correa de Araña 🔸 1 caja - S/ 35.00 Cada una 🔸 5 cajas - S/ 33.00 Cada una 🔸 En una caja vienen 20 unidades'),
('CZ-CNB400', 22.00, 21.00, NULL, NULL, '⭐ Collarín Cervical 🔸 1 caja - S/ 22.00 Cada una 🔸 5 cajas - S/ 21.00 Cada una 🔸 En una caja vienen 20 unidades'),
('GZ-N410-9', NULL, NULL, NULL, NULL, '⭐ Precio Guantes Thermo Plus'),
('GZ-A60-9', NULL, NULL, NULL, NULL, '⭐ Precio Guantes Ultrablue'),
('GZ-PVC30-9', NULL, NULL, NULL, NULL, '⭐ Precio Guantes Flexiblue')
AS n
ON DUPLICATE KEY UPDATE 
    Caja_1 = n.Caja_1,
    Caja_5 = n.Caja_5,
    Caja_10 = n.Caja_10,
    Caja_20 = n.Caja_20,
    texto_copiar = n.texto_copiar;
--    
    ALTER TABLE Malvinas_online ADD UNIQUE (Codigo);
--    
    SET SQL_SAFE_UPDATES = 0;
    UPDATE Productos_franja SET Codigo = TRIM(Codigo);
    SET SQL_SAFE_UPDATES = 1;
--    
select * from Malvinas_online;    
--
--
-- PROVINCIA - ONLINE
CREATE TABLE Provincia_online (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Codigo VARCHAR(50) NOT NULL,
    Docena DECIMAL(10, 2),
    Caja_1 DECIMAL(10, 2),
    Caja_5 DECIMAL(10, 2),
    Caja_10 DECIMAL(10, 2),
    texto_copiar TEXT,
    FOREIGN KEY (Codigo) REFERENCES Productos_franja(Codigo) ON DELETE CASCADE
);
--
INSERT INTO Provincia_online (Codigo, Docena, Caja_1, Caja_5, Caja_10, texto_copiar) VALUES
('GZ-L102-8', 33.00, 31.00, 30.00, NULL, '✅ Precio Guantes Duraflex: ✔️ 1 docena - S/ 33.00 ✔️ 1 caja - S/ 310 (31.00 soles cada docena🔥) ✔️ 5 cajas - S/ 300 (30.00 soles cada docena🔥)  ✔️ En una caja vienen 10 docenas'),
('GZ-L202-8', 30.00, 27.00, 25.50, 24.50, '✅ Precio Guantes Econoflex : ✔️ 1 docena - S/ 30.00 ✔️ 1 caja - S/ 270 (27.00 soles cada docena🔥) ✔️ 5 cajas - S/ 255 (25.50 soles cada docena🔥) ✔️ 10 cajas - S/ 245 (24.50 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-L410-8', 39.00, 36.50, 35.00, NULL, '✅ Precio Guantes Fortflex : ✔️ 1 docena - S/ 39.00 ✔️ 1 caja - S/ 365 (36.50 soles cada docena🔥) ✔️ 5 cajas - S/ 350 (35.00 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-L501-9', 31.00, 28.50, 27.50, NULL, '✅ Precio Guantes Dumax : ✔️ 1 docena - S/ 31.00 ✔️ 1 caja - S/ 570 (28.50 soles cada docena🔥) ✔️ 5 cajas - S/ 550 (27.50 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-L511-9', 35.00, 32.00, 31.00, NULL, '✅ Precio Guantes Trimax : ✔️ 1 docena - S/ 35.00 ✔️ 1 caja - S/ 640 (32.00 soles cada docena🔥) ✔️ 5 cajas - S/ 620 (31.00 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-N310-8', 42.00, 38.00, 36.50, NULL, '✅ Precio Guantes Impermeable : ✔️ 1 docena - S/ 42.00 ✔️ 1 caja - S/ 380 (38.00 soles cada docena🔥) ✔️ 5 cajas - S/ 365 (36.50 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-PU103-6', 23.00, 21.00, 20.00, NULL, '✅ Precio Guantes Puflex : ✔️ 1 docena - S/ 23.00 ✔️ 1 caja - S/ 420 (21.00 soles cada docena🔥) ✔️ 5 cajas - S/ 400 (20.00 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-PU203-7', 20.00, 18.00, NULL, NULL, '✅ Precio Guantes Puflex Floreado: ✔️ 1 docena - S/ 20.00 ✔️ 1 caja - S/ 360 (18.00 soles cada docena🔥)  ✔️ En una caja vienen 20 docenas'),
('GZ-L601-9', 32.00, 30.00, 28.50, NULL, '✅ Precio Guantes Lastiflex : ✔️ 1 docena - S/ 32.00 ✔️ 1 caja - S/ 600 (30.00 soles cada docena🔥) ✔️ 5 cajas - S/ 570 (28.50 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-N103-9', 24.50, 22.50, 21.50, NULL, '✅ Precio Guantes Nitriflex : ✔️ 1 docena - S/ 24.50 ✔️ 1 caja - S/ 562.50 (22.50 soles cada docena🔥) ✔️ 5 cajas - S/ 537.50 (21.50 soles cada docena🔥) ✔️ En una caja vienen 25 docenas'),
('GZ-L303-8', 25.00, 23.00, 22.00, NULL, '✅ Precio Guantes Stiflex : ✔️ 1 docena - S/ 25.00 ✔️ 1 caja - S/ 460 (23.00 soles cada docena🔥) ✔️ 5 cajas - S/ 440 (22.00 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-N201-9', 58.00, 54.00, 52.00, NULL, '✅ Precio Guantes Nitron Cerrado: ✔️ 1 docena - S/ 58.00 ✔️ 1 caja - S/ 540 (54.00 soles cada docena🔥) ✔️ 5 cajas - S/ 520 (52.00 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-N202-9', 58.00, 55.00, 53.00, NULL, '✅ Precio Guantes Nitron Abierto: ✔️ 1 docena - S/ 58.00 ✔️ 1 caja - S/ 550 (55.00 soles cada docena🔥) ✔️ 5 cajas - S/ 530 (53.00 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-AC01-7', 85.00, 80.00, 78.50, NULL, '✅ Precio Guantes CUT 5 : ✔️ 1 docena - S/ 85.00 ✔️ 1 caja - S/ 800 (80.00 soles cada docena🔥) ✔️ 5 cajas - S/ 785 (78.50 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-R101-10', 55.00, 50.00, 48.00, NULL, '✅ Precio Guantes Ultraflex : ✔️ 1 docena - S/ 55.00 ✔️ 1 caja - S/ 1000 (50.00 soles cada docena🔥) ✔️ 5 cajas - S/ 960 (48.00 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-C204-9', 58.00, 53.00, 51.50, NULL, '✅ Precio Badana Blanco Nacional: ✔️ 1 docena - S/ 58.00 ✔️ 1 caja - S/ 530 (53.00 soles cada docena🔥) ✔️ 5 cajas - S/ 515 (51.50 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-C201-9', 62.00, 58.00, 56.50, NULL, '✅ Precio Badana Blanco: ✔️ 1 docena - S/ 62.00 ✔️ 1 caja - S/ 580 (58.00 soles cada docena🔥) ✔️ 5 cajas - S/ 565 (56.50 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-C202-9', 63.00, 59.00, 57.50, NULL, '✅ Precio Badana Amarillo: ✔️ 1 docena - S/ 63.00 ✔️ 1 caja - S/ 590 (59.00 soles cada docena🔥) ✔️ 5 cajas - S/ 575 (57.50 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-C102-9', 55.00, 52.00, 50.00, NULL, '✅ Precio Carnaza: ✔️ 1 docena - S/ 55.00 ✔️ 1 caja - S/ 520 (52.00 soles cada docena🔥) ✔️ 5 cajas - S/ 500 (50.00 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('LZ-AF102-O', 32.00, 29.50, 28.50, NULL, '✅ Precio Lentes Intensity AF: ✔️ 1 docena - S/ 32.00 ✔️ 1 caja - S/ 737.50 (29.50 soles cada docena🔥) ✔️ 5 cajas - S/ 712.50 (28.50 soles cada docena🔥) ✔️ En una caja vienen 25 docenas'),
('LZ-HC102-O', 20.00, 17.50, 16.50, NULL, '✅ Precio Lentes Intensity HC: ✔️ 1 docena - S/ 20.00 ✔️ 1 caja - S/ 437.50 (17.50 soles cada docena🔥) ✔️ 5 cajas - S/ 412.50 (16.50 soles cada docena🔥) ✔️ En una caja vienen 25 docenas'),
('LZ-AF201-C', 31.00, 28.50, 27.50, NULL, '✅ Precio Sport Vision AF: ✔️ 1 docena - S/ 31.00 ✔️ 1 caja - S/ 712.50 (28.50 soles cada docena🔥) ✔️ 5 cajas - S/ 687.50 (27.50 soles cada docena🔥) ✔️ En una caja vienen 25 docenas'),
('OZ-M1001-L', NULL, 5.50, 5.00, NULL, '✅ Precio Overol Blanco L / XL ✔️ 1 Unidad - S/ 5.50 ✔️ 1 Caja - S/ 5.00 Cada una ✔️ En una caja vienen 50 unidades'),
('ZP-PS02A', NULL, 16.00, 15.50, NULL, '✅ Precio Capotin Enjebado ✔️ 1 Unidad - S/ 16.00 ✔️ 1 Caja - S/ 15.50 Cada una ✔️ En una caja vienen 20 unidades'),
('ZP-PS01-AM', NULL, 16.00, 15.50, NULL, '✅ Precio Poncho Enjebado ✔️ 1 Unidad - S/ 16.00 ✔️ 1 Caja - S/ 15.50 Cada una ✔️ En una caja vienen 20 unidades'),
('CZ-C01A', NULL, 5.80, 5.40, NULL, '✅ Precio Casco de Seguridad ✔️ 1 Unidad - S/ 5.80 ✔️ 1 Caja - S/ 5.40 Cada una ✔️ En una caja vienen 50 unidades'),
('MZ-M101', NULL, 24.50, 24.00, NULL, '✅ Precio Mallas de Seguridad ✔️ 1 Rollo - S/ 24.50 ✔️ 1 Caja - S/ 24.00 Cada una ✔️ En una caja vienen 6 unidades'),
('RZ-S2097', NULL, 23.00, 22.00, NULL, '✅ Respiradores 7502 + Filtro 2097 ✔️ 1 Unidad - S/ 23.00 ✔️ 1 Caja - S/ 22.00 Cada una ✔️ En una caja vienen 40 unidades'),
('CZ-SPB10', NULL, 135.00, 130.00, NULL, '✅ Camilla de Seguridad Naranja ✔️ 1 Unidad - S/ 135.00 ✔️ 5 Unidades - S/ 130.00 Cada una ✔️ En una caja viene 1 unidad'),
('LZ-ILM20', NULL, 62.00, 60.50, NULL, '✅ Linterna Minera KJ13.5LM ✔️ 1 Unidad - S/ 62.00 ✔️ 5 Caja- S/ 60.50 Cada una ✔️ En una caja vienen 36 unidades'),
('PZ-SFS01', NULL, 11.00, 9.00, NULL, '✅ Protector Facial Ajustable ✔️ 1 Unidad - S/ 11 c/u ✔️ 1 Caja - S/ 9 Cada una ✔️ En una caja vienen 40 unidades'),
('PZ-SFS03', NULL, 11.00, 9.00, NULL, '✅ Careta para Soldar ✔️ 1 Unidad - S/ 11 Cada una ✔️ 1 Caja - S/ 9 Cada una ✔️ En una caja vienen 40 unidades'),
('PZ-SFS02', NULL, 11.00, 9.00, NULL, '✅ Visor Facial ✔️ 1 Unidad - S/ 11 Cada una ✔️ 1 Caja - S/ 9 Cada una ✔️ En una caja vienen 40 unidades')
AS n
ON DUPLICATE KEY UPDATE 
    Docena = n.Docena,
    Caja_1 = n.Caja_1,
    Caja_5 = n.Caja_5,
    Caja_10 = n.Caja_10,
    texto_copiar = n.texto_copiar;
--
	ALTER TABLE Provincia_online ADD UNIQUE (Codigo);
--
	SET SQL_SAFE_UPDATES = 0;
    UPDATE Productos_franja SET Codigo = TRIM(Codigo);
    SET SQL_SAFE_UPDATES = 1;
--
Select * from Provincia_online;
--
-- FERRETERIA - ONLINE
CREATE TABLE Ferreteria_online (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Codigo VARCHAR(50) NOT NULL,
    Docena DECIMAL(10, 2),
    Caja_1 DECIMAL(10, 2),
    texto_copiar TEXT,
    FOREIGN KEY (Codigo) REFERENCES Productos_franja(Codigo) ON DELETE CASCADE
);
--
INSERT INTO Ferreteria_online (Codigo, Docena, Caja_1, texto_copiar) VALUES
('GZ-L102-8', 39.00, 35.00, '✅ Precio Guantes Duraflex: ✔️ 1 docena - S/ 39 ✔️ 1 caja - S/ 350 (35 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-L202-8', 35.00, 30.00, '✅ Precio Guantes Econoflex: ✔️ 1 docena - S/ 35 ✔️ 1 caja - S/ 300 (30 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-L410-8', 42.00, 40.00, '✅ Precio Guantes Fortflex: ✔️ 1 docena - S/ 42 ✔️ 1 caja - S/ 400 (40 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-L501-9', 34.00, 32.00, '✅ Precio Guantes Dumax: ✔️ 1 docena - S/ 34 ✔️ 1 caja - S/ 640 (32 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-L511-9', 38.00, 36.00, '✅ Precio Guantes Trimax: ✔️ 1 docena - S/ 38 ✔️ 1 caja - S/ 720 (36 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-N310-8', 45.00, 42.00, '✅ Precio Guantes Impermeable: ✔️ 1 docena - S/ 45 ✔️ 1 caja - S/ 420 (42 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-PU103-6', 26.00, 24.00, '✅ Precio Guantes Puflex: ✔️ 1 docena - S/ 26 ✔️ 1 caja - S/ 480 (24 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-PU203-7', 22.00, 20.00, '✅ Precio Guantes Puflex Floreado: ✔️ 1 docena - S/ 22 ✔️ 1 caja - S/ 400 (20 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-L601-9', 35.00, 32.00, '✅ Precio Guantes Lastiflex: ✔️ 1 docena - S/ 35 ✔️ 1 caja - S/ 640 (32 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-N103-9', 28.00, 26.00, '✅ Precio Guantes Nitriflex: ✔️ 1 docena - S/ 28 ✔️ 1 caja - S/ 650 (26 soles cada docena🔥) ✔️ En una caja vienen 25 docenas'),
('GZ-L303-8', 28.00, 25.00, '✅ Precio Guantes Stiflex: ✔️ 1 docena - S/ 28 ✔️ 1 caja - S/ 500 (25 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-N201-9', 62.00, 58.00, '✅ Precio Guantes Nitron Cerrado: ✔️ 1 docena - S/ 62 ✔️ 1 caja - S/ 580 (58 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-N202-9', 63.00, 60.00, '✅ Precio Guantes Nitron Abierto: ✔️ 1 docena - S/ 63 ✔️ 1 caja - S/ 600 (60 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-AC01-7', 95.00, 90.00, '✅ Precio Guantes CUT 5: ✔️ 1 docena - S/ 95 ✔️ 1 caja - S/ 900 (90 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-R101-10', 60.00, 55.00, '✅ Precio Guantes Ultraflex: ✔️ 1 docena - S/ 60 ✔️ 1 caja - S/ 1100 (55 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-C204-9', 62.00, 58.00, '✅ Precio Badana Blanco Nacional Amarillo o Blanco: ✔️ 1 docena - S/ 62 ✔️ 1 caja - S/ 580 (58 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-C201-9', 68.00, 64.00, '✅ Precio Badana Blanco: ✔️ 1 docena - S/ 68 ✔️ 1 caja - S/ 640 (64 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-C202-9', 70.00, 65.00, '✅ Precio Badana Amarillo: ✔️ 1 docena - S/ 70 ✔️ 1 caja - S/ 650 (65 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-C102-9', 60.00, 55.00, '✅ Precio Carnaza: ✔️ 1 docena - S/ 60 ✔️ 1 caja - S/ 550 (55 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('LZ-AF102-O', 35.00, 32.00, '✅ Precio Lentes AF Oscuro: ✔️ 1 docena - S/ 35 ✔️ 1 caja - S/ 800 (32 soles cada docena🔥) ✔️ En una caja vienen 25 docenas'),
('LZ-HC102-O', 22.00, 19.00, '✅ Precio Lentes HC Intensity Oscuro: ✔️ 1 docena - S/ 22 ✔️ 1 caja - S/ 475 (19 soles cada docena🔥) ✔️ En una caja vienen 25 docenas'),
('LZ-AF201-C', 35.00, 32.00, '✅ Precio Sport Vision AF Oscuro / Claro: ✔️ 1 docena - S/ 35 ✔️ 1 caja - S/ 800 (32 soles cada docena🔥) ✔️ En una caja vienen 25 docenas'),
('OZ-M1001-L', 7.50, 6.50, '✅ Precio Overol Blanco L: ✔️ 1 unidad - S/ 7.50 ✔️ 1 caja - S/ 325 (6.50 soles cada uno🔥) ✔️ En una caja vienen 50 unidades'),
('ZP-PS02A', 20.00, 18.00, '✅ Precio Capotin Enjebado: ✔️ 1 unidad - S/ 20 ✔️ 1 caja - S/ 360 (18 soles cada uno🔥) ✔️ En una caja vienen 20 unidades'),
('ZP-PS01-AM', 20.00, 18.00, '✅ Precio Poncho Enjebado: ✔️ 1 unidad - S/ 20 ✔️ 1 caja - S/ 360 (18 soles cada uno🔥) ✔️ En una caja vienen 20 unidades'),
('CZ-C01A', 8.50, 7.50, '✅ Precio Casco Amarillo: ✔️ 1 unidad - S/ 8.50 ✔️ 1 caja - S/ 375 (7.50 soles cada uno🔥) ✔️ En una caja vienen 50 unidades'),
('MZ-M101', 28.00, 26.00, '✅ Precio Mallas de Seguridad: ✔️ 1 unidad - S/ 28 ✔️ 1 caja - S/ 156 (26 soles cada uno🔥) ✔️ En una caja vienen 6 unidades'),
('RZ-S2097', 28.00, 25.00, '✅ Respiradores 7502 + Filtro 2097: ✔️ 1 unidad - S/ 28 ✔️ 1 caja - S/ 1000 (25 soles cada uno🔥) ✔️ En una caja vienen 40 unidades'),
('ZE-001', 25.00, 22.00, '🔘 Interruptor Simple ZE-01 – ✅ Ideal para cualquier ambiente. 📦 Cajita x 10 → S/22 Soles'),
('ZE-002', 32.00, 28.00, '🔘 Interruptor Doble ZE-02 – ✅ Controla 2 puntos de luz desde un solo lugar. 📦 Cajita x 10 → S/28 Soles'),
('ZE-003', 38.00, 34.00, '🔘 Interruptor Triple ZE-03 – ✅ Controla hasta 3 puntos de luz con un solo dispositivo. 📦 Cajita x 10 → S/34 Soles'),
('ZE-004', 26.00, 23.00, '🔘 Conmutador Simple ZE-04 – ✅ Control de una misma luz desde dos lugares. 📦 Cajita x 10 → S/23 Soles'),
('ZE-005', 35.00, 31.00, '🔘 Conmutador Doble ZE-05 – ✅ Versatilidad para manejar 2 circuitos desde diferentes accesos. 📦 Cajita x 10 → S/31 Soles'),
('ZE-006', 42.00, 38.00, '🔘 Conmutador Triple ZE-06 – ✅ Máxima funcionalidad para espacios con múltiples accesos. 📦 Cajita x 10 → S/38 Soles'),
('ZE-007', 26.00, 23.00, '🔘 ZE-07 – Tomacorriente Simple S – ✅ Seguridad y resistencia, fabricado con materiales de alta calidad. 📦 Cajita x 10 → S/23 Soles'),
('ZE-008', 35.00, 30.00, '🔘 ZE-08 – Tomacorriente Doble S – ✅ Mayor capacidad, permite conectar dos dispositivos a la vez de manera segura. 📦 Cajita x 10 → S/30 Soles'),
('ZE-009', 42.00, 38.00, '🔘 ZE-09 – Tomacorriente Triple S – ✅ Solución práctica y eficiente para múltiples conexiones en un solo punto. 📦 Cajita x 10 → S/38 Soles'),
('ZE-010', 28.00, 24.00, '🔘 ZE-10 – Tomacorriente Simple A – ✅ Modelo clásico y funcional, ideal para cualquier espacio. 📦 Cajita x 10 → S/24 Soles'),
('ZE-011', 35.00, 30.00, '🔘 ZE-11 – Tomacorriente Doble A – ✅ Permite conectar dos dispositivos al mismo tiempo. 📦 Cajita x 10 → S/30 Soles'),
('ZE-012', 48.00, 45.00, '🔘 ZE-12 – Tomacorriente Triple A – ✅ Máxima funcionalidad, permite conectar hasta tres equipos. 📦 Cajita x 10 → S/45 Soles'),
('CZ-SPB10', 128.00, 125.00, '✅ Camilla de Seguridad Naranja ✔️ 1 Unidad - S/ 128 ✔️ 1 Caja - S/ 125 (1 unidad🔥) ✔️ En una caja viene 1 unidad'),
('LZ-ILM20', 65.00, 61.00, '✅ Linterna Minera KJ13.5LM ✔️ 1 Unidad- S/ 65 ✔️ Por una caja- S/ 61 Cada una ✔️ En una caja vienen 36 unidades'),
('PZ-SFS01', 13.00, 12.00, '✅ Protector Facial Ajustable ✔️ 1 Unidad - S/ 13 ✔️ Por una caja - S/ 12 Cada una ✔️ En una caja vienen 40 unidades'),
('PZ-SFS03', 13.00, 12.00, '✅ Careta para Soldar ✔️ 1 Unidad - S/ 13 ✔️ Por una caja - S/ 12 Cada una ✔️ En una caja vienen 40 unidades'),
('PZ-SFS02', 13.00, 12.00, '✅ Visor Facial ✔️ 1 Unidad - S/ 13 ✔️ Por una caja - S/ 12 Cada una ✔️ En una caja vienen 40 unidades'),
('MZ-FBK500', 98.00, 95.00, '✅ Manta Ignífuga ✔️ 1 Unidad - S/ 98 ✔️ Por una caja - S/ 95 Cada una ✔️ En una caja vienen 50 unidades')
AS n
ON DUPLICATE KEY UPDATE 
    Docena = n.Docena,
    Caja_1 = n.Caja_1,
    texto_copiar = n.texto_copiar;
--
	ALTER TABLE Ferreteria_online ADD UNIQUE (Codigo);
--
	SET SQL_SAFE_UPDATES = 0;
    UPDATE Productos_franja SET Codigo = TRIM(Codigo);
    SET SQL_SAFE_UPDATES = 1;
--
Select * from Ferreteria_online;
--
-- CLIENTES FINALES - ONLINE
CREATE TABLE Clientes_finales_online (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Codigo VARCHAR(50) NOT NULL,
    Docena DECIMAL(10, 2),
    Caja_1 DECIMAL(10, 2),
    Caja_5 DECIMAL(10, 2),
    texto_copiar TEXT,
    FOREIGN KEY (Codigo) REFERENCES Productos_franja(Codigo) ON DELETE CASCADE
);
--
INSERT INTO Clientes_finales_online (Codigo, Docena, Caja_1, Caja_5, texto_copiar) VALUES
('GZ-L102-8', 44.00, 42.00, NULL, '✅ Precio Guantes Duraflex: ✔️ 1 docena - S/ 44 ✔️ 1 caja - S/ 420 (42 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-L202-8', 40.00, 38.00, NULL, '✅ Precio Guantes Econoflex: ✔️ 1 docena - S/ 40 ✔️ 1 caja - S/ 380 (38 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-L410-8', 47.00, 45.00, NULL, '✅ Precio Guantes Fortflex: ✔️ 1 docena - S/ 47 ✔️ 1 caja - S/ 450 (45 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-L501-9', 37.00, 35.00, NULL, '✅ Precio Guantes Dumax: ✔️ 1 docena - S/ 37 ✔️ 1 caja - S/ 700 (35 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-L511-9', 41.00, 39.00, NULL, '✅ Precio Guantes Trimax: ✔️ 1 docena - S/ 41 ✔️ 1 caja - S/ 780 (39 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-N310-8', 50.00, 48.00, NULL, '✅ Precio Guantes Impermeable: ✔️ 1 docena - S/ 50 ✔️ 1 caja - S/ 480 (48 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-PU103-6', 29.00, 27.00, NULL, '✅ Precio Guantes Puflex: ✔️ 1 docena - S/ 29 ✔️ 1 caja - S/ 540 (27 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-PU203-7', 25.00, 23.00, NULL, '✅ Precio Guantes Puflex Floreado: ✔️ 1 docena - S/ 25 ✔️ 1 caja - S/ 460 (23 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-L601-9', 38.00, 36.00, NULL, '✅ Precio Guantes Lastiflex: ✔️ 1 docena - S/ 38 ✔️ 1 caja - S/ 720 (36 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-N103-9', 30.00, 28.00, NULL, '✅ Precio Guantes Nitriflex: ✔️ 1 docena - S/ 30 ✔️ 1 caja - S/ 700 (28 soles cada docena🔥) ✔️ En una caja vienen 25 docenas'),
('GZ-L303-8', 31.00, 29.00, NULL, '✅ Precio Guantes Stiflex: ✔️ 1 docena - S/ 31 ✔️ 1 caja - S/ 580 (29 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-N201-9', 65.00, 62.00, NULL, '✅ Precio Guantes Nitron Cerrado: ✔️ 1 docena - S/ 65 ✔️ 1 caja - S/ 620 (62 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-N202-9', 66.00, 64.00, NULL, '✅ Precio Guantes Nitron Abierto: ✔️ 1 docena - S/ 66 ✔️ 1 caja - S/ 640 (64 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-AC01-7', 98.00, 95.00, NULL, '✅ Precio Guantes CUT 5: ✔️ 1 docena - S/ 98 ✔️ 1 caja - S/ 950 (95 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-R101-10', 64.00, 60.00, NULL, '✅ Precio Guantes Ultraflex: ✔️ 1 docena - S/ 64 ✔️ 1 caja - S/ 1200 (60 soles cada docena🔥) ✔️ En una caja vienen 20 docenas'),
('GZ-C204-9', 65.00, 62.00, NULL, '✅ Precio Badana Blanco Nacional Amarillo o Blanco: ✔️ 1 docena - S/ 65 ✔️ 1 caja - S/ 620 (62 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-C201-9', 72.00, 68.00, NULL, '✅ Precio Badana Blanco: ✔️ 1 docena - S/ 72 ✔️ 1 caja - S/ 680 (68 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-C202-9', 74.00, 70.00, NULL, '✅ Precio Badana Amarillo: ✔️ 1 docena - S/ 74 ✔️ 1 caja - S/ 700 (70 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('GZ-C102-9', 65.00, 60.00, NULL, '✅ Precio Carnaza: ✔️ 1 docena - S/ 65 ✔️ 1 caja - S/ 600 (60 soles cada docena🔥) ✔️ En una caja vienen 10 docenas'),
('LZ-AF102-O', 38.00, 36.00, NULL, '✅ Precio Lentes AF Oscuro: ✔️ 1 docena - S/ 38 ✔️ 1 caja - S/ 900 (36 soles cada docena🔥) ✔️ En una caja vienen 25 docenas'),
('LZ-HC102-O', 25.00, 22.00, NULL, '✅ Precio Lentes HC Intensity Oscuro: ✔️ 1 docena - S/ 25 ✔️ 1 caja - S/ 550 (22 soles cada docena🔥) ✔️ En una caja vienen 25 docenas'),
('LZ-AF201-C', 38.00, 36.00, NULL, '✅ Precio Sport Vision AF Oscuro / Claro: ✔️ 1 docena - S/ 38 ✔️ 1 caja - S/ 900 (36 soles cada docena🔥) ✔️ En una caja vienen 25 docenas'),
('OZ-M1001-L', 9.50, 8.50, NULL, '✅ Precio Overol Blanco L: ✔️ 1 unidad - S/ 9.50 ✔️ 1 caja - S/ 425 (8.50 soles cada uno🔥) ✔️ En una caja vienen 50 unidades'),
('ZP-PS02A', 24.00, 22.00, NULL, '✅ Precio Capotin Enjebado: ✔️ 1 unidad - S/ 24 ✔️ 1 caja - S/ 440 (22 soles cada uno🔥) ✔️ En una caja vienen 20 unidades'),
('ZP-PS01-AM', 24.00, 22.00, NULL, '✅ Precio Poncho Enjebado: ✔️ 1 unidad - S/ 24 ✔️ 1 caja - S/ 440 (22 soles cada uno🔥) ✔️ En una caja vienen 20 unidades'),
('CZ-C01A', 11.00, 10.00, NULL, '✅ Precio Casco Amarillo: ✔️ 1 unidad - S/ 11 ✔️ 1 caja - S/ 500 (10 soles cada uno🔥) ✔️ En una caja vienen 50 unidades'),
('MZ-M101', 32.00, 30.00, NULL, '✅ Precio Mallas de Seguridad: ✔️ 1 unidad - S/ 32 ✔️ 1 caja - S/ 180 (30 soles cada uno🔥) ✔️ En una caja vienen 6 unidades'),
('RZ-S2097', 32.00, 30.00, NULL, '✅ Respiradores 7502 + Filtro 2097: ✔️ 1 unidad - S/ 32 ✔️ 1 caja - S/ 1200 (30 soles cada uno🔥) ✔️ En una caja vienen 40 unidades'),
('ZE-001', 30.00, 26.00, NULL, '🔘 Interruptor Simple ZE-01 – ✅ Ideal para cualquier ambiente. 📦 Cajita x 10 → S/26 Soles'),
('ZE-002', 38.00, 34.00, NULL, '🔘 Interruptor Doble ZE-02 – ✅ Controla 2 puntos de luz desde un solo lugar. 📦 Cajita x 10 → S/34 Soles'),
('ZE-003', 42.00, 38.00, NULL, '🔘 Interruptor Triple ZE-03 – ✅ Controla hasta 3 puntos de luz con un solo dispositivo. 📦 Cajita x 10 → S/38 Soles'),
('ZE-004', 32.00, 28.00, NULL, '🔘 Conmutador Simple ZE-04 – ✅ Control de una misma luz desde dos lugares. 📦 Cajita x 10 → S/28 Soles'),
('ZE-005', 40.00, 36.00, NULL, '🔘 Conmutador Doble ZE-05 – ✅ Versatilidad para manejar 2 circuitos desde diferentes accesos. 📦 Cajita x 10 → S/36 Soles'),
('ZE-006', 48.00, 44.00, NULL, '🔘 Conmutador Triple ZE-06 – ✅ Máxima funcionalidad para espacios con múltiples accesos. 📦 Cajita x 10 → S/44 Soles'),
('ZE-007', 32.00, 28.00, NULL, '🔘 ZE-07 – Tomacorriente Simple S – ✅ Seguridad y resistencia, fabricado con materiales de alta calidad. 📦 Cajita x 10 → S/28 Soles'),
('ZE-008', 40.00, 35.00, NULL, '🔘 ZE-08 – Tomacorriente Doble S – ✅ Mayor capacidad, permite conectar dos dispositivos a la vez de manera segura. 📦 Cajita x 10 → S/35 Soles'),
('ZE-009', 48.00, 44.00, NULL, '🔘 ZE-09 – Tomacorriente Triple S – ✅ Solución práctica y eficiente para múltiples conexiones en un solo punto. 📦 Cajita x 10 → S/44 Soles'),
('ZE-010', 35.00, 31.00, NULL, '🔘 ZE-10 – Tomacorriente Simple A – ✅ Modelo clásico y funcional, ideal para cualquier espacio. 📦 Cajita x 10 → S/31 Soles'),
('ZE-011', 40.00, 35.00, NULL, '🔘 ZE-11 – Tomacorriente Doble A – ✅ Permite conectar dos dispositivos al mismo tiempo. 📦 Cajita x 10 → S/35 Soles'),
('ZE-012', 55.00, 51.00, NULL, '🔘 ZE-12 – Tomacorriente Triple A – ✅ Máxima funcionalidad, permite conectar hasta tres equipos. 📦 Cajita x 10 → S/51 Soles'),
('CZ-SPB10', 133.00, 131.00, NULL, '✅ Camilla de Seguridad Naranja ✔️ 1 Unidad - S/ 133  ✔️ 1 Caja - S/ 131 (1 unidad🔥) ✔️ En una caja viene 1 unidad'),
('LZ-ILM20', 68.00, 66.00, NULL, '✅ Linterna Minera KJ13.5LM ✔️ 1 Unidad- S/ 68 ✔️ 1 Caja- S/ 66 Cada una ✔️ En una caja vienen 36 unidades'),
('PZ-SFS01', 18.00, 16.00, NULL, '✅ Protector Facial Ajustable ✔️ 1 Unidad - S/ 18 ✔️ 1 Caja - S/ 16 Cada una ✔️ En una caja vienen 40 unidades'),
('PZ-SFS03', 18.00, 16.00, NULL, '✅ Careta para Soldar ✔️ 1 Unidad - S/ 18 ✔️ 1 Caja - S/ 16 Cada una ✔️ En una caja vienen 40 unidades'),
('PZ-SFS02', 18.00, 16.00, NULL, '✅ Visor Facial ✔️ 1 Unidad - S/ 18 ✔️ 1 Caja - S/ 16 Cada una ✔️ En una caja vienen 40 unidades'),
('MZ-FBK500', 115.00, 110.00, NULL, '✅ Manta Ignífuga ✔️ 1 Unidad - S/ 115 Cada una ✔️ 1 caja - S/ 110 Cada una ✔️ En una caja vienen 50 unidades')
AS n
ON DUPLICATE KEY UPDATE 
    Docena = n.Docena,
    Caja_1 = n.Caja_1,
    Caja_5 = n.Caja_5,
    texto_copiar = n.texto_copiar;
--
	ALTER TABLE Clientes_finales_online ADD UNIQUE (Codigo);
--
	SET SQL_SAFE_UPDATES = 0;
    UPDATE Productos_franja SET Codigo = TRIM(Codigo);
    SET SQL_SAFE_UPDATES = 1;
--
Select * from Clientes_finales_online;
--