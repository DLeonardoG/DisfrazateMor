use disfrazateMor;
show function status where db = 'disfrazateMor';

-- 1 obtener el id del producto con el nombre
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

-- 2 obtener el precio del producto con el id
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

-- 3 tener el id y el precio del producto
drop function if exists obtener_id_y_precio_producto;
delimiter //
create function obtener_id_y_precio_producto(nombre_ varchar(125))
returns varchar(255)
deterministic
begin
    declare id_prod int;
    declare precio_prod decimal(10, 2);
    declare resultado varchar(255);
    -- aqui paso el producto y el precio y lo guardo en las variables
    select id_producto, precio into id_prod, precio_prod
    from productos
    where nombre = nombre_;
    -- paso los dos valores en una sola variable para poder sacarlo
    set resultado = concat('id: ', id_prod, ', precio: ', precio_prod);
    return resultado;
end //
delimiter ;
select obtener_id_y_precio_producto('Sombrero de Vaquero');

-- 4 obtener el nombre y la descripcion
drop function if exists obtener_la_descripcion;
delimiter //
create function obtener_la_descripcion(id_produ int)
returns varchar(255)
deterministic
begin
    declare nombre_ varchar(255);
    declare descripcion_ varchar(255);
    declare resultado varchar(255);
    select nombre, descripcion into nombre_, descripcion_
    from productos
    where id_producto = id_produ;
    set resultado = concat('producto: ', nombre_, ', descripcion: ', descripcion_);
    return resultado;
end //
delimiter ;
select obtener_la_descripcion(5);

-- 5 obtener el nombre y la descripcion
drop function if exists obtener_el_empleado;
delimiter //
create function obtener_el_empleado(cel char(10))
returns varchar(255)
deterministic
begin
    declare nombre_ varchar(255);
    declare apellido_ varchar(255);
    declare resultado varchar(255);
    select nombre, apellido into nombre_, apellido_
    from empleados
    where celular = cel;
    set resultado = concat('nombre: ', nombre_,' ', apellido_);
    return resultado;
end //
delimiter ;
select obtener_el_empleado('3100000001');

-- 5 obtener el nombre por el telefono
drop function if exists obtener_el_empleado;
delimiter //
create function obtener_el_empleado(cel char(10))
returns varchar(255)
deterministic
begin
    declare nombre_ varchar(255);
    declare apellido_ varchar(255);
    declare resultado varchar(255);
    select nombre, apellido into nombre_, apellido_
    from empleados
    where celular = cel;
    set resultado = concat('nombre: ', nombre_,' ', apellido_);
    return resultado;
end //
delimiter ;
select obtener_el_empleado('3100000001');

-- 6. calcular el descuento total de una venta realizada
drop function if exists calcular_descuento_venta;
delimiter //
create function calcular_descuento_venta(p_id_venta int)
returns varchar(255)
deterministic
begin
    declare total_descuento decimal(10, 2) default 0.00;
    select sum(p.descuento) into total_descuento
    from promociones p
    join ventas_promocion vp on vp.id_promocion = p.id_promocion
    where vp.id_venta = p_id_venta;
    return concat('descuento: ',total_descuento);
end //
delimiter ;
select calcular_descuento_venta(1);

-- 7. calcular el total de una venta y asignarle el total con la promocion
drop function if exists calcular_y_asignar_total_venta;
delimiter //
create function calcular_y_asignar_total_venta(p_id_venta int)
returns decimal(10, 2)
reads sql data
not deterministic
begin
    declare total_venta_ decimal(10, 2) default 0.00;
    declare total_descuento decimal(10, 2) default 0.00;
    declare precio_producto decimal(10, 2) default 0.00;
    select sum(p.precio) into total_venta_
    from productos p
    join ventas_productos vp on vp.id_producto = p.id_producto
    where vp.id_venta = p_id_venta;
    -- aqui se suman los descuentos que tiene ese elemento
    select sum(pr.descuento) into total_descuento
    from promociones pr
    join ventas_promocion vp on vp.id_promocion = pr.id_promocion
    where vp.id_venta = p_id_venta;
    -- calcular total final considerando descuentos
    set total_venta_ = total_venta_ - total_descuento;
    -- actualizo la tabla ventas
    update ventas
    set total_venta = total_venta_
    where id_venta = p_id_venta;
