SELECT e.nombre, c.cargo AS cargo
FROM empleados e
JOIN cargos c ON e.id_cargo = c.id_cargo;

-- 2. Registrar un nuevo proveedor: Un procedimiento para agregar información de nuevos proveedores a la base de datos.
DELIMITER $$
create procedure agragar_nuevo_proveedor(
    nombre varchar(125),
    celular char(10),
    id_tipo_proveedor int
)
begin
 -- declaraciones SQL y logica de procediento 
	insert  into proveedores (nombre, celular, id_tipo_proveedor)
    values (nombre, celular, id_tipo_proveedor);
    
end $$
DELIMITER ;

call agragar_nuevo_proveedor('Paisas la 36', '3123404945', 2);

select * from proveedores;

-- 1. **Registrar una nueva categoría de productos**: Procedimiento que permite añadir una nueva categoría a la base de datos.
DELIMITER $$
drop procedure registrar_nueva_categoria;

create procedure registrar_nueva_categoria(
	nueva_categoria varchar(125)
)
begin
	insert into categorias(categoria)
    values(nueva_categoria);
end $$
DELIMITER ;

call registrar_nueva_categoria('Belleza');

select * from categorias;

-- 2. **Actualizar el precio de un producto específico**: Procedimiento que recibe el ID de un producto y un nuevo precio, y actualiza el precio en la base de datos.

DELIMITER $$
create procedure actualizar_precio(
    p_id_producto int,
    p_precio decimal(10,2)
)
begin
    update productos
    set precio = p_precio
    where id_producto = p_id_producto;
end $$
DELIMITER ;

call actualizar_precio(5,100000);

select * from productos; 

-- 3. **Eliminar un cliente**: Procedimiento que elimina un cliente de la base de datos en función de su ID.

drop procedure eliminar_cliente_por_telefono;

DELIMITER $$
create procedure eliminar_cliente_por_telefono(
    c_celular char(10)
)
begin
	 delete from ventas_promocion
    where id_venta in (
        select id_venta from ventas where id_cliente = (select id_cliente from clientes where celular = c_celular)
    );

	delete from ventas_productos
    where id_venta in (
        select id_venta from ventas where id_cliente = (select id_cliente from clientes where celular = c_celular)
    );

	delete from ventas
    where id_cliente = (select id_cliente from clientes where celular = c_celular);

    delete from clientes
    where celular = c_celular;
end $$
DELIMITER ;

 call eliminar_cliente_por_telefono('3000000001');
 
 select * from clientes;


-- 4. **Registrar un nuevo método de pago**: Procedimiento que permite agregar un nuevo método de pago, como "Tarjeta de Crédito" o "PayPal".
DELIMITER $$
create procedure registrar_metodo_pago(
    nuevo_metodo varchar(50)
)
begin
    insert into metodos (metodo) 
    values (nuevo_metodo);
end $$
DELIMITER ;

CALL registrar_metodo_pago('Nequi');

select * from metodos;

-- 5. **Actualizar la información de un proveedor**: Procedimiento que permite modificar los datos de contacto de un proveedor existente.
DELIMITER $$
CREATE PROCEDURE actualizar_proveedor(
    p_id_proveedor INT,
    p_nombre VARCHAR(125),
    p_celular CHAR(10)
)
BEGIN
    UPDATE proveedores
    SET nombre = p_nombre,
        celular = p_celular
    WHERE id_proveedor = p_id_proveedor;
END $$
DELIMITER ;
CALL actualizar_proveedor(1, 'Nuevo proveedor creado', '3063500002');

-- 6. **Registrar una nueva talla de producto**: Procedimiento que permite añadir una nueva talla disponible para los productos.
DELIMITER $$
CREATE PROCEDURE registrar_talla(
    p_talla VARCHAR(10)
)
BEGIN
    INSERT INTO tallas (talla)
    VALUES (p_talla);
END $$
DELIMITER ;
CALL registrar_talla('XXXL');
select * from tallas;


-- 7. **Actualizar el stock de un producto específico**: Procedimiento que ajusta manualmente la cantidad en inventario de un producto dado.

-- 8. **Asignar un rol a un empleado**: Procedimiento que actualiza el rol de un empleado en función de su ID.
DELIMITER $$
create procedure asignar_rol_empleado(
    p_id_empleado int,
    p_id_rol INT
)
begin
    update empleados
    set id_cargo = (
        select id_cargo from cargos where id_rol = p_id_rol
    )
    WHERE id_empleado = p_id_empleado;
