# DisfrazateMor⭐

## Tabla de contenido
| Indice | Título  |
|--|--|
| 1. | [Descripción](#Descripcion) |
| 2. | [Características](#Características) |
| 3. | [Requerimientos](#Requerimientos) |
| 4. | [Tecnologías Utilizadas](#Tecnologias) |
| 5. | [Consultas](#Consultas) |
| 5. | [Procedimientos](#Procedimientos) |
| 6. | [Funciones](#Funciones) |
| 7. | [Triggers](#Triggers) |
| 8. | [Eventos](#Eventos) |
| 9. | [Roles de Usuario y Permisos](#Roles_de_Usuario_y_Permisos)|
| 10. | [Uso del Repositorio](#Uso) |
| 11. | [Instrucciones de Ejecución](#Instrucciones) |
| 12. | [Autores](#Autores) |

## Descripcion🚀

La tienda DisfrazateMor es un sistema de gestión diseñado para facilitar la venta de disfraces y productos relacionados. La base de datos tiene como propósito almacenar información sobre productos, clientes, ventas, y el historial de transacciones, garantizando una experiencia de usuario eficiente y optimizada. Las funcionalidades implementadas incluyen el registro de ventas, gestión de inventario, control de descuentos, y seguimiento de cambios en la información de clientes y empleados.

# Requerimientos

## Entidades

### tallas
- **Atributos**: `id_talla`, `talla`
- **Descripción**: Almacena las diferentes tallas de los productos.

### tipos_proveedores
- **Atributos**: `id_tipo_proveedor`, `tipo_proveedor`
- **Descripción**: Define los tipos de proveedores que suministran productos.

### categorias
- **Atributos**: `id_categoria`, `categoria`
- **Descripción**: Clasifica los productos en distintas categorías.

### roles
- **Atributos**: `id_rol`, `rol`, `descripcion`
- **Descripción**: Define los diferentes roles de usuarios en el sistema.

### metodos
- **Atributos**: `id_metodo`, `metodo`
- **Descripción**: Almacena los métodos de pago disponibles.

### tipos
- **Atributos**: `id_tipo`, `tipo`
- **Descripción**: Define los tipos de productos.

### generos
- **Atributos**: `id_genero`, `genero`
- **Descripción**: Almacena los diferentes géneros de productos.

### proveedores
- **Atributos**: `id_proveedor`, `nombre`, `celular`, `id_tipo_proveedor`
- **Descripción**: Almacena información sobre los proveedores de productos.
- **Relación**: `id_tipo_proveedor` es clave foránea que referencia a `tipos_proveedores`.

### clasificaciones
- **Atributos**: `id_clasificacion`, `clasificacion`
- **Descripción**: Define las clasificaciones de productos.

### productos
- **Atributos**: `id_producto`, `nombre`, `descripcion`, `precio`, `id_clasificacion`, `id_tipo`, `id_genero`, `id_proveedor`
- **Descripción**: Almacena información sobre los productos.
- **Relaciones**: 
  - `id_clasificacion` referencia a `clasificaciones`.
  - `id_tipo` referencia a `tipos`.
  - `id_genero` referencia a `generos`.
  - `id_proveedor` referencia a `proveedores`.

### inventario
- **Atributos**: `id_inventario`, `id_producto`, `cantidad_total`
- **Descripción**: Mantiene el control de inventario de los productos.
- **Relación**: `id_producto` es clave foránea que referencia a `productos`.

### clientes
- **Atributos**: `id_cliente`, `nombre`, `apellido`, `celular`
- **Descripción**: Almacena información de los clientes.

### cargos
- **Atributos**: `id_cargo`, `cargo`, `sueldo`, `id_rol`
- **Descripción**: Define los diferentes cargos que pueden tener los empleados.
- **Relación**: `id_rol` referencia a `roles`.

### empleados
- **Atributos**: `id_empleado`, `nombre`, `apellido`, `celular`, `fecha_inicio`, `id_cargo`
- **Descripción**: Almacena información sobre los empleados de la tienda.
- **Relación**: `id_cargo` es clave foránea que referencia a `cargos`.

### usuarios
- **Atributos**: `id_usuario`, `nombre_usuario`, `contrasena`, `id_empleado`
- **Descripción**: Almacena información de los usuarios del sistema.
- **Relación**: `id_empleado` referencia a `empleados`.

### compras
- **Atributos**: `id_compra`, `id_proveedor`, `fecha`, `total`
- **Descripción**: Registra las compras realizadas a proveedores.
- **Relación**: `id_proveedor` referencia a `proveedores`.

### promociones
- **Atributos**: `id_promocion`, `nombre`, `descripcion`, `fecha_inicio`, `fecha_fin`, `descuento`
- **Descripción**: Almacena información sobre las promociones disponibles.

### compras_productos
- **Atributos**: `id_producto`, `id_compra`, `id_compra_producto`
- **Descripción**: Relaciona productos con compras específicas.
- **Relaciones**: 
  - `id_producto` referencia a `productos`.
  - `id_compra` referencia a `compras`.

### ventas
- **Atributos**: `id_venta`, `fecha`, `id_metodo`, `id_cliente`, `id_empleado`, `total_venta`, `descuento`
- **Descripción**: Registra las ventas realizadas.
- **Relaciones**: 
  - `id_metodo` referencia a `metodos`.
  - `id_cliente` referencia a `clientes`.
  - `id_empleado` referencia a `empleados`.

### ventas_productos
- **Atributos**: `id_producto`, `id_venta`, `id_venta_producto`, `cantidad`
- **Descripción**: Relaciona productos con ventas específicas.
- **Relaciones**: 
  - `id_producto` referencia a `productos`.
  - `id_venta` referencia a `ventas`.

### devoluciones
- **Atributos**: `id_devolucion`, `id_producto`, `cantidad`, `fecha_devolucion`
- **Descripción**: Registra las devoluciones de productos.
- **Relación**: `id_producto` referencia a `productos`.

### usuarios_roles
- **Atributos**: `id_usuario`, `id_rol`
- **Descripción**: Relaciona usuarios con sus roles en el sistema.
- **Relaciones**: 
  - `id_usuario` referencia a `usuarios`.
  - `id_rol` referencia a `roles`.

## Relaciones

### Uno a muchos
- `proveedores` a `productos`: Un proveedor puede suministrar múltiples productos.
- `categorias` a `productos`: Una categoría puede incluir múltiples productos.
- `clientes` a `ventas`: Un cliente puede realizar múltiples ventas.
- `empleados` a `ventas`: Un empleado puede estar asociado a múltiples ventas.
- `compras` a `compras_productos`: Una compra puede incluir múltiples productos.
- `ventas` a `ventas_productos`: Una venta puede incluir múltiples productos.
- `roles` a `cargos`: Un rol puede tener múltiples cargos asociados.

### Muchos a muchos
- `productos` a `tallas` a través de `productos_tallas`: Un producto puede tener múltiples tallas y una talla puede estar asociada a múltiples productos.
- `promociones` a `categorias` a través de `promociones_categorias`: Una promoción puede aplicarse a múltiples categorías y una categoría puede tener múltiples promociones.
- `promociones` a `productos` a través de `promociones_productos`: Una promoción puede incluir múltiples productos y un producto puede estar en múltiples promociones.

## Tecnologias🖥️ 

- **SQL** : Se uso para el codigo de la base de datos.
- **UML STAR** : Se uso para el diseño del diagrama ER.
- **Workbench** : Se uso para el modelado fisico del MySQL.

# Consultas
```sql
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

-- 49. resumen de ventas
select c.nombre as nombre_cliente, v.total_venta, v.fecha 
from ventas v
join clientes c on v.id_cliente = c.id_cliente 
order by v.fecha desc;
```

# Procedimientos
```sql
-- 1 registrar un nuevo proveedor
drop procedure if exists agregar_nuevo_proveedor;

DELIMITER $$
create procedure agragar_nuevo_proveedor(
    nombre varchar(125),
    celular char(10),
    id_tipo_proveedor int
)
begin
	insert  into proveedores (nombre, celular, id_tipo_proveedor)
    values (nombre, celular, id_tipo_proveedor);
end $$
DELIMITER ;
call agragar_nuevo_proveedor('paisas la 36', '3123404945', 2);
select * from proveedores;

-- 2.  añadir una nueva categoria
drop procedure if exists registrar_nueva_categoria;
delimiter $$
create procedure registrar_nueva_categoria(
	nueva_categoria varchar(125)
)
begin
	insert into categorias(categoria)
    values(nueva_categoria);
end $$
delimiter ;
call registrar_nueva_categoria('Belleza');
select * from categorias;

-- 3 actualizar el precio de un producto en la base de datos
drop procedure if exists actualizar_precio;
delimiter $$
create procedure actualizar_precio(
    p_id_producto int,
    p_precio decimal(10,2)
)
begin
    update productos
    set precio = p_precio
    where id_producto = p_id_producto;
end $$
delimiter ;
call actualizar_precio(5,100000);
select * from productos; 

-- 4. proceso para eliminar un cliente de la base de datos por su id
drop procedure if exists eliminar_cliente_por_telefono;
delimiter $$
create procedure eliminar_cliente_por_telefono(
    p_celular char(10)
)
begin
    declare cliente_existente int;
    select count(*) into cliente_existente
    from clientes
    where celular = p_celular;
    if cliente_existente = 0 then
        select 'el cliente no existe' as mensaje;
    elseif cliente_existente >= 1 then
        delete from clientes
        where celular = p_celular;
        select 'cliente eliminado exitosamente' as mensaje;
    end if;
end $$
delimiter ;
call eliminar_cliente_por_telefono('300000010'); 
select * from clientes;

-- 5. proceso para registrar un nuevo método de pago
drop procedure if exists registrar_metodo_pago;
delimiter $$
create procedure registrar_metodo_pago(nuevo_metodo varchar(50)) 
begin 
    insert into metodos (metodo) values (nuevo_metodo); 
end $$
delimiter ;
call registrar_metodo_pago('Nequi'); 
select * from metodos;

-- 6. proceso para actualizar la información de un proveedor
drop procedure if exists actualizar_proveedor;
delimiter $$
create procedure actualizar_proveedor(p_id_proveedor INT, p_nombre VARCHAR(125), p_celular CHAR(10)) 
begin 
    update proveedores set nombre = p_nombre, celular = p_celular where id_proveedor = p_id_proveedor; 
end $$
delimiter ;
call actualizar_proveedor(1, 'Nuevo proveedor creado', '3063500002');

-- 7. proceso para registrar una nueva talla de producto
drop procedure if exists registrar_talla;
delimiter $$
create procedure registrar_talla(p_talla VARCHAR(10)) 
begin 
    insert into tallas (talla) values (p_talla); 
end $$
delimiter ;
call registrar_talla('XXXL'); 
select * from tallas;

-- 8. proceso para asignar un rol a un empleado
drop procedure if exists asignar_rol_empleado;
delimiter $$
create procedure asignar_rol_empleado(p_id_empleado int, p_id_rol INT) 
begin 
    update empleados set id_cargo = (select id_cargo from cargos where id_rol = p_id_rol) where id_empleado = p_id_empleado; 
end $$
delimiter ;
call asignar_rol_empleado(1, 5); 
select * from empleados;

-- 9. proceso para eliminar un producto del inventario
drop procedure if exists eliminar_producto_inventario;
delimiter $$
create procedure eliminar_producto_inventario(p_id_producto int) 
begin 
    declare producto_existente int; 
	SET SQL_SAFE_UPDATES = 0; 
    select count(*) into producto_existente from productos where id_producto = p_id_producto; 
    if producto_existente = 0 then 
        select 'el producto no existe' as mensaje; 
    end if; 
    delete from ventas_productos_tallas where id_venta_producto in (select id_venta_producto from ventas_productos where id_producto = p_id_producto); 
    delete from ventas_productos where id_producto = p_id_producto; 
    delete from compras_productos where id_producto = p_id_producto; 
    delete from productos_tallas where id_producto = p_id_producto; 
    delete from promociones_productos where id_producto = p_id_producto; 
    delete from inventario where id_producto = p_id_producto; 
    delete from productos where id_producto = p_id_producto; 
    select 'producto eliminado exitosamente' as mensaje; 
	SET SQL_SAFE_UPDATES = 1; 
end $$
delimiter ;
call eliminar_producto_inventario(1); 
select * from productos;

-- 11. proceso para registrar un nuevo cliente
drop procedure if exists registrar_nuevo_cliente;
delimiter $$
create procedure registrar_nuevo_cliente(p_nombre varchar(125), p_apellido varchar(255), p_celular char(10)) 
begin 
    declare celular_existente int; 
    select count(*) into celular_existente from clientes where celular = p_celular; 
    if celular_existente > 0 then 
        select 'el celular ya está registrado' as mensaje; 
    else 
        insert into clientes (nombre, apellido, celular) values (p_nombre, p_apellido, p_celular); 
        select 'cliente registrado exitosamente' as mensaje; 
    end if; 
end $$
delimiter ;
call registrar_nuevo_cliente('Juanito', 'Pedraza', '3063501202'); 
select * from clientes;

-- 12. proceso para actualizar el sueldo de un empleado
drop procedure if exists actualizar_sueldo_cargo;
delimiter $$
create procedure actualizar_sueldo_cargo(p_id_cargo int, p_nuevo_sueldo decimal(10, 2)) 
begin 
    update cargos set sueldo = p_nuevo_sueldo where id_cargo = p_id_cargo; 
end $$
delimiter ;
call actualizar_sueldo_cargo(13, 80000000); 
select * from cargos;

-- 13. proceso para actualizar el nombre de una categoría
drop procedure if exists actualizar_nombre_categoria;
delimiter $$
create procedure actualizar_nombre_categoria(c_id_categoria int, c_categoria varchar(255)) 
begin 
    update categorias set categoria = c_categoria where id_categoria = c_id_categoria; 
end $$
delimiter ;
call actualizar_nombre_categoria(1, 'nueva categoria'); 
select * from categorias;

-- 14. proceso para añadir una descripción a un producto
drop procedure if exists crear_actualizar_descripcion_producto;
delimiter $$
create procedure crear_actualizar_descripcion_producto(p_id_producto int, p_descripcion varchar(255)) 
begin 
    rollback; 
    select 'Error, no elegiste un producto existente'; 
end $$
start transaction; 
update productos set descripcion = p_descripcion where id_producto = p_id_producto; 
commit; 
delimiter ;
call crear_actualizar_descripcion_producto(70,'Esta es la nueva descripcion del producto cuando la cambiamos'); 
select id_producto as id, nombre, descripcion from productos order by id asc;

-- 15. proceso para actualizar los datos de contacto de un cliente
drop procedure if exists actualizar_cliente;
delimiter $$
create procedure actualizar_cliente(p_id_cliente INT, p_nombre VARCHAR(125), p_apellido VARCHAR(125), p_celular CHAR(10)) 
begin 
    declare celular_existente int; 
    select count(*) into celular_existente from clientes where celular = p_celular; 
    if celular_existente > 0 then 
        select 'el telefono que ingresaste ya existe' as mensaje; 
    end if; 
    start transaction; 
    update clientes set nombre = p_nombre, apellido = p_apellido, celular = p_celular where id_cliente = p_id_cliente; 
    commit; 
end $$ 
delimiter ;
call actualizar_cliente(1, 'Dora', 'la exploradora', '3000000231'); 
select nombre, apellido, celular from clientes;

-- 16. proceso para registrar una nueva clasificación de productos
drop procedure if exists registrar_clasificacion;
delimiter $$
create procedure registrar_clasificacion(p_clasificacion varchar(255)) 
begin 
    if exists (select 1 from clasificaciones where clasificacion = p_clasificacion) then 
        select 'La clasificación ya existe' as mensaje; 
    else 
        insert into clasificaciones (clasificacion) values (p_clasificacion); 
        select 'Clasificación registrada exitosamente' as mensaje; 
    end if; 
end $$
delimiter ;
call registrar_clasificacion('importado'); 
select * from clasificaciones;

-- 17. proceso para cambiar la contraseña de un usuario
drop procedure if exists cambiar_password_usuario;
delimiter $$
create procedure cambiar_password_usuario(p_nombre_usuario varchar(100), nueva_password varchar(50), p_id_rol int) 
begin 
    declare usuario_existente int; 
    SET SQL_SAFE_UPDATES = 0; 
    select count(*) into usuario_existente from usuarios where nombre_usuario = p_nombre_usuario; 
    if usuario_existente = 0 then 
        select 'El usuario no existe o no pertenece a un empleado' as mensaje; 
    else 
        if p_id_rol not in (select id_rol from roles where rol in ('Gerente', 'Recursos Humanos', 'Supervisor')) then 
            select 'No tienes permiso para cambiar contraseñas' as mensaje; 
        else 
            update usuarios set contrasena = nueva_password where nombre_usuario = p_nombre_usuario; 
            SET SQL_SAFE_UPDATES = 1; 
            select 'Contraseña actualizada exitosamente' as mensaje; 
        end if; 
    end if; 
end $$ 
delimiter ;
call cambiar_password_usuario('j.perezzz', '1111222', 2); 
select * from usuarios; 
select * from roles;

-- 18. proceso para verificar la existencia de un producto en inventario
drop procedure if exists verificar_producto_en_inventario;
delimiter $$
create procedure verificar_producto_en_inventario(p_id_producto int) 
begin 
    declare p_cantidad_total int; 
    select cantidad_total into p_cantidad_total from inventario where id_producto = p_id_producto; 
    if p_cantidad_total is null then 
        select 'El producto no existe en el inventario' as mensaje; 
    elseif p_cantidad_total > 0 then 
        select 'El producto está disponible en el inventario' as mensaje; 
    else 
        select 'El producto no está disponible en el inventario' as mensaje; 
    end if; 
end $$ 
delimiter ;
call verificar_producto_en_inventario(3); 
select * from inventario;

-- 19. proceso para actualizar la fecha de inicio de un empleado
drop procedure if exists actualizar_fecha_inicio_empleado;
delimiter $$
create procedure actualizar_fecha_inicio_empleado(p_id_empleado int, p_nueva_fecha_inicio date) 
begin 
    declare empleado_existente INT; 
    select count(*) into empleado_existente from empleados where id_empleado = p_id_empleado; 
    if empleado_existente = 0 then 
        select 'El empleado no existe' as mensaje; 
    else 
        update empleados set fecha_inicio = p_nueva_fecha_inicio where id_empleado = p_id_empleado; 
        select 'Fecha de inicio actualizada exitosamente' as mensaje; 
    end if; 
end $$ 
delimiter ;
call actualizar_fecha_inicio_empleado(1, '2024-10-01'); 
select * from empleados;

-- 20. proceso para eliminar un método de pago
drop procedure if exists eliminar_metodo_pago;
delimiter $$
create procedure eliminar_metodo_pago(p_id_metodo int) 
begin 
    declare metodo_existente int; 
    select count(*) into metodo_existente from metodos where id_metodo = p_id_metodo; 
    if metodo_existente = 0 then 
        select 'el método de pago no existe' as mensaje; 
    else 
        delete from metodos where id_metodo = p_id_metodo; 
        select 'método de pago eliminado exitosamente' as mensaje; 
    end if; 
end $$
delimiter ;
call eliminar_metodo_pago(5); 
select * from metodos;
```

# Funciones

```sql
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
```

 # Triggers
 
```sql
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
```

# Eventos

```sql
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
```

# Roles de Usuario y Permisos

```sql
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
```

## Uso📝

Este repositorio contiene el código fuente del proyecto disfrazateMor, conteniendo todo el maquetado de la base de datos de una tienda de disfraces con todo lo adecuado estando lista para que agreguen datos y hagan consultas con datos de maquetado y demas.

## Instrucciones📐

## Requisitos del Sistema

1. **Sistema Operativo**: Windows, macOS o Linux.
2. **Software de Base de Datos**:
   - **MySQL**: Versión 8.0 o superior (recomendado).
   - **Cliente de MySQL**: MySQL Workbench o cualquier otro cliente compatible (como DBeaver, HeidiSQL, etc.).

## Instalación y Configuración

### Paso 1: Instalación de MySQL

1. **Descargar MySQL**:
   - Ve a [MySQL Community Downloads](https://dev.mysql.com/downloads/mysql/).
   - Selecciona la versión adecuada para tu sistema operativo.

2. **Instalar MySQL**:
   - Ejecuta el instalador descargado.
   - Sigue las instrucciones en pantalla y elige la instalación "Server Only" o "Full" según tus necesidades.
   - Configura la contraseña para el usuario `root` y asegúrate de recordar esta contraseña.

3. **Iniciar el Servicio de MySQL**:
   - Asegúrate de que el servicio MySQL esté corriendo. Esto puede hacerse desde el panel de servicios de tu sistema operativo o mediante el terminal con el comando `sudo service mysql start` en Linux.

### Paso 2: Instalación de MySQL Workbench

1. **Descargar MySQL Workbench**:
   - Ve a [MySQL Workbench Downloads](https://dev.mysql.com/downloads/workbench/).
   - Selecciona la versión adecuada para tu sistema operativo.

2. **Instalar MySQL Workbench**:
   - Ejecuta el instalador y sigue las instrucciones en pantalla.

### Paso 3: Configuración de la Base de Datos

1. **Abrir MySQL Workbench**:
   - Lanza MySQL Workbench y crea una nueva conexión utilizando las credenciales del usuario `root`.

2. **Ejecutar el archivo `ddl.sql`**:
   - Abre una nueva pestaña de SQL en MySQL Workbench.
   - Copia y pega el contenido del archivo `ddl.sql` en la ventana de consulta.
   - Haz clic en el botón "Ejecutar" (ícono del rayo) o presiona `Ctrl + Shift + Enter` para ejecutar el script. Esto creará la estructura de la base de datos.

3. **Cargar los datos iniciales con el archivo `dml.sql`**:
   - Abre otra pestaña de SQL en MySQL Workbench.
   - Copia y pega el contenido del archivo `dml.sql` en la ventana de consulta.
   - Ejecuta el script de la misma manera que en el paso anterior. Esto cargará los datos iniciales en las tablas correspondientes.

### Paso 4: Ejecutar Consultas, Procedimientos Almacenados, Funciones, Eventos y Triggers

1. **Ejecutar Consultas**:
   - En MySQL Workbench, puedes escribir tus consultas SQL en una nueva pestaña de consulta y ejecutarlas de la misma manera.

2. **Procedimientos Almacenados y Funciones**:
   - Si tienes scripts para crear procedimientos almacenados o funciones, puedes ejecutarlos en una pestaña de SQL, igual que los scripts anteriores.

3. **Eventos**:
   - Los eventos se crean de manera similar a las funciones y procedimientos. Asegúrate de tener habilitada la opción `EVENTS` en tu configuración de base de datos.

4. **Triggers**:
   - Los triggers también se crean mediante scripts SQL. Asegúrate de que el script esté en el formato correcto y ejecútalo en una pestaña de SQL.

## Autores👤

[Leonardo Gonzalez](https://github.com/DLeonardoG) 

[Erik Plata](https://github.com/ErikSneyPlata) 
