-- =========================================================
-- Pre-entrega Módulo 2: Tablas Principales con Restricciones
-- y Datos Iniciales — Proyecto Retail
-- Autor: Carlos Ramos Diaz
-- =========================================================


--Creación de la base de datos


create database retail_project;
create schema retail_project;

-- Creación de tablas principales con resticciones DDL

CREATE TABLE clientes (
    id_cliente   SERIAL PRIMARY KEY,
    nombre       VARCHAR(100) NOT NULL,
    email        VARCHAR(150) NOT NULL UNIQUE,
    telefono	 VARCHAR (10) NOT NULL,
    id_edad      INT NOT null
);

CREATE TABLE productos (
    id_producto  SERIAL PRIMARY KEY,
    nombre       VARCHAR(100) NOT NULL,
    categoria    VARCHAR(50)  NOT NULL,
    precio       DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock        INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0)
);

CREATE TABLE ventas (
    id_venta     SERIAL PRIMARY KEY,
    id_cliente   INTEGER NOT NULL REFERENCES clientes(id_cliente),
    id_producto  INTEGER NOT NULL REFERENCES productos(id_producto),
    cantidad     INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_venta  DATE NOT NULL DEFAULT CURRENT_DATE,
    monto        DECIMAL(10,2) NOT NULL CHECK (monto > 0)
);

-- Inserción de datos DML 

BEGIN;

INSERT INTO clientes (nombre, email, telefono, id_edad) VALUES
    ('Lion Mess',        'lion@coderhouse.com',    '49425842', '49'),
    ('Emi Martin',       'emiliano@coderhouse.com', '49425843', '45'),
    ('Nicolás Taglia',   'nicoelpico@coderhouse.com', '49425844', '42'),
    ('Enzi Fern',        'enzo.ocho@coderhouse.com', '49425845', '40'),
    ('Juli Alvar',     'spider@coderhouse.com', '49425846', '39');

INSERT INTO productos (nombre, categoria, precio, stock) VALUES
    ('Auriculares Bluetooth', 'Electrónica', 25999.00, 40),
    ('Mouse Inalámbrico',     'Electrónica', 8999.00,  75),
    ('Zapatillas Running',    'Indumentaria', 45000.00, 30),
    ('Campera Impermeable',   'Indumentaria', 62000.00, 15),
    ('Termo 1L Acero',        'Hogar',        18500.00, 60);

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta, monto) VALUES
    (1, 1, 1, '2026-10-26', 25999.00),
    (2, 3, 2, '2026-10-26', 90000.00),
    (3, 5, 1, '2026-10-26', 18500.00),
    (4, 2, 3, '2026-10-26', 26997.00),
    (5, 4, 1, '2026-10-26', 62000.00);

COMMIT;

-- Mantenimiento UPDATE/ DELETE DML

update productos set categoria = 'Hogar y jardin'
where categoria = 'Hogar'

delete from ventas 
where id_venta = '5'

select * from clientes