end $$
DELIMITER ;

call asignar_rol_empleado(1, 5);

select * from empleados;

-- 9. **Eliminar un producto del inventario**: Procedimiento que permite eliminar un producto del inventario, especificado por su ID.
drop PROCEDURE eliminar_producto_inventario;

DELIMITER $$
create procedure eliminar_producto_inventario(
    p_id_producto int
)
begin
    -- Eliminar referencias en compras_productos
    delete from compras_productos
    where id_producto = p_id_producto;

    -- Eliminar referencias en ventas_productos
    delete from ventas_productos
    where id_producto = p_id_producto;

    -- Eliminar referencias en productos_tallas
    delete from productos_tallas
    where id_producto = p_id_producto;

    -- Eliminar referencias en promociones_productos
    delete from promociones_productos
    where id_producto = p_id_producto;

    -- Eliminar el producto de la tabla de inventario
    delete from inventario
    where id_producto = p_id_producto;

    -- Finalmente, eliminar el producto de la tabla de productos
    delete from productos
    where id_producto = p_id_producto;
end $$
DELIMITER ;

call eliminar_producto_inventario(1);

select * from productos;

-- 10. **Cambiar el estado de una promoción (activa/inactiva)**: Procedimiento que permite activar o desactivar promociones en función de su ID.

-- 11. **Registrar un nuevo cliente**: Procedimiento que añade un cliente con sus datos básicos (nombre, apellido, celular).
DELIMITER $$
create procedure registrar_nuevo_cliente(
    p_nombre VARCHAR(125),
    p_apellido VARCHAR(255),
    p_celular CHAR(10)
)
begin
    insert into clientes (nombre, apellido, celular)
    values (p_nombre, p_apellido, p_celular);
end $$
DELIMITER ;

call registrar_nuevo_cliente('Juan', 'Pérez', '3000000001');

-- -- 12. **Actualizar el sueldo de un empleado**: Procedimiento que recibe el ID de un empleado y un nuevo sueldo, y actualiza la información en la base de datos.
drop procedure actualizar_sueldo_cargo;

DELIMITER $$
create procedure actualizar_sueldo_cargo(
    p_id_cargo int,
    p_nuevo_sueldo decimal(10, 2)
)
begin
    update cargos
    set sueldo = p_nuevo_sueldo
    where id_cargo = p_id_cargo;
end $$
DELIMITER ;

call actualizar_sueldo_cargo(13, 80000000);

select * from cargos;

-- -- 13. **Actualizar el nombre de una categoría**: Procedimiento que cambia el nombre de una categoría existente.
drop procedure actualizar_nombre_categoria;

DELIMITER $$
create procedure actualizar_nombre_categoria(
	c_id_categoria int,
    c_categoria varchar(255)
)
begin
	update categorias
    set categoria = c_categoria
    where id_categoria = c_id_categoria;
end $$

DELIMITER ;

call actualizar_nombre_categoria(1, 'nueva categoria');

select * from categorias;

-- -- 14. **Añadir una descripción a un producto**: Procedimiento que permite actualizar o añadir una descripción detallada a un producto.
drop procedure crear_actualizar_descripcion_producto;

DELIMITER $$
create procedure crear_actualizar_descripcion_producto(
	p_id_producto int,
	p_descripcion varchar(255)
)
begin
	rollback;
    select 'Error, no elegiste un producto existente';
	
end $$
	start transaction;
    
    update productos
    set descripcion = p_descripcion
    where id_producto = p_id_producto;
    
    commit;
DELIMITER ;

call crear_actualizar_descripcion_producto(70,'Esta es la nueva descripcion del producto cuando la cambiamos');

select id_producto as id, nombre, descripcion from productos order by id asc;


-- -- 15. **Actualizar los datos de contacto de un cliente**: Procedimiento que permite modificar la información de contacto de un cliente.



-- -- 16. **Registrar una nueva clasificación de productos**: Procedimiento para agregar una nueva clasificación (por ejemplo, "Disfraces Infantiles").

-- 17. **Cambiar la contraseña de un usuario**: Procedimiento que permite actualizar la contraseña de un usuario específico.

-- 18. **Verificar la existencia de un producto en inventario**: Procedimiento que recibe un ID de producto y retorna si está disponible o no en el inventario.

-- 19. **Actualizar la fecha de inicio de un empleado**: Procedimiento que modifica la fecha de inicio de un contrato de un empleado específico.

-- 20. **Eliminar un método de pago**: Procedimiento para eliminar un método de pago que ya no se utilice.