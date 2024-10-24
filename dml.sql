-- inserciones para empleados
insert into roles (rol, descripcion) values
('Gerente', 'Encargado de la supervisión general y la toma de decisiones estratégicas'),
('Asistente', 'Apoya en tareas administrativas y de oficina, manejo de agendas'),
('Vendedor', 'Responsable de las ventas y atención al cliente'),
('Cajero', 'Manejo de caja registradora y procesamiento de pagos'),
('Supervisor', 'Supervisión del personal y aseguramiento de cumplimiento de políticas'),
('Analista', 'Encargado del análisis de datos y generación de informes'),
('Diseñador', 'Creación de contenido visual y diseño de productos'),
('Desarrollador', 'Desarrollo y mantenimiento de aplicaciones y software'),
('Marketing', 'Gestión de campañas de marketing y publicidad'),
('Recursos Humanos', 'Administración de personal, contratación y desarrollo de empleados');

insert into cargos (cargo, sueldo, id_rol) values
('Gerente', 5000000, 1),
('Asistente', 2000000, 2),
('Vendedor', 1500000, 3),
('Cajero', 1400000, 4),
('Supervisor', 3000000, 5),
('Analista', 2500000, 6),
('Diseñador', 2700000, 7),
('Desarrollador', 3200000, 8),
('Marketing', 2800000, 9),
('Recursos Humanos', 2600000, 10);

insert into empleados (nombre, apellido, celular, fecha_inicio, id_cargo) values
('Juan', 'Pérez', '3100000001', '2023-01-01', 1),
('María', 'González', '3100000002', '2023-02-01', 2),
('Carlos', 'Rodríguez', '3100000003', '2023-03-01', 3),
('Ana', 'Martínez', '3100000004', '2023-04-01', 4),
('Luis', 'Hernández', '3100000005', '2023-05-01', 5),
('Lucía', 'López', '3100000006', '2023-06-01', 6),
('Miguel', 'Gómez', '3100000007', '2023-07-01', 7),
('Sofía', 'Díaz', '3100000008', '2023-08-01', 8),
('José', 'Castro', '3100000009', '2023-09-01', 9),
('Laura', 'Ramírez', '3100000010', '2023-10-01', 10),
('Francisco', 'Torres', '3100000011', '2023-11-01', 1),
('Marta', 'Flores', '3100000012', '2023-12-01', 2),
('Pedro', 'Ramos', '3100000013', '2024-01-01', 3),
('Elena', 'Ortega', '3100000014', '2024-02-01', 4),
('Diego', 'Vargas', '3100000015', '2024-03-01', 5),
('Carmen', 'Morales', '3100000016', '2024-04-01', 6),
('Andrés', 'Jiménez', '3100000017', '2024-05-01', 7),
('Valeria', 'Ruiz', '3100000018', '2024-06-01', 8),
('Ricardo', 'Navarro', '3100000019', '2024-07-01', 9),
('Natalia', 'Mendoza', '3100000020', '2024-08-01', 10),
('Fernando', 'García', '3100000021', '2024-09-01', 1),
('Daniela', 'Vega', '3100000022', '2024-10-01', 2),
('Santiago', 'Molina', '3100000023', '2024-11-01', 3),
('Paola', 'Suárez', '3100000024', '2024-12-01', 4),
('Javier', 'Ortiz', '3100000025', '2025-01-01', 5),
('Adriana', 'Cruz', '3100000026', '2025-02-01', 6),
('Roberto', 'Acosta', '3100000027', '2025-03-01', 7),
('Gabriela', 'Santos', '3100000028', '2025-04-01', 8),
('Alejandro', 'Méndez', '3100000029', '2025-05-01', 9),
('Verónica', 'Rivas', '3100000030', '2025-06-01', 10),
('Sebastián', 'Carrillo', '3100000031', '2025-07-01', 1),
('Isabel', 'Álvarez', '3100000032', '2025-08-01', 2),
('Camilo', 'Núñez', '3100000033', '2025-09-01', 3),
('Silvia', 'Mora', '3100000034', '2025-10-01', 4),
('Guillermo', 'Cortes', '3100000035', '2025-11-01', 5),
('Cristina', 'Fuentes', '3100000036', '2025-12-01', 6),
('Oscar', 'Peña', '3100000037', '2026-01-01', 7),
('Diana', 'Salinas', '3100000038', '2026-02-01', 8),
('Felipe', 'Rojas', '3100000039', '2026-03-01', 9),
('Claudia', 'Maldonado', '3100000040', '2026-04-01', 10),
('Eduardo', 'Blanco', '3100000041', '2026-05-01', 1),
('Lorena', 'Espinosa', '3100000042', '2026-06-01', 2),
('Hugo', 'Sosa', '3100000043', '2026-07-01', 3),
('Patricia', 'Arias', '3100000044', '2026-08-01', 4),
('Rodrigo', 'Campos', '3100000045', '2026-09-01', 5),
('Monica', 'Guerrero', '3100000046', '2026-10-01', 6),
('Álvaro', 'Reyes', '3100000047', '2026-11-01', 7),
('Beatriz', 'Herrera', '3100000048', '2026-12-01', 8),
('David', 'Guzmán', '3100000049', '2027-01-01', 9),
('Sandra', 'Ibarra', '3100000050', '2027-02-01', 10);

