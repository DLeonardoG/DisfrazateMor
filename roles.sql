-- el administrador con acceso total
create user 'admin'@'localhost' identified by 'password_admin';
grant all privileges on disfrazateMor.* to 'admin'@'localhost' with grant option;

-- el vendedor con acceso limitado a ventas y gestion de inventario
create user 'vendedor'@'localhost' identified by 'password_vendedor';
grant select, insert, update on disfrazateMor.ventas to 'vendedor'@'localhost';
grant select, update on disfrazateMor.inventario to 'vendedor'@'localhost';

-- el encargado de proveedores con acceso a las compras
create user 'encargado_proveedores'@'localhost' identified by 'password_proveedor';
grant select, insert, update on disfrazateMor.compras to 'encargado_proveedores'@'localhost';

-- el gerente con acceso a reportes financieros y control de empleados
create user 'gerente'@'localhost' identified by 'password_gerente';
grant select on disfrazateMor.ventas to 'gerente'@'localhost';
grant select, update on disfrazateMor.empleados to 'gerente'@'localhost';

-- el encargado de almacen que puede revisar y actualizar los inventarios
create user 'encargado_almacen'@'localhost' identified by 'password_almacen';
grant select, update on disfrazateMor.inventario to 'encargado_almacen'@'localhost';

-- los privilegios de los usuarios
show grants for 'admin'@'localhost';
show grants for 'vendedor'@'localhost';
show grants for 'encargado_proveedores'@'localhost';
show grants for 'gerente'@'localhost';
show grants for 'encargado_almacen'@'localhost';


