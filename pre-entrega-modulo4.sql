

--Insertar las ventas

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta, monto) VALUES
    (6, 7, 1, '2026-10-28', 8999.00),
    (7, 7, 2, '2026-10-28', 17998.00),
    (9, 8, 1, '2026-10-28', 45000.00);
    
-- Rentabilidad por categoría nos sirve para obtener los productos que más se vendieron, para el caso definimos 1 unidad debido al set de datos 

SELECT
p.nombre,
SUM(v.cantidad) AS cantidad_total,
SUM(v.cantidad * p.precio) AS ingreso_total
FROM ventas AS v
INNER JOIN productos AS p
ON v.id_producto = p.id_producto
GROUP BY p.nombre
HAVING SUM(v.cantidad) > 1;

-- Clientes sin compras nos permite reconectarnos con clientes que alguna vez nos eligieron
SELECT 
clientes.nombre, 
COALESCE(ventas.cantidad, 0) AS cantidad
FROM clientes
LEFT JOIN ventas
ON clientes.id_cliente = ventas.id_cliente
WHERE ventas.id_venta IS NULL;

-- Con esta consulta obtenemos las últimas compras de nuestros mejores clientes para poder fidelizarlos

SELECT 
c.nombre AS cliente,
(
SELECT p2.nombre
FROM ventas AS v2
INNER JOIN productos AS p2 
ON v2.id_producto = p2.id_producto
WHERE v2.id_cliente = c.id_cliente
GROUP BY p2.id_producto, p2.nombre
ORDER BY COUNT(*) DESC
LIMIT 1
) AS producto_preferido,
MAX(v.fecha_venta) AS ultima_compra
FROM clientes AS c
INNER JOIN ventas AS v 
ON c.id_cliente = v.id_cliente
INNER JOIN productos AS p 
ON v.id_producto = p.id_producto
GROUP BY c.id_cliente, c.nombre;

