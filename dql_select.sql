use disfrazateMor;

select count(*) as total_tablas from information_schema.tables where table_schema = 'disfrazateMor';

-- 1. listar de todos los productos con su precio y descripción.
select nombre, precio, descripcion from productos;

-- 2. cantidad total de productos en el inventario.
select sum(cantidad_total) as total_inventario from inventario;

-- 3. total de ventas realizadas en un día específico.
select count(*) as total_ventas 
from ventas 
where date(fecha) = '2024-10-22';

-- 4. clientes con compras realizadas en el último mes.
select nombre, apellido, celular 
from clientes 
where id_cliente in (
    select id_cliente 
    from ventas 
    where month(fecha) = month(now()) - 1
);

-- 5. lista de todos los proveedores registrados.
select nombre, celular 
from proveedores;

-- 6. detalle de empleados con su cargo y sueldo.
select empleados.nombre, empleados.apellido, cargos.cargo, cargos.sueldo 
from empleados 
join cargos on empleados.id_cargo = cargos.id_cargo;

-- 7. total de productos vendidos en una venta específica.
select count(*) as total_productos_vendidos 
from ventas_productos 
where id_venta = 1;

-- 8. promociones activas en una fecha específica.
select nombre, descripcion 
from promociones 
where date(fecha_inicio) <= '2024-10-22' and date(fecha_fin) >= '2024-10-22';

-- 9. categorías disponibles de productos.
select categoria from categorias;

-- 10. total de ventas por cada método de pago.
select metodos.metodo, count(*) as total_ventas 
from ventas 
join metodos on ventas.id_metodo = metodos.id_metodo 
group by metodos.metodo;

-- 11. ventas realizadas en un rango de fechas.
select * 
from ventas 
where fecha between '2024-01-01' and '2024-10-22';

-- 12. lista de empleados que han realizado ventas.
select distinct empleados.nombre, empleados.apellido 
from empleados 
join ventas on empleados.id_empleado = ventas.id_empleado;

-- 13. productos que están agotados en el inventario.
select productos.nombre 
from productos 
join inventario on productos.id_producto = inventario.id_producto 
where inventario.cantidad_total = 0;

-- 14. clientes que han comprado más de una vez.
select nombre, apellido, celular 
from clientes 
where id_cliente in (
    select id_cliente 
    from ventas 
    group by id_cliente 
    having count(*) > 1
);

-- 15. total de descuentos aplicados en promociones.
select sum(descuento) as total_descuentos 
from promociones;

-- 16. proveedores con más de un tipo de producto.
select proveedores.nombre, count(distinct productos.id_tipo) as total_tipos 
from proveedores 
join productos on proveedores.id_proveedor = productos.id_proveedor 
group by proveedores.nombre 
having total_tipos > 1;

-- 17. total de compras a proveedores en el último año.
select count(*) as total_compras 
from compras 
where year(fecha) = year(now());

-- 18. lista de categorías con promociones activas.
select distinct categorias.categoria 
from categorias 
join promociones_categorias on categorias.id_categoria = promociones_categorias.id_categoria 
join promociones on promociones_categorias.id_promocion = promociones.id_promocion 
where date(promociones.fecha_inicio) <= now() and date(promociones.fecha_fin) >= now();

-- 19. productos con inventario bajo (menos de 5 unidades).
select productos.nombre, inventario.cantidad_total 
from productos 
join inventario on productos.id_producto = inventario.id_producto 
where inventario.cantidad_total < 5;

-- 20. lista de empleados y su antigüedad en la empresa.
select nombre, apellido, datediff(now(), fecha_inicio) as dias_trabajando 
from empleados;

-- 21. total de ventas por cada empleado.
select empleados.nombre, empleados.apellido, count(ventas.id_venta) as total_ventas 
from empleados 
join ventas on empleados.id_empleado = ventas.id_empleado 
group by empleados.id_empleado;

-- 22. ventas agrupadas por género del producto.
select generos.genero, count(ventas_productos.id_producto) as total_ventas 
from generos 
join productos on generos.id_genero = productos.id_genero 
join ventas_productos on productos.id_producto = ventas_productos.id_producto 
group by generos.genero;

