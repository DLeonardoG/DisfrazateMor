use disfrazateMor;
-- 1 se genera y descuenta lo respectivo a la venta de cada uno
drop trigger if exists vender_trigger;
delimiter //
create trigger vender_trigger
after insert on ventas_productos
for each row
begin
    declare stock_actual int;
    declare producto_disfraz boolean;
    -- se miran las tallas para ver
    select count(*) > 0 into producto_disfraz
    from productos_tallas
    where id_producto = new.id_producto;
    if producto_disfraz then
        -- si es un disfraz, actualizar la cantidad en productos_tallas
        select cantidad into stock_actual
        from productos_tallas
        where id_producto = new.id_producto
        and id_talla = (select id_talla from ventas_productos_tallas where id_venta_producto = new.id_venta_producto);
        if stock_actual >= new.cantidad then
            update productos_tallas
            set cantidad = cantidad - new.cantidad
            where id_producto = new.id_producto
            and id_talla = (select id_talla from ventas_productos_tallas where id_venta_producto = new.id_venta_producto);
        else
            signal sqlstate '45000' set message_text = 'no disponible para la talla dw su eleciion';
        end if;
    else
        -- si no es un disfraz, actualizar la cantidad en inventario
        select cantidad_total into stock_actual
        from inventario
        where id_producto = new.id_producto;
        if stock_actual >= new.cantidad then
            update inventario
            set cantidad_total = cantidad_total - new.cantidad
            where id_producto = new.id_producto;
        else
            signal sqlstate '45000' set message_text = 'stock insuficiente';
        end if;
    end if;
end;
//
delimiter ;
select * from ventas;

-- 2 se registran los cambios en ventas:D
drop trigger if exists actualizar_historial_salarios;
delimiter //
create trigger actualizar_historial_salarios
after update on cargos
for each row
begin
    insert into historial_salarios (id_cargo, sueldo_anterior, sueldo_nuevo, fecha_cambio) 
    values (old.id_cargo, old.sueldo, new.sueldo, now());
end //
delimiter ;

-- 3 verificar disponibilidad antes de confirmar venta
drop trigger if exists verificar_disponibilidad_disfraz;
delimiter //
create trigger verificar_disponibilidad_disfraz
before insert on ventas_productos
for each row
begin
    declare cantidad_disponible int;
    select sum(cantidad) into cantidad_disponible
    from productos_tallas
    where id_producto = new.id_producto;
    if cantidad_disponible < new.cantidad then
        signal sqlstate '45000' 
        set message_text = 'Error: Stock insuficiente para realizar la venta';
    end if;
end //
delimiter ;


-- 4 este trigger se activa antes de insertar un registro en la tabla ventas_productos y le asigna el total a las ventas.
drop trigger if exists actualizar_precio_venta;
delimiter //
create trigger actualizar_precio_venta
before insert on ventas_productos
for each row
begin
    declare precio_unitario decimal(10,2);
    declare total_actual decimal(10,2);
    select precio into precio_unitario
    from productos
    where id_producto = new.id_producto;
    set total_actual = precio_unitario * new.cantidad;
    update ventas
    set total_venta = coalesce(total_venta, 0) + total_actual
    where id_venta = new.id_venta;
end //
delimiter ;

-- 5 este trigger se encarga de registrar el historial y sus datos con fecha
drop trigger if exists registrar_cambio_sueldo;
delimiter //
create trigger registrar_cambio_sueldo
after update on empleados
for each row
begin
    if old.id_cargo != new.id_cargo then
        insert into historial_sueldos (id_empleado, fecha_cambio, sueldo_anterior, sueldo_nuevo)
        values (new.id_empleado, now(), old.id_cargo, new.id_cargo);
    end if;
end //
delimiter ;

-- 6 registrar la cantidad de productos devueltos a inventario cuando se elimina una venta
drop trigger if exists devolver_stock_venta;
delimiter //
create trigger devolver_stock_venta
after delete on ventas_productos
for each row
begin
    declare producto_disfraz boolean;
    select count(*) > 0 into producto_disfraz
    from productos_tallas
    where id_producto = old.id_producto;
    if producto_disfraz then
        -- si es un disfraz, devolver la cantidad a productos_tallas
        update productos_tallas
        set cantidad = cantidad + old.cantidad
        where id_producto = old.id_producto
        and id_talla = (select id_talla from ventas_productos_tallas where id_venta_producto = old.id_venta_producto);
    else
        -- si no es un disfraz devolver la cantidad a inventario
        update inventario
        set cantidad_total = cantidad_total + old.cantidad
        where id_producto = old.id_producto;
    end if;
end //
delimiter ;

-- 7 asegurar que el id del cliente exista antes de agregar una nueva venta
drop trigger if exists validar_cliente_existente;
delimiter //
create trigger validar_cliente_existente
before insert on ventas
for each row
begin
    if not exists (select 1 from clientes where id_cliente = new.id_cliente) then
        signal sqlstate '45000' set message_text = 'Error: El cliente no existe';
    end if;
end //
delimiter ;

-- 8 registrar cambios en los datos personales de un cliente en un historial
drop trigger if exists registrar_cambio_cliente;
delimiter //
create trigger registrar_cambio_cliente
after update on clientes
for each row
begin
    if old.nombre <> new.nombre or old.apellido <> new.apellido then
        insert into historial_clientes (id_cliente, nombre_anterior, apellido_anterior, fecha_cambio)
        values (new.id_cliente, old.nombre, old.apellido, now());
    end if;
end //
delimiter ;

