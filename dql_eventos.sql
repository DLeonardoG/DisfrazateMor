use disfrazateMor;
-- 1. evento para controlar el stock minimo
delimiter $$ 
create event controlar_stock_minimo 
on schedule every 1 day 
do 
begin 
    declare stock_bajo int;
    select count(*) into stock_bajo 
    from inventario 
    where cantidad_total < 5;
    
    if stock_bajo > 0 then 
        signal sqlstate '45000' set message_text = '¡atención! algunos productos tienen stock bajo.'; 
    end if;
end$$
delimiter ;

-- 2. verificar periódicamente si alguna promoción ha caducado y, en caso afirmativo, desactivarla.
delimiter $$ 
create event controlar_promociones_caducadas 
on schedule every 1 day 
do 
begin 
    delete from promociones where fecha_fin < now(); 
end$$
delimiter ;

-- 3. evento para calcular el salario mensual de los empleados
delimiter $$ 
create event calcular_salarios_empleados 
on schedule every 1 month 
do 
begin 
    update empleados e 
    join cargos c on e.id_cargo = c.id_cargo 
    set e.sueldo = c.sueldo; 
end$$
delimiter ;

-- 4. evento para eliminar promociones expiradas
delimiter $$ 
create event eliminar_promociones_expiradas 
on schedule every 1 day 
do 
begin 
    delete from promociones where fecha_fin < now(); 
end$$
delimiter ;

-- 5. evento para monitorear el rendimiento de empleados
delimiter $$ 
create event monitorear_rendimiento_empleados 
on schedule every 1 month 
do 
begin 
    select e.nombre, e.apellido, count(v.id_venta) as total_ventas 
    from empleados e 
    join ventas v on e.id_empleado = v.id_empleado 
    group by e.id_empleado; 
end$$
delimiter ;

-- 6. evento para detectar productos sin ventas
delimiter $$ 
create event detectar_productos_sin_ventas 
on schedule every 1 month 
do 
begin 
    select p.nombre 
    from productos p 
    where p.id_producto not in (select id_producto from ventas_productos where fecha > date_sub(now(), interval 3 month)); 
end$$
delimiter ;

-- 7. evento para actualizar automáticamente las fechas de promociones
delimiter $$ 
create event extender_promocion 
on schedule every 1 day 
do 
begin 
    update promociones p 
    set p.fecha_fin = date_add(p.fecha_fin, interval 7 day) 
    where exists (select 1 from ventas_promocion vp where vp.id_promocion = p.id_promocion and vp.fecha > date_sub(now(), interval 1 day)); 
end$$
delimiter ;

-- 8. evento para recordar la recolección de productos comprados
delimiter $$ 
create event recordar_recoleccion 
on schedule every 1 day 
do 
begin 
    select c.nombre, c.apellido, c.celular 
    from clientes c 
    join ventas v on c.id_cliente = v.id_cliente 
    where v.fecha < date_sub(now(), interval 7 day) and v.total_venta > 0; 
end$$
delimiter ;

-- 9. evento para calcular ganancias mensuales
delimiter $$ 
create event calcular_ganancias 
on schedule every 1 month 
do 
begin 
    select sum(v.total_venta) - (select sum(c.total) from compras c where month(c.fecha) = month(now())) as ganancia_mensual 
    from ventas v where month(v.fecha) = month(now()); 
end$$
delimiter ;

-- 10. evento para ajustar el sueldo de empleados con base en su rendimiento si el empleado ha generado un alto volumen de ventas, incrementar su sueldo automáticamente.
delimiter $$ 
create event ajustar_sueldo 
on schedule every 1 month 
do 
begin 
    update empleados e 
    join (select id_empleado, count(*) as ventas_totales from ventas group by id_empleado) v 
    on e.id_empleado = v.id_empleado 
    set e.sueldo = e.sueldo + (v.ventas_totales * 100); 
end$$
delimiter ;

-- 11. eliminar clientes que no han hecho ninguna compra en el último año elimina clientes inactivos por más de un año.
delimiter $$ 
create event eliminar_clientes_inactivos 
on schedule every 1 year 
do 
begin 
    delete from clientes 
    where id_cliente not in (select id_cliente from ventas where fecha > date_sub(now(), interval 1 year));
end$$
delimiter ;