-- 23. productos más vendidos.
select productos.nombre, count(ventas_productos.id_producto) as total_vendidos 
from productos 
join ventas_productos on productos.id_producto = ventas_productos.id_producto 
group by productos.nombre 
order by total_vendidos desc 
limit 10;

-- 24. promociones aplicadas en ventas.
select ventas.id_venta, promociones.nombre, promociones.descuento 
from ventas_promocion 
join promociones on ventas_promocion.id_promocion = promociones.id_promocion 
join ventas on ventas_promocion.id_venta = ventas.id_venta;

-- 25. total de ingresos diarios en la tienda.
select date(fecha) as dia, sum(productos.precio) as ingresos_diarios 
from ventas 
join ventas_productos on ventas.id_venta = ventas_productos.id_venta 
join productos on ventas_productos.id_producto = productos.id_producto 
group by dia;

-- 26. detalle de inventario por producto y talla.
select productos.nombre, tallas.talla, productos_tallas.cantidad 
from productos 
join productos_tallas on productos.id_producto = productos_tallas.id_producto 
join tallas on productos_tallas.id_talla = tallas.id_talla;

-- 27. clientes que compraron durante una promoción específica.
select clientes.nombre, clientes.apellido 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
join ventas_promocion on ventas.id_venta = ventas_promocion.id_venta 
where ventas_promocion.id_promocion = 1;

-- 28. comparación de ventas mensuales del año actual.
select month(fecha) as mes, count(*) as total_ventas 
from ventas 
where year(fecha) = year(now()) 
group by mes;

-- 29. lista de proveedores que suministraron productos en el último semestre.
select distinct proveedores.nombre 
from proveedores 
join productos on proveedores.id_proveedor = productos.id_proveedor 
join compras_productos on productos.id_producto = compras_productos.id_producto 
join compras on compras_productos.id_compra = compras.id_compra 
where compras.fecha between date_sub(now(), interval 6 month) and now();

-- 30. productos más comprados por cliente.
select clientes.nombre, clientes.apellido, productos.nombre, count(ventas_productos.id_producto) as total_comprado 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
join ventas_productos on ventas.id_venta = ventas_productos.id_venta 
join productos on ventas_productos.id_producto = productos.id_producto 
group by clientes.id_cliente, productos.id_producto 
order by total_comprado desc;

-- 31. total de ventas por categoría.
select categorias.categoria, count(ventas_productos.id_producto) as total_ventas 
from categorias 
join categorias_productos on categorias.id_categoria = categorias_productos.id_categoria 
join ventas_productos on categorias_productos.id_producto = ventas_productos.id_producto 
group by categorias.categoria;

-- 32. empleados que realizaron ventas en promociones.
select distinct empleados.nombre, empleados.apellido 
from empleados 
join ventas on empleados.id_empleado = ventas.id_empleado 
join ventas_promocion on ventas.id_venta = ventas_promocion.id_venta;

-- 33. productos vendidos agrupados por talla.
select productos.nombre, tallas.talla, sum(productos_tallas.cantidad) as total_vendidos 
from productos 
join productos_tallas on productos.id_producto = productos_tallas.id_producto 
join tallas on productos_tallas.id_talla = tallas.id_talla 
group by productos.nombre, tallas.talla;

-- 34. proveedores con más productos suministrados.
select proveedores.nombre, count(productos.id_producto) as total_productos 
from proveedores 
join productos on proveedores.id_proveedor = productos.id_proveedor 
group by proveedores.nombre 
order by total_productos desc;

-- 35. ventas realizadas por cliente en el último trimestre.
select clientes.nombre, clientes.apellido, count(ventas.id_venta) as total_ventas 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
where ventas.fecha between date_sub(now(), interval 3 month) and now() 
group by clientes.id_cliente;

-- 36. total de compras y ventas por empleado.
select empleados.nombre, empleados.apellido, 
    (select count(*) from compras where compras.id_proveedor = empleados.id_empleado) as total_compras, 
    (select count(*) from ventas where ventas.id_empleado = empleados.id_empleado) as total_ventas 
from empleados;

-- 37. clientes con el mayor número de compras en promociones.
select clientes.nombre, clientes.apellido, count(ventas_promocion.id_promocion) as total_promociones 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
join ventas_promocion on ventas.id_venta = ventas_promocion.id_venta 
group by clientes.id_cliente 
order by total_promociones desc;

