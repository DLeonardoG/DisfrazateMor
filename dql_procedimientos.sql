-- 1. Registrar una nueva compra
create procedure registrar_compra(
	
);

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

-- Actualizar el stock de productos: Un procedimiento que actualice la cantidad en la tabla inventario tras realizar una venta o una compra.

-- Registrar una venta: Un procedimiento que inserte una nueva venta, incluyendo la gestión de los productos vendidos y la actualización del stock.

-- Agregar un nuevo cliente: Un procedimiento que permita insertar un nuevo cliente en la tabla clientes.

-- Calcular descuentos aplicables: Un procedimiento que calcule y aplique descuentos a una venta en función de las promociones activas.

-- Buscar productos por categoría: Un procedimiento que devuelva todos los productos que pertenecen a una categoría específica.

-- Generar reportes de ventas: Un procedimiento que genere un reporte de ventas por fecha, empleado, o método de pago.

-- Eliminar un producto: Un procedimiento que elimine un producto de la base de datos, asegurando que se manejen correctamente las relaciones y dependencias.

-- Listar productos en promoción: Un procedimiento que devuelva todos los productos que están actualmente en promoción.

-- Actualizar la información de un proveedor: Un procedimiento que permita actualizar los detalles de un proveedor existente.

-- Registrar un nuevo empleado: Un procedimiento que permita agregar un nuevo empleado a la base de datos.

-- Listar todos los empleados activos: Un procedimiento que devuelva la lista de empleados que han sido contratados y están activos.

-- Auditar cambios en el inventario: Un procedimiento que registre cambios en el inventario, como ajustes manuales o correcciones de stock.

-- Consultar el historial de compras de un proveedor: Un procedimiento que devuelva todas las compras realizadas a un proveedor específico.

-- Verificar la disponibilidad de productos: Un procedimiento que verifique si hay stock suficiente para un conjunto de productos antes de proceder con una venta.

-- Enviar notificaciones de reposición: Un procedimiento que verifique el stock de productos y envíe alertas cuando un producto esté por debajo de un umbral crítico.

-- Actualizar precios de productos: Un procedimiento que permita modificar el precio de un producto, asegurándose de que se actualicen las tablas relacionadas.

-- Registrar una nueva promoción: Un procedimiento que inserte una nueva promoción y asocie las categorías o productos correspondientes.

-- Eliminar un cliente: Un procedimiento que elimine un cliente de la base de datos, manejando adecuadamente cualquier relación con ventas anteriores.

-- Generar un reporte de inventario: Un procedimiento que genere un reporte completo del inventario, mostrando la cantidad de cada producto por talla y categoría.