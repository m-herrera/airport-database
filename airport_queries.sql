-- Top 10 aerolíneas con mayor cantidad de empleados
SELECT Aerolinea.*, COUNT(*) AS CantidadEmpleados
FROM EmpleadoAerolinea
         INNER JOIN Aerolinea ON EmpleadoAerolinea.IdAerolinea = Aerolinea.IdAerolinea
GROUP BY EmpleadoAerolinea.IdAerolinea
ORDER BY CantidadEmpleados DESC
LIMIT 10;


-- Top 10 aeropuertos con más aerolíneas
SELECT Aeropuerto.*, COUNT(*) AS CantidadAerolineas
FROM AerolineaAeropuerto
         INNER JOIN Aeropuerto ON AerolineaAeropuerto.IdAeropuerto = Aeropuerto.IdAeropuerto
GROUP BY Aeropuerto.IdAeropuerto
ORDER BY CantidadAerolineas DESC
LIMIT 10;


-- Toda la información de un empleado de la aerolínea y del aeropuerto con el sueldo más alto
SELECT *
FROM (
         SELECT Empleado.*, Salario.Salario
         FROM EmpleadoAerolinea
                  INNER JOIN Empleado ON EmpleadoAerolinea.IdEmpleado = Empleado.IdEmpleado
                  INNER JOIN Salario ON Empleado.IdEmpleado = Salario.IdEmpleado
         ORDER BY Salario.Salario DESC
         LIMIT 1
     )
UNION
SELECT *
FROM (
         SELECT E.*, S.Salario
         FROM EmpleadoAeropuerto
                  INNER JOIN Empleado E ON EmpleadoAeropuerto.IdEmpleado = E.IdEmpleado
                  INNER JOIN Salario S ON E.IdEmpleado = S.IdEmpleado
         ORDER BY S.Salario DESC
         LIMIT 1);


-- Promedio de salario para los aeropuertos con mayor numero de empleados
SELECT Aeropuerto.Nombre, AVG(ALL Salario.Salario), COUNT(*) AS Empleados
FROM EmpleadoAeropuerto
         INNER JOIN Empleado ON EmpleadoAeropuerto.IdEmpleado = Empleado.IdEmpleado
         INNER JOIN Salario ON Empleado.IdEmpleado = Salario.IdEmpleado
         INNER JOIN Aeropuerto ON EmpleadoAeropuerto.IdAeropuerto = Aeropuerto.IdAeropuerto
GROUP BY Aeropuerto.IdAeropuerto
ORDER BY Empleados DESC
LIMIT 3;


-- Cantidad de aviones en una aerolínea que están en estado de reparacion
SELECT Aerolinea.Nombre, COUNT(*) AS Reparacion
FROM Avion
         INNER JOIN AvionAerolinea ON Avion.IdAvion = AvionAerolinea.IdAvion
         INNER JOIN Aerolinea ON AvionAerolinea.IdAerolinea = Aerolinea.IdAerolinea
WHERE Avion.IdEstadoAvion == 3
  AND Aerolinea.Nombre == 'Graves-johnson'
GROUP BY Aerolinea.IdAerolinea
ORDER BY Reparacion DESC;


-- Costo de reparación, modelo, fabricante y código de avión para una aerolínea de un aeropuerto específico
SELECT Factura.CostoReparacion,
       Avion.IdModelo,
       Fabricante.Nombre AS NombreFabricante,
       Avion.Codigo
FROM Factura
         INNER JOIN Avion ON Factura.IdAvion = Avion.IdAvion
         INNER JOIN Modelo ON Avion.IdModelo = Modelo.IdModelo
         INNER JOIN Fabricante ON Modelo.IdFabricante = Fabricante.IdFabricante
         INNER JOIN AvionAerolinea ON Avion.IdAvion = AvionAerolinea.IdAvion
         INNER JOIN Aerolinea ON AvionAerolinea.IdAerolinea = Aerolinea.IdAerolinea
         INNER JOIN AerolineaAeropuerto ON Aerolinea.IdAerolinea = AerolineaAeropuerto.IdAerolinea
         INNER JOIN Aeropuerto ON AerolineaAeropuerto.IdAeropuerto = Aeropuerto.IdAeropuerto
