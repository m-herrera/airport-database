CREATE TABLE Aerolinea
(
    IdAerolinea INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Codigo      TEXT    NOT NULL,
    Nombre      TEXT    NOT NULL
    -- Cantidad de Empleados
);


CREATE TABLE Aeropuerto
(
    IdAeropuerto INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Codigo       TEXT    NOT NULL,
    Nombre       TEXT    NOT NULL,
    Localizacion TEXT    NOT NULL,
    Telefono     TEXT    NOT NULL,
    Horario      TEXT    NOT NULL
);


CREATE TABLE Avion
(
    IdAvion              INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdFabricante         INTEGER NOT NULL,
    Codigo               TEXT    NOT NULL,
    Modelo               TEXT    NOT NULL,
    CapacidadTripulacion INTEGER NOT NULL,
    CapacidadItinerario  INTEGER NOT NULL,
    Estado               TEXT    NOT NULL,
    FOREIGN KEY (IdFabricante) REFERENCES Fabricante (IdFabricante)
);


CREATE TABLE Bodega
(
    IdBodega     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAeropuerto INTEGER NOT NULL,
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto)
);


CREATE TABLE Empleado
(
    IdEmpleado     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre         TEXT    NOT NULL,
    Apellido1      TEXT    NOT NULL,
    Apellido2      TEXT    NOT NULL,
    Cedula         TEXT    NOT NULL,
    CuentaBancaria TEXT    NOT NULL,
    Horario        TEXT    NOT NULL,
    Direccion      TEXT    NOT NULL
);

CREATE TABLE Fabricante
(
    IdFabricante INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre       TEXT    NOT NULL
);


CREATE TABLE Equipaje
(
    IdEquipaje  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdTiquete   INTEGER NOT NULL,
    Peso        INTEGER NOT NULL,
    Dimensiones TEXT    NOT NULL,
    FOREIGN KEY (IdTiquete) REFERENCES Tiquete (IdTiquete)
);


CREATE TABLE Taller
(
    IdTaller     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAeropuerto INTEGER NOT NULL,
    Nombre       TEXT    NOT NULL,
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto)
);


CREATE TABLE Pasajero
(
    IdPasajero INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Codigo     TEXT    NOT NULL,
    Nombre     TEXT    NOT NULL,
    Apellido1  TEXT    NOT NULL,
    Apellido2  TEXT    NOT NULL,
    Cedula     TEXT    NOT NULL,
    Telefono   TEXT    NOT NULL
);


CREATE TABLE Pasaporte
(
    IdPasaporte      INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Codigo           TEXT    NOT NULL,
    FechaVencimiento DATE    NOT NULL
);


CREATE TABLE PuestoAerolinea
(
    IdPuestoAerolinea INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre            TEXT    NOT NULL,
    SalarioBase       INTEGER NOT NULL
);


CREATE TABLE PuestoAeropuerto
(
    IdPuestoAeropuerto INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre             TEXT    NOT NULL,
    SalarioBase        INTEGER NOT NULL
);


CREATE TABLE Repuesto
(
    IdRepuesto   INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdFabricante INTEGER NOT NULL,
    Descripcion  TEXT    NOT NULL,
    Codigo       TEXT    NOT NULL,
    FOREIGN KEY (IdFabricante) REFERENCES Fabricante (IdFabricante)
);


CREATE TABLE Salario
(
    IdSalario  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdEmpleado INTEGER NOT NULL,
    Fecha      DATE    NOT NULL,
    Salario    INTEGER NOT NULL,
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);



CREATE TABLE Vuelo
(
    IdVuelo      INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAvion      INTEGER NOT NULL,
    Numero       TEXT    NOT NULL,
    Destino      TEXT    NOT NULL,
    Origen       TEXT    NOT NULL,
    FechaLlegada DATE    NOT NULL,
    HoraLlegada  TIME    NOT NULL,
    FechaSalida  DATE    NOT NULL,
    HoraSalida   TIME    NOT NULL,
    Estado       TEXT    NOT NULL,
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion)
);


-- Relacion de Entidades


CREATE TABLE AerolineaAeropuerto
(
    IdAerolinea  INTEGER NOT NULL,
    IdAeropuerto INTEGER NOT NULL,
    FOREIGN KEY (IdAerolinea) REFERENCES Aerolinea (IdAerolinea),
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto)
);