insert into usuarios (nombre_usuario, contrasena, id_empleado) values
('j.perez', 'password123', 1),
('m.gonzalez', 'password123', 2),
('c.rodriguez', 'password123', 3),
('a.martinez', 'password123', 4),
('l.hernandez', 'password123', 5),
('l.lopez', 'password123', 6),
('m.gomez', 'password123', 7),
('s.diaz', 'password123', 8),
('j.castro', 'password123', 9),
('l.ramirez', 'password123', 10);

-- metodos de pago
insert into metodos (metodo) values ('Efectivo'), ('Tarjeta de crédito'), ('Tarjeta de débito'), ('Transferencia bancaria');

-- proveedores

insert into tipos_proveedores (tipo_proveedor) values ('Mayorista'), ('Minorista'), ('Distribuidor'), ('Fabricante');

insert into proveedores (nombre, celular, id_tipo_proveedor) values 
('Distribuidora Global S.A.', '5557891234', 1),
('Importaciones y Exportaciones del Norte', '5554567890', 2),
('Fantasías y Disfraces Ltd.', '5551234567', 3),
('Accesorios Exclusivos', '5559876543', 2),
('Proveedora Rápida', '5556543210', 1),
('Disfraces para Todos', '5557418523', 3),
('Ropa Moderna S.A.', '5552583690', 1),
('Textiles y Más', '5553692587', 1),
('Calzados Martínez', '5551597538', 2),
('La Casa del Disfraz', '5557539516', 3),
('Diseños Originales S.A.', '5559517534', 4),
('Proveedora de Vestimenta', '5557896541', 1),
('Comercializadora del Sur', '5551237896', 2),
('Todo en Ropa', '5556547893', 1),
('Disfraces de Película', '5557893214', 3),
('Zapatos y Más S.A.', '5553216548', 2),
('Fábrica de Ropa Nacional', '5552581470', 4),
('Accesorios Fina Estampa', '5551472583', 2),
('Distribuciones de Ropa Ltd.', '5553691478', 1),
('Distribuidora Fashion Trends', '5558529634', 1),
('Proveedora Moda Global', '5559638527', 4),
('Ropa y Calzado Internacional', '5557418520', 2),
('Accesorios Únicos', '5559512587', 2),
('Fábrica de Textiles Modernos', '5553697412', 4),
('La Bodega del Disfraz', '5557891475', 3),
('Proveedor de Moda y Estilo', '5551479635', 2),
('Distribuidora Estilo S.A.', '5558527419', 1),
('Distribuciones Fantasía y Realidad', '5553698527', 3),
('Moda y Estilo Internacional', '5557419632', 2),
('Fábrica de Calzado Único', '5557892581', 4),
('Disfraces Únicos S.A.', '5554561237', 3),
('Zapatería del Norte', '5553217895', 2),
('Textiles del Mundo', '5557896542', 4),
('Proveedoras Unidas S.A.', '5559513579', 1),
('Distribuidora Élite', '5559631472', 1),
('Comercializadora Exclusiva', '5551594862', 2),
('Fantasías Nacionales', '5557531476', 3),
('Accesorios de Ensueño', '5554567891', 2),
('Distribuciones Internacionales', '5558529630', 1),
('Disfraces del Caribe', '5557891238', 3);

-- productos
insert into tallas(talla) values ('S'), ('M'), ('L'), ('XL'), ('XXL');