WHERE Aerolinea.Nombre == 'Graves-johnson'
  AND Aeropuerto.Nombre == 'Morganland';


--  Cantidad de aviones activos en un aeropuerto
SELECT Aeropuerto.Nombre, Vuelo.FechaLlegada, COUNT(*) AS AvionesActivos
FROM Aeropuerto
         INNER JOIN Vuelo ON Aeropuerto.IdAeropuerto = Vuelo.IdAeropuertoDestino
         INNER JOIN Avion ON Vuelo.IdAvion = Avion.IdAvion
WHERE Avion.IdEstadoAvion == 1
  AND Aeropuerto.Nombre == 'Ashleymouth'
  AND FechaLlegada == '1989-11-04'
GROUP BY Vuelo.FechaLlegada, Aeropuerto.Nombre;


-- Promedio de costo de reparación de los aviones para un aeropuerto específico
SELECT Aeropuerto.Nombre, AVG(ALL Factura.CostoReparacion) AS PromedioReparacion
FROM Aeropuerto
         INNER JOIN Taller ON Aeropuerto.IdAeropuerto = Taller.IdAeropuerto
         INNER JOIN Factura ON Taller.IdTaller = Factura.IdTaller
WHERE Aeropuerto.Nombre == 'Ashleymouth';

-- Promedio de costo de reparación de los aviones para una aerolinea específico
SELECT Aerolinea.Nombre, AVG(ALL Factura.CostoReparacion) AS PromedioReparacion
FROM Aerolinea
         INNER JOIN AvionAerolinea on Aerolinea.IdAerolinea = AvionAerolinea.IdAerolinea
         INNER JOIN Avion ON AvionAerolinea.IdAvion = Avion.IdAvion
         INNER JOIN Factura ON Factura.IdAvion = Avion.IdAvion
WHERE Aerolinea.Nombre == 'Graves-johnson';


-- Cantidad de aviones inactivos dentro de una bodega
SELECT Bodega.Nombre, COUNT(*) As AvionesInactivos
FROM Bodega
         INNER JOIN AvionBodega ON Bodega.IdBodega = AvionBodega.IdBodega
         INNER JOIN Avion ON AvionBodega.IdAvion = Avion.IdAvion
WHERE Avion.IdEstadoAvion == 2
  AND Bodega.Nombre == 'Tiffany York';


-- Nombre de los fabricantes con la mayor cantidad de modelos
SELECT Fabricante.Nombre, COUNT(*) AS Modelos
FROM Modelo
         INNER JOIN Fabricante ON Modelo.IdFabricante = Fabricante.IdFabricante
GROUP BY Modelo.IdFabricante
ORDER BY Modelos DESC
LIMIT 3;


-- Cantidad de aerolíneas que contienen la letra "A" en el nombre. De este resultado además deben de mostrar cuáles tienen más vuelos activos
SELECT *
FROM (SELECT A.*, COUNT(*) AS VuelosActivos
      FROM Aerolinea A
               INNER JOIN AvionAerolinea AA on A.IdAerolinea = AA.IdAerolinea
               INNER JOIN Vuelo V on AA.IdAvion = V.IdAvion
      WHERE V.IdEstadoVuelo == 1
      GROUP BY A.IdAerolinea
      ORDER BY VuelosActivos DESC) AA
WHERE AA.Nombre LIKE '%a%';

-- Intervalo de horas con la mayor llegada de aviones para un aeropuerto
SELECT (strftime('%H', V.HoraLlegada)) AS Hora, Count(*) AS Vuelos
FROM Vuelo V
         INNER JOIN Aeropuerto A on V.IdAeropuertoOrigen = A.IdAeropuerto
WHERE A.Nombre == 'Ashleymouth'
GROUP BY Hora;