CREATE TABLE AvionAerolinea
(
    IdAvion     INTEGER NOT NULL,
    IdAerolinea INTEGER NOT NULL,
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion),
    FOREIGN KEY (IdAerolinea) REFERENCES Aerolinea (IdAerolinea)
);


CREATE TABLE AvionAeropuerto
(
    IdAvion      INTEGER NOT NULL,
    IdAeropuerto INTEGER NOT NULL,
    Fecha        DATE    NOT NULL,
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion),
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto)
);


CREATE TABLE AvionBodega
(
    IdAvion      INTEGER NOT NULL,
    IdBodega     INTEGER NOT NULL,
    FechaIngreso DATE    NOT NULL,
    HoraIngreso  TIME    NOT NULL,
    FechaSalida  DATE    NOT NULL,
    HoraSalida   TIME    NOT NULL,
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion),
    FOREIGN KEY (IdBodega) REFERENCES Bodega (IdBodega)
);


CREATE TABLE ControladorVuelos
(
    IdControladorVuelos INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAeropuerto        INTEGER NOT NULL,
    IdAvion             INTEGER NOT NULL,
    IdVuelo             INTEGER NOT NULL,
    Latitud             TEXT    NOT NULL,
    Longitud            TEXT    NOT NULL,
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto),
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion),
    FOREIGN KEY (IdVuelo) REFERENCES Vuelo (IdVuelo)
);


CREATE TABLE EmpleadoAerolinea
(
    IdEmpleado        INTEGER NOT NULL,
    IdAerolinea       INTEGER NOT NULL,
    IdPuestoAerolinea INTEGER NOT NULL,
    Codigo            TEXT    NOT NULL,
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado),
    FOREIGN KEY (IdAerolinea) REFERENCES Aerolinea (IdAerolinea),
    FOREIGN KEY (IdPuestoAerolinea) REFERENCES PuestoAerolinea (IdPuestoAerolinea)
);

CREATE TABLE EmpleadoAeropuerto
(
    IdEmpleado         INTEGER NOT NULL,
    IdAeropuerto       INTEGER NOT NULL,
    IdPuestoAeropuerto INTEGER NOT NULL,
    Codigo             TEXT    NOT NULL,
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado),
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto),
    FOREIGN KEY (IdPuestoAeropuerto) REFERENCES PuestoAeropuerto (IdPuestoAeropuerto)
);


CREATE TABLE Factura
(
    IdFactura       INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdTaller        INTEGER NOT NULL,
    IdAvion         INTEGER NOT NULL,
    CostoReparacion TEXT    NOT NULL,
    FechaLlegada    DATE    NOT NULL,
    HoraLlegada     TIME    NOT NULL,
    FechaSalida     DATE    NOT NULL,
    HoraSalida      TIME    NOT NULL,
    Estado          TEXT    NOT NULL,
    FOREIGN KEY (IdTaller) REFERENCES Taller (IdTaller),
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion)

);


CREATE TABLE PasajeroPasaporte
(
    IdPasajero  INTEGER NOT NULL,
    IdPasaporte INTEGER NOT NULL,
    FOREIGN KEY (IdPasajero) REFERENCES Pasajero (IdPasajero),
    FOREIGN KEY (IdPasaporte) REFERENCES Pasaporte (IdPasaporte)
);


CREATE TABLE RepuestoFactura
(
    IdRepuesto INTEGER NOT NULL,
    IdFactura  INTEGER NOT NULL,
    Codigo     TEXT    NOT NULL,
    FOREIGN KEY (IdRepuesto) REFERENCES Repuesto (IdRepuesto),
    FOREIGN KEY (IdFactura) REFERENCES Factura (IdFactura)
);


CREATE TABLE Tiquete
(
    IdTiquete  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdPasajero INTEGER NOT NULL,
    IdVuelo    INTEGER NOT NULL,
    Precio     TEXT    NOT NULL,
    -- Cantidad Equipaje
    FOREIGN KEY (IdPasajero) REFERENCES Pasajero (IdPasajero),
    FOREIGN KEY (IdVuelo) REFERENCES Vuelo (IdVuelo)

);