insert into categorias (categoria) values ('Ropa'), ('Disfraces'), ('Accesorios'), ('Calzado');

insert into tipos (tipo) values ('Disfraz'), ('Accesorio'), ('maquillaje'), ('Calzado');

insert into generos (genero) values ('Masculino'), ('Femenino'), ('Unisex');

insert into clasificaciones (clasificacion) values ('Primera Calidad'), ('Económico'), ('niños'), ('adultos');

insert into productos (nombre, descripcion, precio, id_clasificacion, id_tipo, id_genero, id_proveedor) values
('Disfraz de Superhéroe', 'Disfraz para niño con capa y máscara', 70000, 3, 1, 2, 1),
('Máscara de Halloween', 'Máscara aterradora para la noche de Halloween', 15000, 2, 2, 3, 3),
('Sombrero de Vaquero', 'Sombrero de fieltro para disfraces y fiestas', 20000, 1, 2, 1, 2),
('Pintura Facial', 'Pintura hipoalergénica para rostro y cuerpo', 12000, 4, 3, 3, 1),
('Vestido de Princesa', 'Vestido elegante con detalles de encaje', 85000, 1, 1, 2, 4),
('Capa de Vampiro', 'Capa larga y negra con forro rojo', 30000, 2, 1, 3, 2),
('Espada de Juguete', 'Espada plástica segura para niños', 18000, 3, 2, 1, 1),
('Zapatos de Payaso', 'Zapatos coloridos y grandes para disfraces', 25000, 4, 4, 3, 3),
('Peluca de Bruja', 'Peluca larga y negra para disfraces', 28000, 2, 2, 2, 4),
('Antifaz de Mascarada', 'Antifaz decorativo con plumas y brillantes', 22000, 1, 2, 2, 2),
('Capa de Superhéroe', 'Capa roja y azul con insignia de superhéroe', 18000, 2, 1, 3, 1),
('Guantes de Esqueleto', 'Guantes decorados con huesos para Halloween', 12000, 4, 2, 3, 2),
('Gorro de Santa Claus', 'Gorro rojo con borde blanco para Navidad', 10000, 1, 2, 3, 3),
('Peluca de Payaso', 'Peluca colorida y rizada para disfraces', 15000, 4, 2, 2, 1),
('Cinturón de Héroe', 'Cinturón temático para disfraces de héroes', 17000, 2, 2, 1, 4),
('Máscara de Supervillano', 'Máscara detallada de un supervillano famoso', 16000, 2, 2, 1, 2),
('Guantes de Dragón', 'Guantes decorados con escamas de dragón', 14000, 3, 2, 3, 3),
('Casco de Gladiador', 'Casco metálico para disfraces de gladiador', 35000, 1, 2, 1, 4),
('Sombrero de Bruja', 'Sombrero puntiagudo y negro para disfraces', 18000, 2, 2, 2, 1),
('Pintura de Guerra', 'Pintura facial para disfraces de guerrero', 13000, 3, 3, 3, 2),
('Capa de Mago', 'Capa larga y azul con estrellas doradas', 20000, 1, 1, 3, 3),
('Espada de Pirata', 'Espada plástica con detalles de pirata', 16000, 4, 2, 1, 1),
('Sombrero de Pirata', 'Sombrero con plumas y detalles dorados', 22000, 1, 2, 1, 2),
('Peluca de Sirena', 'Peluca larga y colorida para disfraces', 28000, 2, 2, 2, 3),
('Armadura de Caballero', 'Armadura ligera para disfraces de caballero', 45000, 3, 1, 1, 4),
('Máscara de Mono', 'Máscara divertida para fiestas y disfraces', 12000, 4, 2, 3, 1),
('Zapatos de Bailarina', 'Zapatos elegantes para disfraces de bailarina', 27000, 2, 4, 2, 2),
('Sombrero de Cowboy', 'Sombrero de vaquero clásico', 20000, 1, 2, 1, 4),
('Máscara de Dinosaurio', 'Máscara detallada de dinosaurio', 18000, 3, 2, 1, 3),
('Guantes de Héroe', 'Guantes con detalles de superhéroes', 14000, 2, 2, 3, 2),
('Pintura de Camuflaje', 'Pintura facial para disfraces militares', 12000, 4, 3, 3, 1),
('Peluca de Rockstar', 'Peluca rizada y colorida para disfraces', 15000, 2, 2, 2, 4),
('Casco de Astronauta', 'Casco detallado para disfraces espaciales', 35000, 1, 2, 3, 1),
('Capa de Murciélago', 'Capa negra con detalles de alas', 18000, 2, 1, 1, 2),
('Guantes de Boxeador', 'Guantes acolchados para disfraces de boxeador', 14000, 3, 2, 1, 4),
('Máscara de León', 'Máscara detallada de león', 25000, 2, 2, 3, 3),
('Zapatos de Elfo', 'Zapatos puntiagudos para disfraces navideños', 22000, 4, 4, 2, 1),
('Sombrero de Detective', 'Sombrero clásico para disfraces de detective', 20000, 1, 2, 1, 3),
('Pintura de Payaso', 'Pintura facial para disfraces de payaso', 13000, 4, 3, 3, 4),
('Capa de Mago Oscuro', 'Capa larga y negra para disfraces de mago', 20000, 2, 1, 1, 2),
('Espada de Ninja', 'Espada plástica con detalles de ninja', 16000, 3, 2, 1, 3),
('Peluca de Vampiro', 'Peluca negra y corta para disfraces', 28000, 2, 2, 3, 1),
('Armadura de Guerrero', 'Armadura ligera para disfraces de guerrero', 45000, 3, 1, 1, 2),
('Máscara de Mono', 'Máscara divertida para fiestas y disfraces', 12000, 4, 2, 3, 3),
('Zapatos de Princesa', 'Zapatos elegantes para disfraces de princesa', 27000, 2, 4, 2, 1),
('Sombrero de Chef', 'Sombrero blanco para disfraces de chef', 20000, 1, 2, 1, 4),
('Máscara de Lobo', 'Máscara detallada de lobo', 18000, 3, 2, 1, 3),
('Guantes de Explorador', 'Guantes con detalles de explorador', 14000, 2, 2, 3, 2),
('Pintura de Zombi', 'Pintura facial para disfraces de zombi', 12000, 4, 3, 3, 1),
('Peluca de Hada', 'Peluca rizada y colorida para disfraces', 15000, 2, 2, 2, 4);


