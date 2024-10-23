use disfrazateMor;
show function status where db = 'disfrazateMor';

-- 1. obtener el precio del producto
drop function if exists obtener_precio_producto;
delimiter //
create function obtener_precio_producto(id_producto_ int)
returns decimal(10, 2)
deterministic
begin
    declare precio_producto decimal(10, 2);
    select precio into precio_producto
    from productos
    where id_producto = id_producto_;
    return precio_producto;
end //
delimiter ;
select obtener_precio_producto(45);

-- 2. obtener el precio del producto con el id
drop function if exists obtener_precio_producto;
delimiter //
create function obtener_precio_producto(id_producto_ int)
returns decimal(10, 2)
deterministic
begin
    declare precio_producto decimal(10, 2);
    select precio into precio_producto
    from productos
    where id_producto = id_producto_;
    return precio_producto;
end //
delimiter ;
select obtener_precio_producto(45);
