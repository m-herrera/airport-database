import sqlite3 as lite
from random import *
from pydbgen import pydbgen

mult = 10
CantidadAerolineas = 2 * mult
CantidadAeropuertos = 4 * mult
CantidadFabricantes = 1 * mult
CantidadAerolineaAeropuerto = CantidadAerolineas * CantidadAeropuertos // 4
CantidadModelos = CantidadFabricantes * 2
CantidadAviones = 5 * mult
CantidadBodegas = 5 * mult
CantidadEmpleados = CantidadAerolineaAeropuerto
CantidadVuelos = CantidadAviones * 2
CantidadSalarios = CantidadEmpleados
CantidadPasajeros = CantidadVuelos * 200
CantidadTiquetes = CantidadVuelos * 100
CantidadEquipajes = CantidadTiquetes * 2
CantidadTalleres = CantidadBodegas
CantidadPasaportes = CantidadPasajeros * 2
CantidadPuestosAerolinea = 5
CantidadPuestosAeropuerto = 5
CantidadRepuestos = CantidadAviones
CantidadAvionAerolinea = CantidadAviones
CantidadAvionesBodega = CantidadAviones * 2
CantidadControladores = CantidadAviones * 1
CantidadEmpleadosAerolinea = CantidadEmpleados // 2
CantidadEmpleadosAeropuerto = CantidadEmpleados // 2
CantidadFacturas = CantidadAviones * 4
CantidadRepuestosFactura = CantidadRepuestos * CantidadFacturas
CantidadAvionesAeropuerto = CantidadAviones * CantidadAeropuertos