-- 38. desglose de ventas por método de pago en el último mes.
select metodos.metodo, count(*) as total_ventas 
from ventas 
join metodos on ventas.id_metodo = metodos.id_metodo 
where month(fecha) = month(now()) - 1 
group by metodos.metodo;

-- 39. categorías más vendidas durante promociones.
select categorias.categoria, count(ventas_promocion.id_promocion) as total_vendidas 
from categorias 
join categorias_productos on categorias.id_categoria = categorias_productos.id_categoria 
join ventas_productos on categorias_productos.id_producto = ventas_productos.id_producto 
join ventas_promocion on ventas_productos.id_venta = ventas_promocion.id_venta 
group by categorias.categoria 
order by total_vendidas desc;

-- 40. clientes que compraron durante las últimas promociones activas.
select distinct clientes.nombre, clientes.apellido 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
join ventas_promocion on ventas.id_venta = ventas_promocion.id_venta 
where ventas_promocion.id_promocion in (
    select id_promocion from promociones 
    where date(fecha_fin) >= now()
);

-- 41. desglose de ventas por día de la semana.
select dayname(fecha) as dia, count(*) as total_ventas 
from ventas 
group by dia 
order by field(dia, 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday');

-- 42. ventas realizadas por cliente en un año específico.
select clientes.nombre, clientes.apellido, count(ventas.id_venta) as total_ventas 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
where year(ventas.fecha) = 2023 
group by clientes.id_cliente;

-- 43. ventas por categoría de producto.
select categorias.categoria, sum(productos.precio) as total_ventas 
from categorias 
join categorias_productos on categorias.id_categoria = categorias_productos.id_categoria 
join ventas_productos on categorias_productos.id_producto = ventas_productos.id_producto 
join productos on ventas_productos.id_producto = productos.id_producto 
group by categorias.categoria;

-- 44. empleados con ventas en el último mes.
select empleados.nombre, empleados.apellido, count(ventas.id_venta) as total_ventas 
from empleados 
join ventas on empleados.id_empleado = ventas.id_empleado 
where month(ventas.fecha) = month(now()) - 1 
group by empleados.id_empleado;

-- 45. productos nunca vendidos.
select productos.nombre 
from productos 
where id_producto not in (
    select distinct id_producto 
    from ventas_productos
);

-- 46. clientes que compraron en promoción en el último mes.
select distinct clientes.nombre, clientes.apellido 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
join ventas_promocion on ventas.id_venta = ventas_promocion.id_venta 
where month(ventas.fecha) = month(now()) - 1;

-- 47. proveedores que no suministraron en el último año.
select proveedores.nombre 
from proveedores 
where id_proveedor not in (
    select distinct id_proveedor 
    from compras 
    where year(fecha) = year(now()) - 1
);

-- 48. promociones con mayor descuento.
select nombre, descuento 
from promociones 
order by descuento desc 
limit 10;

-- 49. historial de cambios en inventario. ESTA NO SIRVE
select productos.nombre, inventario.fecha_cambio, inventario.cantidad_anterior, inventario.cantidad_actual 
from inventario 
join productos on inventario.id_producto = productos.id_producto 
order by inventario.fecha_cambio desc;

-- 50. total de ventas por proveedor.
select proveedores.nombre, sum(productos.precio) as total_ventas 
from proveedores 
join productos on proveedores.id_proveedor = productos.id_proveedor 
join ventas_productos on productos.id_producto = ventas_productos.id_producto 
group by proveedores.nombre;

-- 51. promedio de ventas por cliente en el último año.
select clientes.nombre, clientes.apellido, avg(total_venta) as promedio_ventas 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
where year(ventas.fecha) = year(now()) - 1 
group by clientes.id_cliente;

-- 52. productos más caros vendidos durante promociones.
select productos.nombre, max(productos.precio) as precio_mas_alto 
from productos 
join ventas_productos on productos.id_producto = ventas_productos.id_producto 
join ventas_promocion on ventas_productos.id_venta = ventas_promocion.id_venta 
group by productos.nombre 
order by precio_mas_alto desc 
limit 5;

-- 53. ventas totales por mes en el último año.
select month(ventas.fecha) as mes, sum(total_venta) as total_ventas 
from ventas 
where year(ventas.fecha) = year(now()) 
group by mes 
order by mes;

-- 54. empleados con el promedio más alto de ventas mensuales.
select empleados.nombre, empleados.apellido, avg(ventas.total_venta) as promedio_ventas 
from empleados 
join ventas on empleados.id_empleado = ventas.id_empleado 
group by empleados.id_empleado 
order by promedio_ventas desc 
limit 5;

-- 55. porcentaje de productos vendidos por categoría.
select categorias.categoria, 
    (count(ventas_productos.id_producto) / (select count(*) from ventas_productos)) * 100 as porcentaje_ventas 
from categorias 
join categorias_productos on categorias.id_categoria = categorias_productos.id_categoria 
join ventas_productos on categorias_productos.id_producto = ventas_productos.id_producto 
group by categorias.categoria;

-- 56. comparación entre ventas con y sin promociones en el último trimestre.
select 
    case when ventas_promocion.id_promocion is not null then 'Con promoción' else 'Sin promoción' end as tipo_venta, 
    count(*) as total_ventas 
from ventas 
left join ventas_promocion on ventas.id_venta = ventas_promocion.id_venta 
where ventas.fecha between date_sub(now(), interval 3 month) and now() 
group by tipo_venta;

-- 57. días con mayores ventas en el año.
select date(ventas.fecha) as fecha, sum(ventas.total_venta) as total_ventas 
from ventas 
where year(ventas.fecha) = year(now()) 
group by fecha 
order by total_ventas desc 
limit 10;

-- 58. clientes que gastaron más dinero en el último semestre.
select clientes.nombre, clientes.apellido, sum(ventas.total_venta) as total_gastado 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
where ventas.fecha between date_sub(now(), interval 6 month) and now() 
group by clientes.id_cliente 
order by total_gastado desc 
limit 10;

-- 59. proveedores que suministraron los productos más caros.
select proveedores.nombre, max(productos.precio) as precio_mas_alto 
from proveedores 
join productos on proveedores.id_proveedor = productos.id_proveedor 
group by proveedores.nombre 
order by precio_mas_alto desc 
limit 5;

-- 60. empleados con el mayor número de ventas en días festivos.
select empleados.nombre, empleados.apellido, count(*) as ventas_festivos 
from empleados 
join ventas on empleados.id_empleado = ventas.id_empleado 
where dayofweek(ventas.fecha) in (1, 7)
group by empleados.id_empleado 
order by ventas_festivos desc;

-- 61. ventas por rango de edad de los clientes. ESTA NO SIRVE
select case 
    when edad between 0 and 18 then '0-18'
    when edad between 19 and 30 then '19-30'
    when edad between 31 and 50 then '31-50'
    else '51+' end as rango_edad, 
    count(*) as total_ventas 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
group by rango_edad 
order by total_ventas desc;

-- 62. inventario restante por categoría de producto.
select categorias.categoria, sum(inventario.cantidad_total) as cantidad_restante 
from categorias 
join categorias_productos on categorias.id_categoria = categorias_productos.id_categoria 
join inventario on categorias_productos.id_producto = inventario.id_producto 
group by categorias.categoria;

-- 63. productos con mayor incremento de precio en el último año. ESTA NO SIRVE
select productos.nombre, max(historico_precios.precio) - min(historico_precios.precio) as incremento_precio 
from productos 
join historico_precios on productos.id_producto = historico_precios.id_producto 
where year(historico_precios.fecha) = year(now()) - 1 
group by productos.id_producto 
order by incremento_precio desc 
limit 5;

-- 64. empleados que no realizaron ventas en el último mes.
select empleados.nombre, empleados.apellido, empleados.celular
from empleados 
where id_empleado not in (
    select distinct id_empleado 
    from ventas 
    where month(fecha) = month(now()) - 1
);

-- 65. productos con el mayor descuento aplicado en promociones.
select productos.nombre, max(promociones.descuento) as descuento_mayor 
from productos 
join promociones_productos on productos.id_producto = promociones_productos.id_producto 
join promociones on promociones_productos.id_promocion = promociones.id_promocion 
group by productos.nombre 
order by descuento_mayor desc 
limit 5;

-- 66. productos devueltos en el último trimestre. 	ESTA NO SIRVE
select productos.nombre, count(devoluciones.id_producto) as total_devoluciones 
from productos 
join devoluciones on productos.id_producto = devoluciones.id_producto 
where devoluciones.fecha between date_sub(now(), interval 3 month) and now() 
group by productos.nombre 
order by total_devoluciones desc;

-- 67. promedio de inventario mensual por producto.
select productos.nombre, avg(inventario.cantidad_total) as promedio_mensual 
from productos 
join inventario on productos.id_producto = inventario.id_producto 
group by productos.nombre;

-- 68. comparación de ventas por categorías en días de semana vs fines de semana.
select categorias.categoria, 
    sum(case when dayofweek(ventas.fecha) in (2, 3, 4, 5, 6) then ventas.total_venta else 0 end) as total_semana, 
    sum(case when dayofweek(ventas.fecha) in (1, 7) then ventas.total_venta else 0 end) as total_finde 
from categorias 
join categorias_productos on categorias.id_categoria = categorias_productos.id_categoria 
join ventas_productos on categorias_productos.id_producto = ventas_productos.id_producto 
join ventas on ventas_productos.id_venta = ventas.id_venta 
group by categorias.categoria;

-- 69. proveedores con productos más vendidos en promociones.
select proveedores.nombre, count(ventas_productos.id_producto) as total_vendidos 
from proveedores 
join productos on proveedores.id_proveedor = productos.id_proveedor 
join ventas_productos on productos.id_producto = ventas_productos.id_producto 
join ventas_promocion on ventas_productos.id_venta = ventas_promocion.id_venta 
group by proveedores.nombre 
order by total_vendidos desc 
limit 5;

-- 70. ventas por cliente en comparación con el promedio general.
select clientes.nombre, clientes.apellido, 
    sum(ventas.total_venta) as total_cliente, 
    (select avg(total_venta) from ventas) as promedio_general 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
group by clientes.id_cliente;

-- 71. productos que estuvieron en inventario en los últimos 3 meses. ESTA NO SIRVE
select productos.nombre 
from productos 
where id_producto in (
    select distinct id_producto 
    from inventario 
    where fecha_cambio between date_sub(now(), interval 3 month) and now()
);

-- 72. ventas diarias en la última semana.
select date(fecha) as dia, sum(total_venta) as total_diario 
from ventas 
where fecha between date_sub(now(), interval 7 day) and now() 
group by dia 
order by dia;

-- 73. clientes que solo compraron durante promociones.
select nombre, apellido 
from clientes 
where id_cliente not in (
    select id_cliente 
    from ventas 
    where id_venta not in (select id_venta from ventas_promocion)
); 

-- 74. top 5 de productos con mayor cantidad en inventario.
select productos.nombre, inventario.cantidad_total 
from productos 
join inventario on productos.id_producto = inventario.id_producto 
order by inventario.cantidad_total desc 
limit 5;

-- 75. días con menor cantidad de ventas en el último mes.
select date(fecha) as dia, count(*) as total_ventas 
from ventas 
where month(fecha) = month(now()) - 1 
group by dia 
order by total_ventas asc 
limit 5;

-- 76. empleados que realizaron ventas superiores al promedio.
select empleados.nombre, empleados.apellido 
from empleados 
join ventas on empleados.id_empleado = ventas.id_empleado 
group by empleados.id_empleado 
having sum(ventas.total_venta) > (select avg(total_venta) from ventas);

-- 77. top 3 promociones con mayor impacto en ventas.
select promociones.nombre, count(ventas_promocion.id_venta) as total_impacto 
from promociones 
join ventas_promocion on promociones.id_promocion = ventas_promocion.id_promocion 
group by promociones.id_promocion 
order by total_impacto desc 
limit 3;

-- 78. ventas realizadas por empleados que están activos actualmente. ESTA NO SIRVE
select empleados.nombre, empleados.apellido, count(ventas.id_venta) as total_ventas 
from empleados 
join ventas on empleados.id_empleado = ventas.id_empleado 
where empleados.activo = 1 
group by empleados.id_empleado;

-- 79. categorías con productos agotados.
select categorias.categoria 
from categorias 
join categorias_productos on categorias.id_categoria = categorias_productos.id_categoria 
join inventario on categorias_productos.id_producto = inventario.id_producto 
where inventario.cantidad_total = 0 
group by categorias.categoria;

-- 80. clientes que hicieron compras todos los meses del último año.
select clientes.nombre, clientes.apellido 
from clientes 
where not exists (
    select 1 
    from (
        select month(fecha) as mes 
        from ventas 
        where ventas.id_cliente = clientes.id_cliente 
        group by mes
        having count(*) = 0
    ) as meses_faltantes
);

-- 81. productos que aumentaron sus ventas en comparación con el mes anterior.
select productos.nombre as productos
from productos 
join ventas_productos on productos.id_producto = ventas_productos.id_producto 
join ventas on ventas_productos.id_venta = ventas.id_venta 
group by productos.id_producto 
having sum(case when month(fecha) = month(now()) - 1 then 1 else 0 end) > 
       sum(case when month(fecha) = month(now()) - 2 then 1 else 0 end);

-- 82. promedio de ventas por día del mes en el último año.
select day(fecha) as dia, avg(total_venta) as promedio_diario 
from ventas 
where year(fecha) = year(now()) 
group by dia 
order by dia;

-- 83. total de devoluciones por producto en el último semestre. ESTA NO SIRVE
select productos.nombre, count(devoluciones.id_producto) as total_devoluciones 
from productos 
join devoluciones on productos.id_producto = devoluciones.id_producto 
where devoluciones.fecha between date_sub(now(), interval 6 month) and now() 
group by productos.id_producto 
order by total_devoluciones desc;

-- 84. comparacion de ventas entre promociones y sin promociones.
select 'Con Promoción' as tipo_venta, count(*) as total 
from ventas 
join ventas_promocion on ventas.id_venta = ventas_promocion.id_venta 
union all 
select 'Sin Promoción', count(*) 
from ventas 
where id_venta not in (select id_venta from ventas_promocion);

-- 85. empleados con más ventas en un día específico.
select empleados.nombre, empleados.apellido, count(*) as ventas_totales 
from empleados 
join ventas on empleados.id_empleado = ventas.id_empleado 
where fecha = '2024-10-15' 
group by empleados.id_empleado 
order by ventas_totales desc;

-- 86. categorías con mayor número de productos vendidos en el último mes.
select categorias.categoria, count(ventas_productos.id_producto) as productos_vendidos 
from categorias 
join categorias_productos on categorias.id_categoria = categorias_productos.id_categoria 
join ventas_productos on categorias_productos.id_producto = ventas_productos.id_producto 
join ventas on ventas_productos.id_venta = ventas.id_venta 
where month(ventas.fecha) = month(now()) - 1 
group by categorias.categoria 
order by productos_vendidos desc;

-- 87. clientes que compraron más de una vez en la misma promoción.
select clientes.nombre, clientes.apellido, promociones.nombre as promocion, count(*) as compras 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
join ventas_promocion on ventas.id_venta = ventas_promocion.id_venta 
join promociones on ventas_promocion.id_promocion = promociones.id_promocion 
group by clientes.id_cliente, promociones.id_promocion 
having compras > 1;

-- 88. top 5 de proveedores con más productos en inventario.
select proveedores.nombre, count(productos.id_producto) as total_productos 
from proveedores 
join productos on proveedores.id_proveedor = productos.id_proveedor 
join inventario on productos.id_producto = inventario.id_producto 
where inventario.cantidad_total > 0 
group by proveedores.id_proveedor 
order by total_productos desc 
limit 5;

-- 89. productos más vendidos por temporada (verano, invierno, etc.). esta no sirve
select productos.nombre, temporadas.temporada, count(ventas_productos.id_producto) as total_vendidos 
from productos 
join ventas_productos on productos.id_producto = ventas_productos.id_producto 
join ventas on ventas_productos.id_venta = ventas.id_venta 
join temporadas on month(ventas.fecha) = temporadas.mes 
group by productos.id_producto, temporadas.temporada 
order by total_vendidos desc 
limit 10;

-- 90. clientes con el mayor número de devoluciones. esta no sirve
select clientes.nombre, clientes.apellido, count(devoluciones.id_devolucion) as total_devoluciones 
from clientes 
join devoluciones on clientes.id_cliente = devoluciones.id_cliente 
group by clientes.id_cliente 
order by total_devoluciones desc 
limit 5;

-- 91. productos que nunca se devolvieron. esta no sirve
select productos.nombre 
from productos 
where id_producto not in (
    select distinct id_producto 
    from devoluciones
); 

-- 92. clientes que compraron productos en todas las categorías.
select clientes.nombre, clientes.apellido 
from clientes 
where not exists (
    select 1 
    from categorias 
    where categorias.id_categoria not in (
        select categorias_productos.id_categoria 
        from ventas 
        join ventas_productos on ventas.id_venta = ventas_productos.id_venta 
        join categorias_productos on ventas_productos.id_producto = categorias_productos.id_producto 
        where ventas.id_cliente = clientes.id_cliente
    )
);

-- 93. comparación entre cantidad de ventas y devoluciones por producto. esta no sirve
select productos.nombre, 
    count(ventas_productos.id_producto) as total_ventas, 
    count(devoluciones.id_producto) as total_devoluciones 
from productos 
left join ventas_productos on productos.id_producto = ventas_productos.id_producto 
left join devoluciones on productos.id_producto = devoluciones.id_producto 
group by productos.id_producto 
order by total_ventas desc;

-- 94. análisis de ventas de productos premium (por ejemplo, > 100 USD).
select productos.nombre, count(ventas_productos.id_producto) as total_vendidos 
from productos 
join ventas_productos on productos.id_producto = ventas_productos.id_producto 
where productos.precio > 100 
group by productos.id_producto 
order by total_vendidos desc;

-- 95. clientes que compraron más en temporada baja.
select clientes.nombre, clientes.apellido, sum(ventas.total_venta) as total_bajo 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
where month(ventas.fecha) in (1, 2, 9, 10)
group by clientes.id_cliente 
order by total_bajo desc 
limit 5;

-- 96. productos más vendidos en días lluviosos (si se tiene información meteorológica). esta no sirve
select productos.nombre, count(ventas_productos.id_producto) as total_vendidos 
from productos 
join ventas_productos on productos.id_producto = ventas_productos.id_producto 
join ventas on ventas_productos.id_venta = ventas.id_venta 
join clima on date(ventas.fecha) = clima.fecha 
where clima.condicion = 'lluvia' 
group by productos.id_producto 
order by total_vendidos desc 
limit 5;

-- 97. empleados con mejores evaluaciones de desempeño (si existe un sistema de evaluación). esta no sirve
select empleados.nombre, empleados.apellido, avg(evaluaciones.puntuacion) as promedio_evaluacion 
from empleados 
join evaluaciones on empleados.id_empleado = evaluaciones.id_empleado 
group by empleados.id_empleado 
order by promedio_evaluacion desc 
limit 5;

-- 98. categorías con productos con más descuentos aplicados.
select categorias.categoria, count(promociones_productos.id_promocion) as total_descuentos 
from categorias 
join categorias_productos on categorias.id_categoria = categorias_productos.id_categoria 
join promociones_productos on categorias_productos.id_producto = promociones_productos.id_producto 
group by categorias.id_categoria 
order by total_descuentos desc;

-- 99. productos vendidos en promociones con diferentes descuentos (comparar descuentos).
select productos.nombre, promociones.descuento, count(ventas_productos.id_producto) as total_vendidos 
from productos 
join ventas_productos on productos.id_producto = ventas_productos.id_producto 
join ventas_promocion on ventas_productos.id_venta = ventas_promocion.id_venta 
join promociones on ventas_promocion.id_promocion = promociones.id_promocion 
group by productos.nombre, promociones.descuento 
order by total_vendidos desc;

-- 100. clientes con mayor frecuencia en compras.
select clientes.nombre, clientes.apellido, count(ventas.id_venta) as total_compras 
from clientes 
join ventas on clientes.id_cliente = ventas.id_cliente 
group by clientes.id_cliente 
order by total_compras desc 
limit 10;
