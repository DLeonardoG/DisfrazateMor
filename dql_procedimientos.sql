-- 1 registrar un nuevo proveedor
drop procedure if exists agregar_nuevo_proveedor;

DELIMITER $$
create procedure agragar_nuevo_proveedor(
    nombre varchar(125),
    celular char(10),
    id_tipo_proveedor int
)
begin
	insert  into proveedores (nombre, celular, id_tipo_proveedor)
    values (nombre, celular, id_tipo_proveedor);
end $$
DELIMITER ;
call agragar_nuevo_proveedor('paisas la 36', '3123404945', 2);
select * from proveedores;

-- 2.  añadir una nueva categoria
drop procedure if exists registrar_nueva_categoria;
delimiter $$
create procedure registrar_nueva_categoria(
	nueva_categoria varchar(125)
)
begin
	insert into categorias(categoria)
    values(nueva_categoria);
end $$
delimiter ;
call registrar_nueva_categoria('Belleza');
select * from categorias;

-- 3 actualizar el precio de un producto en la base de datos
drop procedure if exists actualizar_precio;
delimiter $$
create procedure actualizar_precio(
    p_id_producto int,
    p_precio decimal(10,2)
)
begin
    update productos
    set precio = p_precio
    where id_producto = p_id_producto;
end $$
delimiter ;
call actualizar_precio(5,100000);
select * from productos; 

-- 4. proceso para eliminar un cliente de la base de datos por su id
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

-- 5. proceso para registrar un nuevo método de pago
drop procedure if exists registrar_metodo_pago;
delimiter $$
create procedure registrar_metodo_pago(nuevo_metodo varchar(50)) 
begin 
    insert into metodos (metodo) values (nuevo_metodo); 
end $$
delimiter ;
call registrar_metodo_pago('Nequi'); 
select * from metodos;

-- 6. proceso para actualizar la información de un proveedor
drop procedure if exists actualizar_proveedor;
delimiter $$
create procedure actualizar_proveedor(p_id_proveedor INT, p_nombre VARCHAR(125), p_celular CHAR(10)) 
begin 
    update proveedores set nombre = p_nombre, celular = p_celular where id_proveedor = p_id_proveedor; 
end $$
delimiter ;
call actualizar_proveedor(1, 'Nuevo proveedor creado', '3063500002');

-- 7. proceso para registrar una nueva talla de producto
drop procedure if exists registrar_talla;
delimiter $$
create procedure registrar_talla(p_talla VARCHAR(10)) 
begin 
    insert into tallas (talla) values (p_talla); 
end $$
delimiter ;
call registrar_talla('XXXL'); 
select * from tallas;

-- 8. proceso para asignar un rol a un empleado
drop procedure if exists asignar_rol_empleado;
delimiter $$
create procedure asignar_rol_empleado(p_id_empleado int, p_id_rol INT) 
begin 
    update empleados set id_cargo = (select id_cargo from cargos where id_rol = p_id_rol) where id_empleado = p_id_empleado; 
end $$
delimiter ;
call asignar_rol_empleado(1, 5); 
select * from empleados;

-- 9. proceso para eliminar un producto del inventario
drop procedure if exists eliminar_producto_inventario;
delimiter $$
create procedure eliminar_producto_inventario(p_id_producto int) 
begin 
    declare producto_existente int; 
    select count(*) into producto_existente from productos where id_producto = p_id_producto; 
    if producto_existente = 0 then 
        select 'el producto no existe' as mensaje; 
    end if; 
    delete from ventas_productos_tallas where id_venta_producto in (select id_venta_producto from ventas_productos where id_producto = p_id_producto); 
    delete from ventas_productos where id_producto = p_id_producto; 
    delete from compras_productos where id_producto = p_id_producto; 
    delete from productos_tallas where id_producto = p_id_producto; 
    delete from promociones_productos where id_producto = p_id_producto; 
    delete from inventario where id_producto = p_id_producto; 
    delete from productos where id_producto = p_id_producto; 
    select 'producto eliminado exitosamente' as mensaje; 
end $$
delimiter ;
call eliminar_producto_inventario(1); 
select * from productos;

-- 11. proceso para registrar un nuevo cliente
drop procedure if exists registrar_nuevo_cliente;
delimiter $$
create procedure registrar_nuevo_cliente(p_nombre varchar(125), p_apellido varchar(255), p_celular char(10)) 
begin 
    declare celular_existente int; 
    select count(*) into celular_existente from clientes where celular = p_celular; 
    if celular_existente > 0 then 
        select 'el celular ya está registrado' as mensaje; 
    else 
        insert into clientes (nombre, apellido, celular) values (p_nombre, p_apellido, p_celular); 
        select 'cliente registrado exitosamente' as mensaje; 
    end if; 
end $$
delimiter ;
call registrar_nuevo_cliente('Juanito', 'Pedraza', '3063501202'); 
select * from clientes;

-- 12. proceso para actualizar el sueldo de un empleado
drop procedure if exists actualizar_sueldo_cargo;
delimiter $$
create procedure actualizar_sueldo_cargo(p_id_cargo int, p_nuevo_sueldo decimal(10, 2)) 
begin 
    update cargos set sueldo = p_nuevo_sueldo where id_cargo = p_id_cargo; 
end $$
delimiter ;
call actualizar_sueldo_cargo(13, 80000000); 
select * from cargos;

-- 13. proceso para actualizar el nombre de una categoría
drop procedure if exists actualizar_nombre_categoria;
delimiter $$
create procedure actualizar_nombre_categoria(c_id_categoria int, c_categoria varchar(255)) 
begin 
    update categorias set categoria = c_categoria where id_categoria = c_id_categoria; 