insert into productos_tallas (id_producto, id_talla, cantidad) values 
(1, 1, 50), -- Disfraz de Pirata, talla S
(1, 2, 40), -- Disfraz de Pirata, talla M
(1, 3, 60), -- Disfraz de Pirata, talla L
(2, 2, 30), -- Cinturón, talla M
(2, 3, 70); -- Cinturón, talla L

insert into inventario (id_producto, cantidad_total) values 
(1, 150), 
(2, 100), 
(3, 200), 
(4, 75);

-- clientes
insert into clientes (nombre, apellido, celular) values
('Juan', 'Pérez', '3000000001'),
('María', 'González', '3000000002'),
('Carlos', 'Rodríguez', '3000000003'),
('Ana', 'Martínez', '3000000004'),
('Luis', 'Hernández', '3000000005'),
('Lucía', 'López', '3000000006'),
('Miguel', 'Gómez', '3000000007'),
('Sofía', 'Díaz', '3000000008'),
('José', 'Castro', '3000000009'),
('Laura', 'Ramírez', '3000000010'),
('Francisco', 'Torres', '3000000011'),
('Marta', 'Flores', '3000000012'),
('Pedro', 'Ramos', '3000000013'),
('Elena', 'Ortega', '3000000014'),
('Diego', 'Vargas', '3000000015'),
('Carmen', 'Morales', '3000000016'),
('Andrés', 'Jiménez', '3000000017'),
('Valeria', 'Ruiz', '3000000018'),
('Ricardo', 'Navarro', '3000000019'),
('Natalia', 'Mendoza', '3000000020'),
('Fernando', 'García', '3000000021'),
('Daniela', 'Vega', '3000000022'),
('Santiago', 'Molina', '3000000023'),
('Paola', 'Suárez', '3000000024'),
('Javier', 'Ortiz', '3000000025'),
('Adriana', 'Cruz', '3000000026'),
('Roberto', 'Acosta', '3000000027'),
('Gabriela', 'Santos', '3000000028'),
('Alejandro', 'Méndez', '3000000029'),
('Verónica', 'Rivas', '3000000030'),
('Sebastián', 'Carrillo', '3000000031'),
('Isabel', 'Álvarez', '3000000032'),
('Camilo', 'Núñez', '3000000033'),
('Silvia', 'Mora', '3000000034'),
('Guillermo', 'Cortes', '3000000035'),
('Cristina', 'Fuentes', '3000000036'),
('Oscar', 'Peña', '3000000037'),
('Diana', 'Salinas', '3000000038'),
('Felipe', 'Rojas', '3000000039'),
('Claudia', 'Maldonado', '3000000040'),
('Eduardo', 'Blanco', '3000000041'),
('Lorena', 'Espinosa', '3000000042'),
('Hugo', 'Sosa', '3000000043'),
('Patricia', 'Arias', '3000000044'),
('Rodrigo', 'Campos', '3000000045'),
('Monica', 'Guerrero', '3000000046'),
('Álvaro', 'Reyes', '3000000047'),
('Beatriz', 'Herrera', '3000000048'),
('David', 'Guzmán', '3000000049'),
('Sandra', 'Ibarra', '3000000050');


		-- compra (productos) -> ventas