-- me saca el total de lo que le envie
    return total_venta_;
end //
delimiter ;
select calcular_y_asignar_total_venta(1);

-- 8. calcular el total de disfraces disponibles a la venta
drop function if exists calcular_total_disfraces;
delimiter //
create function calcular_total_disfraces()
returns varchar(255)
reads sql data
not deterministic
begin
    declare total_productos int default 0;
    select sum(cantidad) into total_productos
    from productos_tallas;
    return concat('disfraces a la venta: ',total_productos);
end //
delimiter ;
select calcular_total_disfraces();

-- 9 calcular los productos que hay que volver a recargar
drop function if exists calcular_stock_bajo;
delimiter //
create function calcular_stock_bajo(umbral int)
returns int
deterministic
begin
    declare cantidad_bajo int;
    -- se miran que productos hacen falta
    select count(*) into cantidad_bajo
    from inventario
    where cantidad_total < umbral;
    return cantidad_bajo;
end //
delimiter ;
select calcular_stock_bajo(10);

-- 10  calcular los nombres de los productos que hay que recargar
drop function if exists calcular_recargas;
delimiter //
create function calcular_recargas(num int)
returns varchar(1000)
deterministic
begin
    declare productos_bajos varchar(1000);
    set productos_bajos = '';
    select group_concat(p.nombre separator ', ') into productos_bajos
    from inventario i
    
    join productos p on i.id_producto = p.id_producto
    where i.cantidad_total < num;
    return productos_bajos;
end //

delimiter ;
select calcular_recargas(1000);

-- 11 calcular el costo operativo mensual por medio de los empleados
drop function if exists costo_mensual_empleados;
delimiter //
create function costo_mensual_empleados()
returns decimal(10,2)
deterministic
begin
    declare costo_total decimal(10,2);
    select sum(sueldo) into costo_total
    from cargos;
    return costo_total;
end //
delimiter ;
select costo_mensual_empleados();

-- 12 calcular total ventas por mes especifico
drop function if exists calcular_total_ventas_por_mes;
delimiter //
create function calcular_total_ventas_por_mes(mes int, anio int)
returns decimal(10,2)
deterministic
begin
    declare total_ventas decimal(10,2);
    select sum(vp.cantidad * p.precio) into total_ventas
    from ventas v
    join ventas_productos vp on v.id_venta = vp.id_venta
    join productos p on vp.id_producto = p.id_producto
    where month(v.fecha) = mes and year(v.fecha) = anio;
    if total_ventas is null then
        return 0.00;
    else
        return total_ventas;
    end if;
end //
delimiter ;
select calcular_total_ventas_por_mes(10, 2024);

-- 13 calcula todos los productos en el inventario
drop function if exists calcular_total_productos_inventario;
delimiter //
create function calcular_total_productos_inventario()
returns int
deterministic
begin
    declare total_productos int;
    select sum(cantidad_total) into total_productos
    from inventario;
    if total_productos is null then
        return 0;
    else
        return total_productos;
    end if;
end //
delimiter ;
select calcular_total_productos_inventario();

-- 14 calcular total descuentos aplicados por mes en especial
drop function if exists calcular_total_descuentos_por_mes;
delimiter //
create function calcular_total_descuentos_por_mes(mes int, anio int)
returns decimal(10,2)
deterministic
begin
    declare total_descuentos decimal(10,2);
    select sum(p.descuento) into total_descuentos
    from promociones p
    join ventas_promocion vp on p.id_promocion = vp.id_promocion
    join ventas v on vp.id_venta = v.id_venta
    where month(v.fecha) = mes and year(v.fecha) = anio;
    if total_descuentos is null then
        return 0.00;
    else
        return total_descuentos;
    end if;
