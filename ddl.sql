drop database if exists disfrazateMor;
create database if not exists disfrazateMor;

use disfrazateMor;
show databases;
show tables;

create table if not exists categorias (
	id_categoria int primary key auto_increment,
    categoria varchar(255) not null unique
);

create table if not exists roles (
	id_rol int primary key auto_increment,
    rol varchar(255) not null unique,
    descripcion varchar(255) not null
);

create table if not exists metodos (
	id_metodo int primary key auto_increment,
    metodo varchar(255) not null unique
);

create table if not exists tipos (
	id_tipo int primary key auto_increment,
    tipo varchar(255) not null unique
);

create table if not exists generos (
	id_genero int primary key auto_increment,
    genero varchar(255) not null unique
);

create table if not exists proveedores (
	id_proveedor int primary key auto_increment,
    nombre varchar(255) not null,
    celular char(10) not null unique
);

create table if not exists clasificaciones (
	id_clasificacion int primary key auto_increment,
    clasificacion varchar(255) not null
);

create table if not exists productos (
	id_producto int primary key auto_increment,
    nombre varchar(255) not null,
    descripcion varchar(255) not null,
    precio decimal not null,
    id_clasificacion int not null,
    id_tipo int not null,
    id_genero int not null,
    id_proveedor int not null, 
    foreign key (id_clasificacion) references clasificaciones(id_clasificacion),
    foreign key (id_tipo) references tipos(id_tipo),
    foreign key (id_genero) references generos(id_genero),
    foreign key (id_proveedor) references proveedores(id_proveedor)
);

create table if not exists inventario (
	id_inventario int primary key auto_increment,
    id_producto int not null,
    cantidad int not null
);

create table if not exists clientes (
	id_cliente int primary key auto_increment,
    nombre varchar(255) not null,
    apellido varchar(255) not null,
    celular char(10) not null unique
);

create table if not exists cargos (
	id_cargo int primary key auto_increment,
    cargo varchar(255) not null unique,
    sueldo decimal not null,
    id_rol int not null, 
    foreign key (id_rol) references roles(id_rol)
);

create table if not exists empleados (
	id_empleado int primary key auto_increment,
    nombre varchar(255) not null,
    apellido varchar(255) not null,
    celular char(10) not null unique,
    fecha_inicio date not null,
    id_cargo int,
    foreign key (id_cargo) references cargos(id_cargo)
);

create table if not exists usuarios (
	id_usuario int primary key auto_increment,
    nombre_usuario varchar(255) not null,
    contrasena varchar(255) not null,
	id_empleado int,
    foreign key (id_empleado) references empleados(id_empleado)
);

create table if not exists compras (
	id_compra int primary key auto_increment,
	id_proveedor int,
    foreign key (id_proveedor) references proveedores(id_proveedor),
    fecha date not null,
    total decimal not null
);

create table if not exists promociones (
	id_promocion int primary key auto_increment,
    nombre varchar(255) not null,
    descripcion varchar(255) not null,
    fecha_inicio date not null,
    fecha_fin date not null,
    descuento decimal not null
);

create table if not exists compras_productos (
    id_producto int not null, 
	id_compra int not null, 
    foreign key (id_producto) references productos(id_producto),
    foreign key (id_compra) references compras(id_compra)
);

create table if not exists promociones_categorias(
    id_promocion int not null, 
	id_categoria int not null, 
    foreign key (id_promocion) references promociones(id_promocion),
    foreign key (id_categoria) references categorias(id_categoria)
);

create table if not exists ventas (
	id_venta int primary key auto_increment,
    fecha date not null,
    id_metodo int not null,
    id_cliente int not null,
    id_empleado int not null, 
    foreign key (id_metodo) references metodos(id_metodo),
    foreign key (id_cliente) references clientes(id_cliente),
    foreign key (id_empleado) references empleados(id_empleado)
);

create table if not exists ventas_productos(
    id_producto int not null, 
	id_venta int not null, 
    foreign key (id_producto) references productos(id_producto),
    foreign key (id_venta) references ventas(id_venta)
);

create table if not exists ventas_promocion(
    id_promocion int not null, 
	id_venta int not null, 
    foreign key (id_promocion) references promociones(id_promocion),
    foreign key (id_venta) references ventas(id_venta)
);

create table if not exists promociones_productos(
    id_promocion int not null, 
	id_producto int not null, 
    foreign key (id_promocion) references promociones(id_promocion),
    foreign key (id_producto) references productos(id_producto)
);

create table if not exists categorias_productos(
    id_categoria int not null, 
	id_producto int not null, 
    foreign key (id_promocion) references promociones(id_promocion),
    foreign key (id_producto) references productos(id_producto)
);

show tables