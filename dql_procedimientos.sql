SELECT e.nombre, c.cargo AS cargo
FROM empleados e
JOIN cargos c ON e.id_cargo = c.id_cargo;

-- 1. Registrar un nuevo proveedor: Un procedimiento para agregar información de nuevos proveedores a la base de datos.
drop procedure if exists agregar_nuevo_proveedor;

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

-- 2. **Registrar una nueva categoría de productos**: Procedimiento que permite añadir una nueva categoría a la base de datos.
drop procedure if exists registrar_nueva_categoria;

DELIMITER $$
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

-- 3. **Actualizar el precio de un producto específico**: Procedimiento que recibe el ID de un producto y un nuevo precio, y actualiza el precio en la base de datos.
drop procedure if exists actualizar_precio;

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

-- 4. **Eliminar un cliente**: Procedimiento que elimina un cliente de la base de datos en función de su ID.
drop procedure if exists eliminar_cliente_por_telefono;

delimiter $$
create procedure eliminar_cliente_por_telefono(
    p_celular char(10)
)
begin
    declare cliente_existente int;

    select count(*) into cliente_existente
    from clientes
    where celular = p_celular;

    if cliente_existente = 0 then
        select 'el cliente no existe' as mensaje;
    elseif cliente_existente >= 1 then
        delete from clientes
        where celular = p_celular;

        select 'cliente eliminado exitosamente' as mensaje;
    end if;
end $$
delimiter ;

call eliminar_cliente_por_telefono('300000010'); 

select * from clientes;

-- 5. **Registrar un nuevo método de pago**: Procedimiento que permite agregar un nuevo método de pago, como "Tarjeta de Crédito" o "PayPal".
drop procedure if exists registrar_metodo_pago;

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

-- 6. **Actualizar la información de un proveedor**: Procedimiento que permite modificar los datos de contacto de un proveedor existente.
drop procedure if exists actualizar_proveedor;

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

-- 7. **Registrar una nueva talla de producto**: Procedimiento que permite añadir una nueva talla disponible para los productos.
drop procedure if exists registrar_talla;

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

-- 8. **Asignar un rol a un empleado**: Procedimiento que actualiza el rol de un empleado en función de su ID.
drop procedure if exists asignar_rol_empleado;

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
drop procedure if exists eliminar_producto_inventario;

delimiter $$
create procedure eliminar_producto_inventario(
    p_id_producto int
)
begin
    declare producto_existente int;

    select count(*) into producto_existente
    from productos
    where id_producto = p_id_producto;

    if producto_existente = 0 then
        select 'el producto no existe' as mensaje;

    end if;

    delete from ventas_productos_tallas
    where id_venta_producto in (
        select id_venta_producto from ventas_productos where id_producto = p_id_producto
    );

    delete from ventas_productos
    where id_producto = p_id_producto;

    delete from compras_productos
    where id_producto = p_id_producto;


    delete from productos_tallas
    where id_producto = p_id_producto;

    delete from promociones_productos
    where id_producto = p_id_producto;

    delete from inventario
    where id_producto = p_id_producto;

    delete from productos
    where id_producto = p_id_producto;

    select 'producto eliminado exitosamente' as mensaje;
end $$
delimiter ;

call eliminar_producto_inventario(1); 

select * from productos;



-- 11. **Registrar un nuevo cliente**: Procedimiento que añade un cliente con sus datos básicos (nombre, apellido, celular).
drop procedure if exists registrar_nuevo_cliente;

delimiter $$
create procedure registrar_nuevo_cliente(
    p_nombre varchar(125),
    p_apellido varchar(255),
    p_celular char(10)
)
begin
    declare celular_existente int;

    select count(*) into celular_existente
    from clientes
    where celular = p_celular;

    if celular_existente > 0 then
        select 'el celular ya está registrado' as mensaje;
    else
        insert into clientes (nombre, apellido, celular)
        values (p_nombre, p_apellido, p_celular);

        select 'cliente registrado exitosamente' as mensaje;
    end if;
end $$
delimiter ;

call registrar_nuevo_cliente('Juanito', 'Pedraza', '3063501202');  

select * from clientes;


-- -- 12. **Actualizar el sueldo de un empleado**: Procedimiento que recibe el ID de un empleado y un nuevo sueldo, y actualiza la información en la base de datos.
drop procedure if exists actualizar_sueldo_cargo;

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
drop procedure if exists actualizar_nombre_categoria;

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
drop procedure if exists crear_actualizar_descripcion_producto;

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
drop procedure if exists actualizar_cliente;

DELIMITER $$
CREATE PROCEDURE actualizar_cliente(
    p_id_cliente INT,
    p_nombre VARCHAR(125),
    p_apellido VARCHAR(125),
    p_celular CHAR(10)
)
BEGIN
	declare celular_existente int;
    
    select count(*) into celular_existente
    from clientes
    where celular = p_celular;
    
	if celular_existente > 0 then
		select 'el telefono que ingresaste ya existe' as mensaje;
    end if;

	start transaction;
    
	UPDATE clientes
		SET nombre = p_nombre,
			apellido = p_apellido,
			celular = p_celular
		WHERE id_cliente = p_id_cliente;
	
    commit;
