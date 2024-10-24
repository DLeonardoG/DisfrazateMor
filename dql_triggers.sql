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
select * from ventas

-- 2 