USE empresa2;

CREATE TABLE empleados (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
puesto VARCHAR(50),
salario DECIMAL(10,2),
fecha_contratacion DATE
);

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    direccion TEXT
);

CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_p varchar(100) NOT NULL,
    valor varchar(100),
    codigo varchar(5),
    tipo_p varchar(100)
);
    
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha_venta DATE,
    total DECIMAL(10,3),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

CREATE TABLE departamentos (
id int auto_increment primary key,
nombre varchar (50) not null
);

CREATE TABLE empleado_departamento (
empleado_id int,
departamento_id int,
primary key (empleado_id, departamento_id),
foreign key (empleado_id) references empleados(id),
foreign key (departamento_id) references departamentos(id)
);

insert into departamentos (nombre) values ('Ventas');
insert into departamentos (nombre) values ('Finanzas');
insert into departamentos (nombre) values ('IT');

insert into empleados (nombre,puesto,salario,fecha_contratacion) values ('luis','gerente','7','2003-05-07');
insert into empleados (nombre,puesto,salario,fecha_contratacion) values ('juan david','asesor','4','2015-12-11');
insert into empleados (nombre,puesto,salario,fecha_contratacion) values ('mateo','jefe','10','2000-01-25');
insert into empleados (nombre,puesto,salario,fecha_contratacion) values ('Estefania','Asesora','4','2017-05-15');
insert into empleados (nombre,puesto,salario,fecha_contratacion) values ('Esteban','Cajero','5','2016-06-30');

insert into empleado_departamento (empleado_id, departamento_id) values (1,1);
insert into empleado_departamento (empleado_id, departamento_id) values (2,3);
insert into empleado_departamento (empleado_id, departamento_id) values (3,2);
insert into empleado_departamento (empleado_id, departamento_id) values (4,1);
insert into empleado_departamento (empleado_id, departamento_id) values (5,1);

/*Frutas y verduras*/
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Tomate','4000','10001','Frutas y verduras');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Papa','7500','10002','Frutas y verduras');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Cebolla','3500','10003','Frutas y verduras');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Sandia','6800','10004','Frutas y verduras');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Manzana','5000','10005','Frutas y verduras');

/*Carnes frias*/
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Salchichas','11500','20001','Carnes frias');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Salchicon','8000','20002','Carnes frias');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Morcilla','9500','20003','Carnes frias');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Chorizos','12000','20004','Carnes frias');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Butifarra','7500','20005','Carnes frias');

/*Bebidas*/
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Cocacola','3000','30001','Bebidas');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Agua','1500','30002','Bebidas');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Jugo','4200','30003','Bebidas');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Leche','3700','30004','Bebidas');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Yogurt','2900','30005','Bebidas');

/*Panaderia*/
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Pan tajado','13800','40001','Panaderia');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Galletas','17200','40002','Panaderia');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Tostadas','8900','40003','Panaderia');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Pan de queso','6100','40004','Panaderia');
insert into productos(nombre_p,valor,codigo,tipo_p) values ('Pan de yuca','8500','40005','Panaderia');

INSERT INTO clientes (nombre, apellido, email, telefono, direccion) VALUES ('Juan', 'Pérez', 'juanperez@example.com', '555-1234', 'Calle Falsa 123');
INSERT INTO clientes (nombre, apellido, email, telefono, direccion) VALUES ('María', 'Rodríguez', 'maria@gmail.com', '555-5678', 'Avenida Principal 456');
INSERT INTO clientes (nombre, apellido, email, telefono, direccion) VALUES ('Pedro', 'García', 'pedro@hotmail.com', '555-9012', 'Calle Secundaria 789');

INSERT INTO ventas (id_cliente, fecha_venta, total) VALUES (1, '2023-11-22', '85000');
INSERT INTO ventas (id_cliente, fecha_venta, total) VALUES (2, '2023-12-05', '32700');
INSERT INTO ventas (id_cliente, fecha_venta, total) VALUES  (1, '2024-05-10', '25000');


  
select * from empleados;
select * from departamentos;
select * from clientes;
select * from ventas;
select * from productos;

select e.nombre as empleado, d.nombre as departamento
from empleados e
join empleados_departamento ed on e.id = ed.empleado_id
join departamentos d on ed.departamento_id =d.id;

UPDATE empleados
SET salario= 3200
WHERE nombre = 'Luis';

UPDATE empleados
SET salario= 3200
WHERE puesto = 'asesor';

/*Mostrar los empleados contratados después de una fecha determinada:*/
SELECT * FROM empleados WHERE fecha_contratacion > '2010-01-01';

/*Contar cuántos empleados hay por departamento:*/
SELECT d.nombre, COUNT(*) AS num_empleados
FROM departamentos d
JOIN empleado_departamento ed ON d.id = ed.departamento_id
GROUP BY d.nombre;

/*Encontrar empleados con un salario entre cierto rango:*/
SELECT * FROM empleados WHERE salario BETWEEN 2 AND 7;

/*Total de gastos de un cliente*/
SELECT c.nombre, c.apellido, SUM(CONVERT(v.total, DECIMAL(10,2))) AS total_ventas
FROM clientes c
JOIN ventas v ON c.id = v.id_cliente
GROUP BY c.nombre, c.apellido
ORDER BY total_ventas DESC;

/*Ventas hechan en los ultimos 6 meses*/
SELECT c.nombre, c.apellido, c.email, c.telefono
FROM clientes c
JOIN ventas v ON c.id = v.id_cliente
WHERE v.fecha_venta >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.id;

/*Productos que cuesten mas de 10000*/
SELECT * FROM productos WHERE valor > 10000;

/*Productos entre 5000 y 10000*/
SELECT * FROM productos WHERE valor BETWEEN 5000 AND 10000;

/*Cuantos productos hay por cada tipo*/
SELECT tipo_p, COUNT(*) AS num_productos
FROM productos
GROUP BY tipo_p;

/*Numero de empleados por puesto*/
SELECT puesto, COUNT(*) AS num_empleados
FROM empleados
GROUP BY puesto;