gen = pydbgen.pydb()
con = lite.connect("../Aeropuerto.sqlite3")
with con:
    cur = con.cursor()


    aerolineas = []
    companies = gen.gen_data_series(CantidadAerolineas, data_type='company')
    for i in range(1, CantidadAerolineas):
        name = companies[i-1]
        aerolineas.append((i,
                           name[:2].upper(),
                           name.capitalize()))

    cur.executemany("INSERT INTO Aerolinea VALUES(?, ?, ?)", aerolineas)


    aeropuertos = []
    places = gen.gen_data_series(CantidadAeropuertos, data_type='city')
    states = gen.gen_data_series(CantidadAeropuertos, data_type='state')
    phones = gen.gen_data_series(CantidadAeropuertos, data_type='phone_number_simple')
    for i in range(1, CantidadAeropuertos):
        name = places[i-1]
        aeropuertos.append((i,
                           name[:3].upper(),
                           name,
                           states[i-1],
                           phones[i-1],
                           "L-V " + randrange(6, 11).__str__() + "-" + randrange(2, 11).__str__()))

    cur.executemany("INSERT INTO Aeropuerto VALUES(?, ?, ?, ?, ?, ?)", aeropuertos)


    aerolineaAeropuerto = []
    for i in range(1, CantidadAerolineaAeropuerto):
        aerolineaAeropuerto.append((choice(aerolineas)[0],
                           choice(aeropuertos)[0]))

    cur.executemany("INSERT INTO AerolineaAeropuerto VALUES(?, ?)", aerolineaAeropuerto)


    fabricantes = []
    names = gen.gen_data_series(CantidadFabricantes, data_type='company')
    for i in range(1, CantidadFabricantes):
        name = names[i-1]
        fabricantes.append((i, name))
    cur.executemany("INSERT INTO Fabricante VALUES(?, ?)", fabricantes)


    estadosAvion = [(1, "Activo"), (2, "Inactivo"), (3, "Reparación")]
    cur.executemany("INSERT INTO EstadoAvion VALUES(?, ?)", estadosAvion)

    modelos = []
    models = gen.gen_data_series(CantidadModelos, data_type='license_plate')
    for i in range(1, CantidadModelos):
        modelos.append((i, choice(fabricantes)[0], models[i-1]))
    cur.executemany("INSERT INTO Modelo VALUES(?, ?, ?)", modelos)

    aviones = []
    names = gen.gen_data_series(CantidadAviones, data_type='company')
    for i in range(1, CantidadAviones):
        name = names[i-1]
        aviones.append((i, choice(modelos)[0],
                        randrange(1000, 10000),
                        randrange(3, 10),
                        randrange(40, 250),
                        choice(estadosAvion)[0]))
    cur.executemany("INSERT INTO Avion VALUES(?, ?, ?, ?, ?, ?)", aviones)
    


    bodegas = []
    names = gen.gen_data_series(CantidadEmpleados, data_type='name')
    for i in range(1, CantidadBodegas):
        bodegas.append((i, choice(aeropuertos)[0], names[i-1]))
    cur.executemany("INSERT INTO Bodega VALUES(?, ?, ?)", bodegas)


    empleados = []
    names = gen.gen_data_series(CantidadEmpleados, data_type='name')
    lname1 = gen.gen_data_series(CantidadEmpleados, data_type='name')
    lname2 = gen.gen_data_series(CantidadEmpleados, data_type='name')
    ssn = gen.gen_data_series(CantidadEmpleados, data_type='ssn')
    accounts = gen.gen_data_series(CantidadEmpleados, data_type='phone_number_full')
    addresses = gen.gen_data_series(CantidadEmpleados, data_type='street_address')
    for i in range(1, CantidadEmpleados):
        empleados.append((i, names[i-1], lname1[i-1], lname2[i-1], ssn[i-1], accounts[i-1],
                          "L-V " + randrange(6, 11).__str__() + "-" + randrange(2, 11).__str__(),
                            addresses[i-1]))
    cur.executemany("INSERT INTO Empleado VALUES(?, ?, ?, ?, ?, ?, ?, ?)", empleados)


    estadosVuelo = [(1, "Activo"), (2, "Retrasado"), (3, "Finalizado")]
    cur.executemany("INSERT INTO EstadoVuelo VALUES(?, ?)", estadosVuelo)


    vuelos = []
    fllegada = gen.gen_data_series(CantidadVuelos, data_type='date')
    hllegada = gen.gen_data_series(CantidadVuelos, data_type='time')
    fsalida = gen.gen_data_series(CantidadVuelos, data_type='date')
    hsalida = gen.gen_data_series(CantidadVuelos, data_type='time')
    for i in range(1, CantidadVuelos):
        vuelos.append((i, choice(aviones)[0], randrange(100, 1000),
                       choice(aeropuertos)[0], choice(aeropuertos)[0],
                       fllegada[i-1], hllegada[i-1],
                       fsalida[i-1], hsalida[i-1], choice(estadosVuelo)[0]))

    cur.executemany("INSERT INTO Vuelo VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", vuelos)


    salarios = []
    fechas = gen.gen_data_series(CantidadSalarios, data_type='date')
    for i in range(1, CantidadSalarios):
        salarios.append((i, empleados[i-1][0], fechas[i-1],
                       randrange(50000, 10000000)))

    cur.executemany("INSERT INTO Salario VALUES(?, ?, ?, ?)", salarios)


    pasajeros = []
    code = gen.gen_data_series(CantidadPasajeros, data_type='license_plate')
    names = gen.gen_data_series(CantidadPasajeros, data_type='name')
    lname1 = gen.gen_data_series(CantidadPasajeros, data_type='name')
    lname2 = gen.gen_data_series(CantidadPasajeros, data_type='name')
    ssn = gen.gen_data_series(CantidadPasajeros, data_type='ssn')
    phones = gen.gen_data_series(CantidadPasajeros, data_type='phone_number_simple')
    for i in range(1, CantidadPasajeros):
        pasajeros.append((i, code[i-1], names[i-1], lname1[i-1], lname2[i-1], ssn[i-1], phones[i-1]))
    cur.executemany("INSERT INTO Pasajero VALUES(?, ?, ?, ?, ?, ?, ?)", pasajeros)


    tiquetes = []
    for i in range(1, CantidadTiquetes):
        tiquetes.append((i, choice(pasajeros)[0], choice(vuelos)[0],
                       randrange(100000, 4000000)))

    cur.executemany("INSERT INTO Tiquete VALUES(?, ?, ?, ?)", tiquetes)


    equipajes = []
    for i in range(1, CantidadEquipajes):
        equipajes.append((i, choice(tiquetes)[0], randrange(0, 50),
                       randrange(20, 70)))

    cur.executemany("INSERT INTO Equipaje VALUES(?, ?, ?, ?)", equipajes)

    talleres = []
    companies = gen.gen_data_series(CantidadTalleres, data_type='company')
    for i in range(1, CantidadTalleres):
        talleres.append((i, choice(aeropuertos)[0], companies[i-1]))

    cur.executemany("INSERT INTO Taller VALUES(?, ?, ?)", talleres)


    pasaportes = []
    codes = gen.gen_data_series(CantidadPasaportes, data_type='license_plate')
    dates = gen.gen_data_series(CantidadPasaportes, data_type='date')
    for i in range(1, CantidadPasaportes):
        pasaportes.append((i, codes[i-1], dates[i-1], choice(pasajeros)[0]))

    cur.executemany("INSERT INTO Pasaporte VALUES(?, ?, ?, ?)", pasaportes)


    puestosaerolinea = [(1, "Piloto", randrange(3000000, 10000000)), (2, "Azafata", randrange(1000000, 40000000)),(3, "Copiloto", randrange(2000000, 8000000))]
    cur.executemany("INSERT INTO PuestoAerolinea VALUES(?, ?, ?)", puestosaerolinea)


    puestosaeropuerto = [
        (1, "Despachador de vuelos", randrange(500000, 1000000)),
        (2, "Técnico administrativo", randrange(1000000, 30000000)),
        (3, "Agente de servicios aeroportuarios", randrange(3000000, 5000000)),
        (4, "Auxiliar de tierra", randrange(400000, 900000))]
    cur.executemany("INSERT INTO PuestoAeropuerto VALUES(?, ?, ?)", puestosaeropuerto)


    repuestos = []
    codes = gen.gen_data_series(CantidadPasaportes, data_type='license_plate')
    descripciones = gen.gen_data_series(CantidadRepuestos,data_type='job_title')
    for i in range(1, CantidadRepuestos):
        repuestos.append((i, choice(fabricantes)[0], descripciones[i-1], codes[i-1]))

    cur.executemany("INSERT INTO Repuesto VALUES(?, ?, ?, ?)", repuestos)


    avionesaerolinea = []
    for i in range(1, CantidadAvionAerolinea):
        avionesaerolinea.append((aviones[i-1][0], choice(aerolineas)[0]))

    cur.executemany("INSERT INTO AvionAerolinea VALUES(?, ?)", avionesaerolinea)


    avionesbodega = []
    fllegada = gen.gen_data_series(CantidadAvionesBodega, data_type='date')
    hllegada = gen.gen_data_series(CantidadAvionesBodega, data_type='time')
    fsalida = gen.gen_data_series(CantidadAvionesBodega, data_type='date')
    hsalida = gen.gen_data_series(CantidadAvionesBodega, data_type='time')
    for i in range(1, CantidadAvionesBodega):
        avionesbodega.append((choice(aviones)[0], choice(bodegas)[0],
                       fllegada[i-1], hllegada[i-1],
                       fsalida[i-1], hsalida[i-1]))

    cur.executemany("INSERT INTO AvionBodega VALUES(?, ?, ?, ?, ?, ?)", avionesbodega)


    controladores = []
    latitudes = gen.gen_data_series(CantidadControladores, data_type='latitude')
    longitudes = gen.gen_data_series(CantidadControladores, data_type='longitude')
    for i in range(1, CantidadControladores):
        controladores.append((i, choice(aeropuertos)[0], choice(aviones)[0],
                       choice(vuelos)[0],
                              # "latitud", "longitud"))
                       str(latitudes[i-1]), str(longitudes[i-1])))

    cur.executemany("INSERT INTO ControladorVuelos VALUES(?, ?, ?, ?, ?, ?)", controladores)

    empleadosAerolinea = []
    dates = gen.gen_data_series(CantidadPasaportes, data_type='date')
    codes = gen.gen_data_series(CantidadEmpleadosAerolinea, data_type='license_plate')
    for i in range(1, CantidadEmpleadosAerolinea):
        empleadosAerolinea.append((empleados[i-1][0], choice(aerolineas)[0],
                       choice(puestosaerolinea)[0], codes[i-1], dates[i-1]))

    cur.executemany("INSERT INTO EmpleadoAerolinea VALUES(?, ?, ?, ?, ?)", empleadosAerolinea)


    empleadosAeropuerto = []
    dates = gen.gen_data_series(CantidadPasaportes, data_type='date')
    codes = gen.gen_data_series(CantidadEmpleadosAeropuerto, data_type='license_plate')
    for i in range(1, CantidadEmpleadosAeropuerto):
        empleadosAeropuerto.append((empleados[CantidadEmpleadosAerolinea + i - 1][0], choice(aeropuertos)[0],
                       choice(puestosaeropuerto)[0], codes[i-1], dates[i-1]))

    cur.executemany("INSERT INTO EmpleadoAeropuerto VALUES(?, ?, ?, ?, ?)", empleadosAeropuerto)


    facturas = []
    fllegada = gen.gen_data_series(CantidadFacturas, data_type='date')
    hllegada = gen.gen_data_series(CantidadFacturas, data_type='time')
    fsalida = gen.gen_data_series(CantidadFacturas, data_type='date')
    hsalida = gen.gen_data_series(CantidadFacturas, data_type='time')
    for i in range(1, CantidadFacturas):
        facturas.append((i, choice(talleres)[0], choice(aviones)[0],
                    randrange(100000, 10000000),
                    fllegada[i-1], hllegada[i-1],
                    fsalida[i-1], hsalida[i-1], "Estado"))

    cur.executemany("INSERT INTO Factura VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)", facturas)


    repuestosFactura = []
    codes = gen.gen_data_series(CantidadRepuestosFactura,
                                data_type='license_plate')
    for i in range(1, CantidadRepuestosFactura):
        repuestosFactura.append((choice(repuestos)[0],
                           choice(facturas)[0], codes[i-1]))

    cur.executemany("INSERT INTO RepuestoFactura VALUES(?, ?, ?)", repuestosFactura)











