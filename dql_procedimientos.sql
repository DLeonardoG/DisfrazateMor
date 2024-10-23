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