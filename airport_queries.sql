SELECT A.*, COUNT(*) AS CantidadEmpleados
FROM EmpleadoAerolinea EA
         INNER JOIN Aerolinea A ON EA.IdAerolinea = A.IdAerolinea
GROUP BY EA.IdAerolinea
ORDER BY CantidadEmpleados DESC
LIMIT 10;


SELECT A.*, COUNT(*) AS CantidadAerolineas
FROM AerolineaAeropuerto AA
         INNER JOIN Aeropuerto A ON AA.IdAeropuerto = A.IdAeropuerto
GROUP BY A.IdAeropuerto
ORDER BY CantidadAerolineas DESC
LIMIT 10;


SELECT F.Nombre, COUNT(*) AS Modelos
FROM Avion A
         INNER JOIN Fabricante F on A.IdFabricante = F.IdFabricante
GROUP BY A.IdFabricante
ORDER BY Modelos DESC
LIMIT 10;


SELECT A.Nombre, COUNT(*) AS Reparacion
FROM Avion
         INNER JOIN AvionAerolinea AA on Avion.IdAvion = AA.IdAvion
         INNER JOIN Aerolinea A on AA.IdAerolinea = A.IdAerolinea
GROUP BY A.IdAerolinea
ORDER BY Reparacion DESC;


SELECT B.IdBodega, COUNT(*) As AvionesInactivos
FROM Bodega B
         INNER JOIN AvionBodega AB on B.IdBodega = AB.IdBodega
         INNER JOIN Avion A on AB.IdAvion = A.IdAvion
WHERE A.Estado == 'Inactivo';


SELECT A.Nombre, AVG(ALL S.Salario), COUNT(*) AS Empleados
FROM EmpleadoAepuerto EA
         INNER JOIN Empleado E on EA.IdEmpleado = E.IdEmpleado
         INNER JOIN Salario S on E.IdEmpleado = S.IdEmpleado
         INNER JOIN Aeropuerto A on EA.IdAeropuerto = A.IdAeropuerto
GROUP BY A.IdAeropuerto
ORDER BY Empleados DESC;


SELECT Factura.CostoReparacion, A.Modelo, F.Nombre, A.Codigo, A2.Nombre, A3.Nombre
FROM Factura
         INNER JOIN Avion A on Factura.IdAvion = A.IdAvion
         INNER JOIN Fabricante F on A.IdFabricante = F.IdFabricante
         INNER JOIN AvionAerolinea AA on A.IdAvion = AA.IdAvion
         INNER JOIN Aerolinea A2 on AA.IdAerolinea = A2.IdAerolinea
         INNER JOIN AerolineaAeropuerto AA2 on A2.IdAerolinea = AA2.IdAerolinea
         INNER JOIN Aeropuerto A3 on AA2.IdAeropuerto = A3.IdAeropuerto

SELECT A.Nombre, AA.Fecha, COUNT(*)
FROM Aeropuerto A
         INNER JOIN AvionAeropuerto AA on A.IdAeropuerto = AA.IdAeropuerto
         INNER JOIN Avion A on AA.IdAvion = A.IdAvion
WHERE A.Estado == 'activo'



/*
SELECT EAerolinea.*
FROM Salario S
INNER JOIN Empleado E ON S.IdEmpleado = E.IdEmpleado
INNER JOIN EmpleadoAerolinea EAerolinea ON E.IdEmpleado = EAerolinea.IdEmpleado
ORDER BY S.Salario DESC
LIMIT 1;

SELECT EAeropuerto.*
FROM Salario S
INNER JOIN Empleado E ON S.IdEmpleado = E.IdEmpleado
INNER JOIN EmpleadoAepuerto EAeropuerto ON E.IdEmpleado = EAeropuerto.IdEmpleado
ORDER BY S.Salario DESC
LIMIT 1

INSERT INTO Empleado(IdEmpleado, Nombre, Apellido1, Apellido2, Cedula, CuentaBancaria, Horario, Direccion)
VALUES (1, 'NombreEmpleado1', 'Apellido1Empleado1', 'Apellido2Empleado1', 'CedulaEmpleado1', 'CuentaEmpleado1',
        'HorarioEmpleado1', 'DireccionEmpleado1'),
       (2, 'NombreEmpleado2', 'Apellido1Empleado2', 'Apellido2Empleado2', 'CedulaEmpleado2', 'CuentaEmpleado2',
        'HorarioEmpleado2', 'DireccionEmpleado2'),
       (3, 'NombreEmpleado3', 'Apellido1Empleado3', 'Apellido2Empleado3', 'CedulaEmpleado3', 'CuentaEmpleado3',
        'HorarioEmpleado3', 'DireccionEmpleado3'),
       (4, 'NombreEmpleado4', 'Apellido1Empleado4', 'Apellido2Empleado4', 'CedulaEmpleado4', 'CuentaEmpleado4',
        'HorarioEmpleado4', 'DireccionEmpleado4');


INSERT INTO Aerolinea(IdAerolinea, Codigo, Nombre)
VALUES (1, 'A1', 'NombreAerolinea1'),
       (2, 'A2', 'NombreAerolinea2'),
       (3, 'A3', 'NombreAerolinea3'),
       (4, 'A4', 'NombreAerolinea4');


INSERT INTO PuestoAerolinea(IdPuestoAerolinea, Nombre, SalarioBase)
VALUES (1, 'Piloto', '1000000'),
       (2, 'Copiloto', '500000'),
       (3, 'Azafata', '400000');


INSERT INTO EmpleadoAerolinea(IdEmpleado, IdAerolinea, IdPuestoAerolinea, Codigo)
VALUES (1, 1, 1, 'P1'),
       (2, 1, 2, 'C2'),
       (3, 2, 3, 'A3'),
       (4, 3, 1, 'P4');*/