-- 12. eliminar productos sin inventario ni ventas en los últimos 6 meses limpia productos que no tienen stock y no han sido vendidos en los últimos 6 meses.
delimiter $$ 
create event eliminar_productos_sin_ventas 
on schedule every 1 month 
do 
begin 
    delete from productos 
    where id_producto not in (select id_producto from ventas_productos where fecha > date_sub(now(), interval 6 month)) 
    and id_producto in (select id_producto from productos_tallas where cantidad = 0);
end$$
delimiter ;

-- 13. enviar recordatorio de promoción que está por caducar
delimiter $$ 
create event alertar_promocion_por_caducar 
on schedule every 1 day 
do 
begin 
    select nombre, fecha_fin from promociones where fecha_fin = date_add(curdate(), interval 3 day); 
end$$
delimiter ;

-- 14. calcular y registrar las ventas diarias de cada empleado calcula las ventas diarias realizadas por cada empleado y las registra en una tabla
create table if not exists ventas_diarias_empleados (
    id_empleado int,
    fecha date,
    total_ventas decimal(10, 2)
);

delimiter $$ 
create event calcular_ventas_diarias 
on schedule every 1 day 
do 
begin 
    insert into ventas_diarias_empleados (id_empleado, fecha, total_ventas)
    select id_empleado, curdate(), sum(total_venta) 
    from ventas 
    where fecha = curdate() 
    group by id_empleado;
end$$
delimiter ;

-- 15. calcular el total de ventas mensuales por producto calcula y registra las ventas totales de cada producto cada mes.
create table if not exists ventas_mensuales_productos (
    id_producto int,
    mes int,
    total_ventas decimal(10, 2)
);
delimiter $$ 
create event recalcular_ventas_mensuales_productos 
on schedule every 1 month 
do 
begin 
    insert into ventas_mensuales_productos (id_producto, mes, total_ventas)
    select id_producto, month(curdate()), sum(vp.cantidad) 
    from ventas_productos vp 
    join ventas v on vp.id_venta = v.id_venta 
    where month(v.fecha) = month(curdate())
    group by vp.id_producto;
end$$
delimiter ;

-- 16. verificar si algún proveedor no ha entregado productos en 6 meses detecta proveedores inactivos y envía una alerta.
delimiter $$ 
create event detectar_proveedores_inactivos 
on schedule every 1 month 
do 
begin 
    select nombre from proveedores 
    where id_proveedor not in (select id_proveedor from compras where fecha > date_sub(now(), interval 6 month)); 
end$$
delimiter ;

-- 17. actualizar la lista de productos más vendidos cada mes registra los productos más vendidos cada mes en una tabla separada
create table if not exists productos_mas_vendidos (
    id_producto int,
    mes int,
    total_ventas int
);

delimiter $$ 
create event actualizar_productos_mas_vendidos 
on schedule every 1 month 
do 
begin 
    insert into productos_mas_vendidos (id_producto, mes, total_ventas)
    select vp.id_producto, month(curdate()), sum(vp.cantidad) 
    from ventas_productos vp 
    join ventas v on vp.id_venta = v.id_venta 
    where month(v.fecha) = month(curdate())
    group by vp.id_producto 
    order by sum(vp.cantidad) desc limit 10;
end$$
delimiter ;

-- 18. verificar clientes con más de 3 compras en un mes detecta los clientes más activos y registra sus compras.
create table if not exists clientes_activos (
    id_cliente int,
    mes int,
    total_compras int
);

delimiter $$ 
create event detectar_clientes_activos 
on schedule every 1 month 
do 
begin 
    insert into clientes_activos (id_cliente, mes, total_compras)
    select id_cliente, month(curdate()), count(*) 
    from ventas 
    where month(fecha) = month(curdate()) 
    group by id_cliente 
    having count(*) > 3;
end$$
delimiter ;

-- 19. verificar y aplicar un descuento adicional para productos con baja demanda aplica un descuento adicional para productos que no han vendido en los ultimos meses.
delimiter $$ 
create event aplicar_descuento_baja_demanda 
on schedule every 1 month 
do 
begin 
    update productos 
    set precio = precio * 0.90 
    where id_producto in (select id_producto from ventas_productos where cantidad < 10 and fecha > date_sub(now(), interval 3 month)); 
end$$
delimiter ;