end $$
delimiter ;
call actualizar_nombre_categoria(1, 'nueva categoria'); 
select * from categorias;

-- 14. proceso para añadir una descripción a un producto
drop procedure if exists crear_actualizar_descripcion_producto;
delimiter $$
create procedure crear_actualizar_descripcion_producto(p_id_producto int, p_descripcion varchar(255)) 
begin 
    rollback; 
    select 'Error, no elegiste un producto existente'; 
end $$
start transaction; 
update productos set descripcion = p_descripcion where id_producto = p_id_producto; 
commit; 
delimiter ;
call crear_actualizar_descripcion_producto(70,'Esta es la nueva descripcion del producto cuando la cambiamos'); 
select id_producto as id, nombre, descripcion from productos order by id asc;

-- 15. proceso para actualizar los datos de contacto de un cliente
drop procedure if exists actualizar_cliente;
delimiter $$
create procedure actualizar_cliente(p_id_cliente INT, p_nombre VARCHAR(125), p_apellido VARCHAR(125), p_celular CHAR(10)) 
begin 
    declare celular_existente int; 
    select count(*) into celular_existente from clientes where celular = p_celular; 
    if celular_existente > 0 then 
        select 'el telefono que ingresaste ya existe' as mensaje; 
    end if; 
    start transaction; 
    update clientes set nombre = p_nombre, apellido = p_apellido, celular = p_celular where id_cliente = p_id_cliente; 
    commit; 
end $$ 
delimiter ;
call actualizar_cliente(1, 'Dora', 'la exploradora', '3000000231'); 
select nombre, apellido, celular from clientes;

-- 16. proceso para registrar una nueva clasificación de productos
drop procedure if exists registrar_clasificacion;
delimiter $$
create procedure registrar_clasificacion(p_clasificacion varchar(255)) 
begin 
    if exists (select 1 from clasificaciones where clasificacion = p_clasificacion) then 
        select 'La clasificación ya existe' as mensaje; 
    else 
        insert into clasificaciones (clasificacion) values (p_clasificacion); 
        select 'Clasificación registrada exitosamente' as mensaje; 
    end if; 
end $$
delimiter ;
call registrar_clasificacion('importado'); 
select * from clasificaciones;

-- 17. proceso para cambiar la contraseña de un usuario
drop procedure if exists cambiar_password_usuario;
delimiter $$
create procedure cambiar_password_usuario(p_nombre_usuario varchar(100), nueva_password varchar(50), p_id_rol int) 
begin 
    declare usuario_existente int; 
    SET SQL_SAFE_UPDATES = 0; 
    select count(*) into usuario_existente from usuarios where nombre_usuario = p_nombre_usuario; 
    if usuario_existente = 0 then 
        select 'El usuario no existe o no pertenece a un empleado' as mensaje; 
    else 
        if p_id_rol not in (select id_rol from roles where rol in ('Gerente', 'Recursos Humanos', 'Supervisor')) then 
            select 'No tienes permiso para cambiar contraseñas' as mensaje; 
        else 
            update usuarios set contrasena = nueva_password where nombre_usuario = p_nombre_usuario; 
            SET SQL_SAFE_UPDATES = 1; 
            select 'Contraseña actualizada exitosamente' as mensaje; 
        end if; 
    end if; 
end $$ 
delimiter ;
call cambiar_password_usuario('j.perezzz', '1111222', 2); 
select * from usuarios; 
select * from roles;

-- 18. proceso para verificar la existencia de un producto en inventario
drop procedure if exists verificar_producto_en_inventario;
delimiter $$
create procedure verificar_producto_en_inventario(p_id_producto int) 
begin 
    declare p_cantidad_total int; 
    select cantidad_total into p_cantidad_total from inventario where id_producto = p_id_producto; 
    if p_cantidad_total is null then 
        select 'El producto no existe en el inventario' as mensaje; 
    elseif p_cantidad_total > 0 then 
        select 'El producto está disponible en el inventario' as mensaje; 
    else 
        select 'El producto no está disponible en el inventario' as mensaje; 
    end if; 
end $$ 
delimiter ;
call verificar_producto_en_inventario(3); 
select * from inventario;

-- 19. proceso para actualizar la fecha de inicio de un empleado
drop procedure if exists actualizar_fecha_inicio_empleado;
delimiter $$
create procedure actualizar_fecha_inicio_empleado(p_id_empleado int, p_nueva_fecha_inicio date) 
begin 
    declare empleado_existente INT; 
    select count(*) into empleado_existente from empleados where id_empleado = p_id_empleado; 
    if empleado_existente = 0 then 
        select 'El empleado no existe' as mensaje; 
    else 
        update empleados set fecha_inicio = p_nueva_fecha_inicio where id_empleado = p_id_empleado; 
        select 'Fecha de inicio actualizada exitosamente' as mensaje; 
    end if; 
end $$ 
delimiter ;
call actualizar_fecha_inicio_empleado(1, '2024-10-01'); 
select * from empleados;

-- 20. proceso para eliminar un método de pago
drop procedure if exists eliminar_metodo_pago;
delimiter $$
create procedure eliminar_metodo_pago(p_id_metodo int) 
begin 
    declare metodo_existente int; 
    select count(*) into metodo_existente from metodos where id_metodo = p_id_metodo; 
    if metodo_existente = 0 then 
        select 'el método de pago no existe' as mensaje; 
    else 
        delete from metodos where id_metodo = p_id_metodo; 
        select 'método de pago eliminado exitosamente' as mensaje; 
    end if; 
end $$
delimiter ;
call eliminar_metodo_pago(5); 
select * from metodos;