insert into ventas (fecha, id_metodo, id_cliente, id_empleado) values 
('2023-10-20 13:30:00', 1, 1, 1),
('2023-10-22 15:45:00', 2, 2, 2),
('2023-11-01 11:20:00', 3, 3, 3);

insert into ventas_productos (id_producto, id_venta) values 
(1, 1),
(2, 2),
(3, 3),
(3, 1);

-- compras a proveedor

insert into compras (id_proveedor, fecha, total) values 
(1, '2023-10-01 10:30:00', 1200.50),
(2, '2023-10-05 14:00:00', 850.00),
(3, '2023-10-10 09:45:00', 2000.75);

insert into compras_productos (id_producto, id_compra) values 
(1, 1),
(2, 1),
(3, 2),
(4, 3);


-- promociones
-- Promociones
insert into promociones (nombre, descripcion, fecha_inicio, fecha_fin, descuento) values
('Promo Halloween', 'Descuento especial para disfraces', '2024-10-01', '2024-10-31', 20.00),
('Black Friday', 'Descuentos en todos los productos', '2024-11-29', '2024-11-29', 30.00),
('Navidad 2024', 'Descuentos para productos navideños', '2024-12-01', '2024-12-25', 25.00),
('Año Nuevo', 'Descuento de fin de año', '2024-12-26', '2024-12-31', 15.00),
('San Valentín', 'Descuentos en productos románticos', '2025-02-10', '2025-02-14', 20.00),
('Día de la Madre', 'Descuentos especiales para mamá', '2025-05-01', '2025-05-10', 18.00),
('Día del Padre', 'Descuentos en productos masculinos', '2025-06-01', '2025-06-20', 18.00),
('Verano 2025', 'Descuento en artículos de verano', '2025-06-01', '2025-06-30', 20.00),
('Regreso a Clases', 'Descuentos en útiles escolares', '2025-08-01', '2025-08-31', 22.00),
('Otoño 2025', 'Descuentos en artículos de otoño', '2025-09-01', '2025-09-30', 15.00),
('Cyber Monday', 'Descuentos en compras en línea', '2025-11-30', '2025-11-30', 25.00),
('Fiesta de Fin de Año', 'Descuentos en artículos de fiesta', '2025-12-15', '2025-12-31', 20.00),
('Vacaciones de Invierno', 'Descuentos en ropa de invierno', '2025-12-01', '2025-12-31', 20.00),
('Primavera 2026', 'Descuentos en artículos de primavera', '2026-03-01', '2026-03-31', 20.00),
('Día de la Mujer', 'Descuentos en productos femeninos', '2026-03-01', '2026-03-08', 15.00),
('Día del Niño', 'Descuentos en juguetes y ropa para niños', '2026-04-01', '2026-04-30', 20.00),
('Día del Trabajo', 'Descuentos en artículos de oficina', '2026-05-01', '2026-05-01', 10.00),
('Halloween 2026', 'Descuentos para disfraces de Halloween', '2026-10-01', '2026-10-31', 20.00),
('Black Friday 2026', 'Descuentos en todos los productos', '2026-11-27', '2026-11-27', 30.00),
('Navidad 2026', 'Descuentos para productos navideños', '2026-12-01', '2026-12-25', 25.00),
('Año Nuevo 2027', 'Descuento de fin de año', '2026-12-26', '2026-12-31', 15.00),
('San Valentín 2027', 'Descuentos en productos románticos', '2027-02-10', '2027-02-14', 20.00),
('Día de la Madre 2027', 'Descuentos especiales para mamá', '2027-05-01', '2027-05-10', 18.00),
('Día del Padre 2027', 'Descuentos en productos masculinos', '2027-06-01', '2027-06-20', 18.00),
('Verano 2027', 'Descuento en artículos de verano', '2027-06-01', '2027-06-30', 20.00),
('Regreso a Clases 2027', 'Descuentos en útiles escolares', '2027-08-01', '2027-08-31', 22.00),
('Otoño 2027', 'Descuentos en artículos de otoño', '2027-09-01', '2027-09-30', 15.00),
('Cyber Monday 2027', 'Descuentos en compras en línea', '2027-11-30', '2027-11-30', 25.00),
('Fiesta de Fin de Año 2027', 'Descuentos en artículos de fiesta', '2027-12-15', '2027-12-31', 20.00),
('Vacaciones de Invierno 2027', 'Descuentos en ropa de invierno', '2027-12-01', '2027-12-31', 20.00);