end //
delimiter ;
select calcular_total_descuentos_por_mes(12, 2025);

-- 15 calcular stock de producto si se debe recargar o no
drop function if exists calcular_stock_producto;
delimiter //
create function calcular_stock_producto(id_prod int)
returns varchar(50)
deterministic
begin
    declare stock_total int;
    select sum(cantidad) into stock_total
    from productos_tallas
    where id_producto = id_prod;
    if stock_total is null or stock_total <= 5 then
        return 'reabastecer';
    else
        return 'suficiente';
    end if;
end //
delimiter ;
select calcular_stock_producto(4);

-- 16 calcular total ventas de un producto en un periodo especifico
drop function if exists calcular_total_ventas_producto;
delimiter //
create function calcular_total_ventas_producto(id_prod int, fecha_inicio datetime, fecha_fin datetime)
returns decimal(10,2)
deterministic
begin
    declare total_ventas decimal(10,2);
    select sum(vp.cantidad * p.precio) into total_ventas
    from ventas v
    join ventas_productos vp on v.id_venta = vp.id_venta
    join productos p on vp.id_producto = p.id_producto
    where vp.id_producto = id_prod and v.fecha between fecha_inicio and fecha_fin;
    if total_ventas is null then
        return 0.00;
    else
        return total_ventas;
    end if;
end //
delimiter ;
select calcular_total_ventas_producto(1, '2024-10-01', '2024-10-31');

-- 17 calcular cantidad total de productos vendidos durante un tiempo especifico
drop function if exists calcular_cantidad_productos_vendidos;
delimiter //
create function calcular_cantidad_productos_vendidos(fecha_inicio datetime, fecha_fin datetime)
returns int
deterministic
begin
    declare total_vendidos int;
    select sum(vp.cantidad) into total_vendidos
    from ventas v
    join ventas_productos vp on v.id_venta = vp.id_venta
    where v.fecha between fecha_inicio and fecha_fin;
    if total_vendidos is null then
        return 0;
    else
        return total_vendidos;
    end if;
end //
delimiter ;
select calcular_cantidad_productos_vendidos('2024-10-01', '2024-10-31');

-- 18 calcular total de productos vendidos por empleado en un mws determinado
drop function if exists productos_vendidos_empleado;
delimiter //
create function productos_vendidos_empleado(id_empleado int, mes int, anio int)
returns int
deterministic
begin
    declare total_vendidos int;
    select sum(vp.cantidad) into total_vendidos
    from ventas_productos vp
    join ventas v on vp.id_venta = v.id_venta
    where v.id_empleado = id_empleado and 
          month(v.fecha) = mes and 
          year(v.fecha) = anio;
    if total_vendidos is null then
        return 0;
    else
        return total_vendidos;
    end if;
end //
delimiter ;
select productos_vendidos_empleado(3, 10, 2024);

-- 19 calcular total de descuentos aplicados en un mes especifico
drop function if exists descuentos_mensual;
delimiter //
create function descuentos_mensual(mes int, anio int)
returns decimal(10,2)
deterministic
begin
    declare total_descuentos decimal(10,2);
    select sum(p.descuento) into total_descuentos
    from promociones p
    join ventas_promocion vp on p.id_promocion = vp.id_promocion
    join ventas v on vp.id_venta = v.id_venta
    where month(v.fecha) = mes and year(v.fecha) = anio;
    if total_descuentos is null then
        return 0.00;
    else
        return total_descuentos;
    end if;
end //
delimiter ;
select descuentos_mensual(10, 2024);

-- 20 contar total de clientes que estan registrados en disfrazatemor
drop function if exists contar_clientes;
delimiter //
create function contar_clientes()
returns int
deterministic
begin
    declare total_clientes int;
    select count(*) into total_clientes
    from clientes;
    return total_clientes;
end //
delimiter ;
select contar_clientes();