END $$

DELIMITER ;
CALL actualizar_cliente(1, 'Dora', 'la exploradora', '3000000231');

select nombre, apellido, celular from clientes;

-- -- 16. **Registrar una nueva clasificación de productos**: Procedimiento para agregar una nueva clasificación (por ejemplo, "Disfraces Infantiles").
drop procedure if exists registrar_clasificacion;

DELIMITER $$
create procedure registrar_clasificacion(
    p_clasificacion varchar(255)
)
begin
    if exists (select 1 from clasificaciones where clasificacion = p_clasificacion) then
        select 'La clasificación ya existe' as mensaje;
    ELSE
        insert into clasificaciones (clasificacion) values (p_clasificacion);
        select 'Clasificación registrada exitosamente' as mensaje;
    end if;
end $$
DELIMITER ;

call registrar_clasificacion('importado');

select * from clasificaciones;

-- 17. **Cambiar la contraseña de un usuario**: Procedimiento que permite actualizar la contraseña de un usuario específico.
drop procedure if exists cambiar_password_usuario;

DELIMITER $$
create procedure cambiar_password_usuario(
    p_nombre_usuario varchar(100),
    nueva_password varchar(50),
    p_id_rol int
)
begin
	declare usuario_existente int;
    
    SET SQL_SAFE_UPDATES = 0;
    
    select count(*) into usuario_existente
    from usuarios
    where nombre_usuario = p_nombre_usuario;

	if usuario_existente = 0 then
		select 'El usuario no existe o no pertenece a un empleado' as mensaje;
    else 
		if p_id_rol not in (select id_rol from roles where rol in ('Gerente', 'Recursos Humanos', 'Supervisor')) then
			select 'No tienes permiso para cambiar contraseñas' as mensaje;
		else
			update usuarios
			set contrasena = nueva_password
			where nombre_usuario = p_nombre_usuario;
			SET SQL_SAFE_UPDATES = 1;
			select 'Contraseña actualizada exitosamente' as mensaje;
		end if;
	end if;
    
end $$
DELIMITER ;

call cambiar_password_usuario('j.perezzz', '1111222', 2);

select * from usuarios;
select * from roles;

-- 18. **Verificar la existencia de un producto en inventario**: Procedimiento que recibe un ID de producto y retorna si está disponible o no en el inventario.
drop procedure if exists verificar_producto_en_inventario;

DELIMITER $$
create procedure verificar_producto_en_inventario(
    p_id_producto int
)
begin
    declare p_cantidad_total int;

    select cantidad_total into p_cantidad_total
    from inventario
    where id_producto = p_id_producto;

    if p_cantidad_total is null then
        select 'El producto no existe en el inventario' as mensaje;
    elseif p_cantidad_total > 0 THEN
        select 'El producto está disponible en el inventario' as mensaje;
    else
        select 'El producto no está disponible en el inventario' as mensaje;
    end if;
end $$
DELIMITER ;

call verificar_producto_en_inventario(3);

select * from inventario;

-- 19. **Actualizar la fecha de inicio de un empleado**: Procedimiento que modifica la fecha de inicio de un contrato de un empleado específico.
drop procedure if exists actualizar_fecha_inicio_empleado;

DELIMITER $$
create procedure actualizar_fecha_inicio_empleado(
    p_id_empleado int,
    p_nueva_fecha_inicio date
)
begin
    declare empleado_existente INT;

    select count(*) into empleado_existente
    from empleados
    where id_empleado = p_id_empleado;

    if empleado_existente = 0 then
        select 'El empleado no existe' as mensaje;
    else
        update empleados
        set fecha_inicio = p_nueva_fecha_inicio
        where id_empleado = p_id_empleado;

        select 'Fecha de inicio actualizada exitosamente' as mensaje;
    end if;
end $$
DELIMITER ;

call actualizar_fecha_inicio_empleado(1, '2024-10-01');
select * from empleados;

-- 20. **Eliminar un método de pago**: Procedimiento para eliminar un método de pago que ya no se utilice.
drop procedure if exists eliminar_metodo_pago;

delimiter $$
create procedure eliminar_metodo_pago(
    p_id_metodo int
)
begin
    declare metodo_existente int;

    select count(*) into metodo_existente
    from metodos
    where id_metodo = p_id_metodo;

    if metodo_existente = 0 then
        select 'el método de pago no existe' as mensaje;
    else
        -- eliminar el método de pago
        delete from metodos
        where id_metodo = p_id_metodo;

        select 'método de pago eliminado exitosamente' as mensaje;
    end if;
end $$
delimiter ;


call eliminar_metodo_pago(5);

select * from metodos;