-- 9 bloquear la eliminación de productos si existen ventas asociadas
drop trigger if exists bloquear_eliminacion_producto;
delimiter //
create trigger bloquear_eliminacion_producto
before delete on productos
for each row
begin
    if exists (select 1 from ventas_productos where id_producto = old.id_producto) then
        signal sqlstate '45000' set message_text = 'Error: No se puede eliminar un producto con ventas asociadas';
    end if;
end //
delimiter ;

-- 10 calcular el monto total de la venta después de insertar productos
drop trigger if exists calcular_monto_total_venta;
delimiter //
create trigger calcular_monto_total_venta
after insert on ventas_productos
for each row
begin
    update ventas
    set monto_total = (
        select sum(p.precio * vp.cantidad)
        from ventas_productos vp
        join productos p on p.id_producto = vp.id_producto
        where vp.id_venta = new.id_venta
    )
    where id_venta = new.id_venta;
end //
delimiter ;

-- 11 actualizar la cantidad en inventario si se modifica la cantidad en una venta existente
drop trigger if exists actualizar_stock_modificacion_venta;
delimiter //
create trigger actualizar_stock_modificacion_venta
after update on ventas_productos
for each row
begin
    declare diferencia int;
    declare producto_disfraz boolean;
    set diferencia = new.cantidad - old.cantidad;
    -- determinar si es un disfraz
    select count(*) > 0 into producto_disfraz
    from productos_tallas
    where id_producto = new.id_producto;
    if producto_disfraz then
        -- actualizar productos_tallas si es un disfraz
        update productos_tallas
        set cantidad = cantidad - diferencia
        where id_producto = new.id_producto
        and id_talla = (select id_talla from ventas_productos_tallas where id_venta_producto = new.id_venta_producto);
    else
        -- actualizar inventario si no es un disfraz
        update inventario
        set cantidad_total = cantidad_total - diferencia
        where id_producto = new.id_producto;
    end if;
end //
delimiter ;

-- 12 bloquear el registro de ventas con fecha futura
drop trigger if exists bloquear_ventas_futuras;
delimiter //
create trigger bloquear_ventas_futuras
before insert on ventas
for each row
begin
    if new.fecha > curdate() then
        signal sqlstate '45000' set message_text = 'Error: No se pueden registrar ventas en el futuro';
    end if;
end //
delimiter ;


-- 13 registrar la cantidad de descuentos aplicados en una venta
drop trigger if exists registrar_descuentos_venta;
delimiter //
create trigger registrar_descuentos_venta
after insert on ventas
for each row
begin
    if new.descuento > 0 then
        insert into historial_descuentos (id_venta, descuento, fecha_aplicacion)
        values (new.id_venta, new.descuento, now());
    end if;
end //
delimiter ;


-- 14 bloquear la eliminación de una promoción si está siendo utilizada en alguna venta
drop trigger if exists bloquear_eliminacion_promocion;
delimiter //
create trigger bloquear_eliminacion_promocion
before delete on promociones
for each row
begin
    if exists (select 1 from ventas where id_promocion = old.id_promocion) then
        signal sqlstate '45000' set message_text = 'Error: No se puede eliminar una promoción utilizada en ventas';
    end if;
end //
delimiter ;

-- 15 asignar un número de factura automáticamente al confirmar una venta
drop trigger if exists asignar_numero_factura;
delimiter //
create trigger asignar_numero_factura
after insert on ventas
for each row
begin
    update ventas
    set numero_factura = concat('FAC-', new.id_venta, '-', date_format(now(), '%Y%m%d'))
    where id_venta = new.id_venta;
end //
delimiter ;

-- 16 registrar el cambio de precio en productos en un historial de precios
drop trigger if exists registrar_cambio_precio_producto;
delimiter //
create trigger registrar_cambio_precio_producto
after update on productos
for each row
begin
    if old.precio <> new.precio then
        insert into historial_precios (id_producto, precio_anterior, precio_nuevo, fecha_cambio)
        values (new.id_producto, old.precio, new.precio, now());
    end if;
end //
delimiter ;

-- 17 evitar ventas con cantidades negativas
drop trigger if exists evitar_cantidades_negativas;
delimiter //
create trigger evitar_cantidades_negativas
before insert on ventas_productos
for each row
begin
    if new.cantidad < 0 then
        signal sqlstate '45000' set message_text = 'Error: No se pueden registrar ventas con cantidades negativas';
    end if;
end //
delimiter ;

-- 18 actualizar el saldo del cliente después de cada venta
drop trigger if exists actualizar_saldo_cliente;
delimiter //
create trigger actualizar_saldo_cliente
after insert on ventas
for each row
begin
    update clientes
    set saldo = saldo + new.total_venta
    where id_cliente = new.id_cliente;
end //
delimiter ;

use disfrazatemor;
describe ventas;

-- 19 bloquear la modificación de la fecha de una venta después de 24 horas
drop trigger if exists bloquear_modificacion_fecha_venta;
delimiter //
create trigger bloquear_modificacion_fecha_venta
before update on ventas
for each row
begin
    -- mirar si quieren editar la fecha
    if timestampdiff(hour, old.fecha, now()) > 24 then
        signal sqlstate '45000' 
        set message_text = 'Error: No se puede modificar la fecha de venta después de 24 horas';
    end if;
end //
delimiter ;

-- 20 registrar la devolucion de un producto en un historial de devoluciones
drop trigger if exists registrar_devolucion_producto;
delimiter //
create trigger registrar_devolucion_producto
after insert on devoluciones
for each row
begin
    insert into historial_devoluciones (id_producto, cantidad, fecha_devolucion)
    values (new.id_producto, new.cantidad, now());
end //
delimiter ;