-- Promociones relacionadas con productos
insert into promociones_productos (id_promocion, id_producto) values
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10),
(6, 11),
(6, 12),
(7, 13),
(7, 14),
(8, 15),
(8, 16),
(9, 17),
(9, 18),
(10, 19),
(10, 20),
(11, 21),
(11, 22),
(12, 23),
(12, 24),
(13, 25),
(13, 26),
(14, 27),
(14, 28),
(15, 29),
(15, 30);

-- Promociones relacionadas con categorías
insert into promociones_categorias (id_promocion, id_categoria) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 1),
(6, 2),
(7, 3),
(8, 4),
(9, 1),
(10, 2),
(11, 3),
(12, 4),
(13, 1),
(14, 2),
(15, 3),
(16, 4),
(17, 1),
(18, 2),
(19, 3),
(20, 4),
(21, 1),
(22, 2),
(23, 3),
(24, 4),
(25, 1),
(26, 2),
(27, 3),
(28, 4),
(29, 1),
(30, 2);

-- Promociones relacionadas con clasificaciones
insert into promociones_clasificaciones (id_promocion, id_clasificacion) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 1),
(6, 2),
(7, 3),
(8, 4),
(9, 1),
(10, 2),
(11, 3),
(12, 4),
(13, 1),
(14, 2),
(15, 3),
(16, 4),
(17, 1),
(18, 2),
(19, 3),
(20, 4),
(21, 1),
(22, 2),
(23, 3),
(24, 4),
(25, 1),
(26, 2),
(27, 3),
(28, 4),
(29, 1),
(30, 2);

-- Promociones relacionadas con géneros
insert into promociones_generos (id_promocion, id_genero) values
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(5, 2),
(6, 3),
(7, 1),
(8, 2),
(9, 3),
(10, 1),
(11, 2),
(12, 3),
(13, 1),
(14, 2),
(15, 3),
(16, 1),
(17, 2),
(18, 3),
(19, 1),
(20, 2),
(21, 3),
(22, 1),
(23, 2),
(24, 3),
(25, 1),
(26, 2),
(27, 3),
(28, 1),
(29, 2),
(30, 3);

-- Promociones relacionadas con tipos
insert into promociones_tipos (id_promocion, id_tipo) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 1),
(6, 2),
(7, 3),
(8, 4),
(9, 1),
(10, 2),
(11, 3),
(12, 4),
(13, 1),
(14, 2),
(15, 3),
(16, 4),
(17, 1),
(18, 2),
(19, 3),
(20, 4),
(21, 1),
(22, 2),
(23, 3),
(24, 4),
(25, 1),
(26, 2),
(27, 3),
(28, 4),
(29, 1),
(30, 2);

insert into ventas_promocion (id_promocion, id_venta) values 
(1, 1),
(2, 2),
(3, 3);

insert into ventas_productos (id_producto, id_venta, cantidad)
values 
    (1, 1, 3),  -- vendemos 3 disfraces de vampiro
    (2, 1, 5);  -- vendemos 5 sombreros de mago

-- asignar tallas para el disfraz vendido
insert into ventas_productos_tallas (cantidad, id_talla, id_venta_producto)
values
    (3, 2, 1); 
    
INSERT INTO ventas (fecha, id_metodo, id_cliente, id_empleado, total_venta) 
VALUES (NOW(), 1, 1, 1, 200.00); -- Suponiendo que no hay suficiente stock


