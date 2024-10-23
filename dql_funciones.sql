use disfrazateMor;
show function status where db = 'disfrazateMor';

-- 1. obtener el id del producto con el nombre
drop function if exists obtener_id_producto;
delimiter //
create function obtener_id_producto(nombre_ varchar(125))
returns int
deterministic
begin
    declare id_prod int;
    select id_producto into id_prod
    from productos
    where nombre = nombre_;
    return id_prod;
end //
delimiter ;
select obtener_id_producto('Sombrero de Vaquero');

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
select obtener_precio_producto(10);
