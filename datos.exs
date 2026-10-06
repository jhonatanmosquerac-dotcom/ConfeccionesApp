defmodule Datos do
  def confeccionistas do
  [

    %{codigo: "C01", nombre: "Maria Elena Rios", alquiler: true},
    %{codigo: "C02", nombre: "Andres Salazar", alquiler: false},
    %{codigo: "C03", nombre: "Maria Alejandra", alquiler: true},
    %{codigo: "C04", nombre: "Miguel Arias", alquiler: false},
    %{codigo: "C05", nombre: "Nicolas Alvarez", alquiler: true},
    %{codigo: "C06", nombre: "Sara Valencia", alquiler: false},
    %{codigo: "C07", nombre: "Isabella Rios", alquiler: true},
    %{codigo: "C08", nombre: "Luisa Hernandez", alquiler: false},
    %{codigo: "C09", nombre: "Sofia Reyes", alquiler: true},
    %{codigo: "C10", nombre: "Yeilin Benavidez", alquiler: false}

  ]
  end

  def lineas do
  [
    %{id: "L1", nombre: "Linea Norte", puestos: 6},
    %{id: "L2", nombre: "Linea Central", puestos: 4},
    %{id: "L3", nombre: "Linea Sur", puestos: 7},
    %{id: "L4", nombre: "Linea Oeste", puestos: 5}

  ]
  end

  def lotes do
  [

    %{confeccionista: "C50", linea: "L1", dia: 1, prendas: 70, defectos: 1.5},
    %{confeccionista: "C5", linea: "L2", dia: 2, prendas: 55, defectos: 7},
    %{confeccionista: "C01", linea: "L5", dia: 3, prendas: 55, defectos: 7},
    %{confeccionista: "C01", linea: "L9", dia: 4, prendas: 55, defectos: 7},
    %{confeccionista: "C01", linea: "L2", dia: 0, prendas: 55, defectos: 7},
    %{confeccionista: "C01", linea: "L2", dia: 11, prendas: 55, defectos: 7},
    %{confeccionista: "C01", linea: "L2", dia: 5, prendas: 55.4, defectos: 7},
    %{confeccionista: "C01", linea: "L2", dia: 6, prendas: 180, defectos: 7},
    %{confeccionista: "C01", linea: "L2", dia: 1, prendas: 55, defectos: 101},
    %{confeccionista: "C01", linea: "L2", dia: 2, prendas: 55, defectos: -1},

    %{confeccionista: "C01", linea: "L2", dia: 1, prendas: 55, defectos: 1.5},
    %{confeccionista: "C01", linea: "L1", dia: 1, prendas: 60, defectos: 3.2},
    %{confeccionista: "C01", linea: "L3", dia: 2, prendas: 75, defectos: 5.8},
    %{confeccionista: "C01", linea: "L4", dia: 2, prendas: 45, defectos: 2.4},
    %{confeccionista: "C01", linea: "L2", dia: 3, prendas: 120, defectos: 8.7},
    %{confeccionista: "C01", linea: "L1", dia: 4, prendas: 90, defectos: 4.1},
    %{confeccionista: "C01", linea: "L3", dia: 5, prendas: 150, defectos: 12.5},
    %{confeccionista: "C01", linea: "L4", dia: 6, prendas: 80, defectos: 6.3},

    %{confeccionista: "C02", linea: "L1", dia: 1, prendas: 70, defectos: 4.6},
    %{confeccionista: "C02", linea: "L3", dia: 1, prendas: 50, defectos: 2.8},
    %{confeccionista: "C02", linea: "L2", dia: 2, prendas: 65, defectos: 7.3},
    %{confeccionista: "C02", linea: "L4", dia: 2, prendas: 55, defectos: 9.1},
    %{confeccionista: "C02", linea: "L1", dia: 3, prendas: 100, defectos: 3.5},
    %{confeccionista: "C02", linea: "L2", dia: 4, prendas: 175, defectos: 15.7},
    %{confeccionista: "C02", linea: "L3", dia: 5, prendas: 130, defectos: 11.2},
    %{confeccionista: "C02", linea: "L4", dia: 6, prendas: 95, defectos: 5.9},

    %{confeccionista: "C03", linea: "L4", dia: 1, prendas: 40, defectos: 6.4},
    %{confeccionista: "C03", linea: "L2", dia: 1, prendas: 85, defectos: 8.2},
    %{confeccionista: "C03", linea: "L1", dia: 2, prendas: 90, defectos: 3.7},
    %{confeccionista: "C03", linea: "L3", dia: 2, prendas: 70, defectos: 5.5},
    %{confeccionista: "C03", linea: "L4", dia: 3, prendas: 160, defectos: 14.8},
    %{confeccionista: "C03", linea: "L1", dia: 4, prendas: 110, defectos: 7.6},
    %{confeccionista: "C03", linea: "L2", dia: 5, prendas: 75, defectos: 2.9},
    %{confeccionista: "C03", linea: "L3", dia: 6, prendas: 145, defectos: 18.3},

    %{confeccionista: "C04", linea: "L3", dia: 1, prendas: 80, defectos: 9.4},
    %{confeccionista: "C04", linea: "L1", dia: 1, prendas: 65, defectos: 4.3},
    %{confeccionista: "C04", linea: "L4", dia: 2, prendas: 50, defectos: 6.7},
    %{confeccionista: "C04", linea: "L2", dia: 2, prendas: 100, defectos: 12.6},
    %{confeccionista: "C04", linea: "L3", dia: 3, prendas: 135, defectos: 8.5},
    %{confeccionista: "C04", linea: "L1", dia: 4, prendas: 60, defectos: 3.1},
    %{confeccionista: "C04", linea: "L4", dia: 5, prendas: 170, defectos: 21.4},
    %{confeccionista: "C04", linea: "L2", dia: 6, prendas: 115, defectos: 10.8},

    %{confeccionista: "C05", linea: "L2", dia: 1, prendas: 95, defectos: 7.2},
    %{confeccionista: "C05", linea: "L4", dia: 1, prendas: 65, defectos: 5.6},
    %{confeccionista: "C05", linea: "L1", dia: 2, prendas: 80, defectos: 11.3},
    %{confeccionista: "C05", linea: "L3", dia: 2, prendas: 70, defectos: 8.9},
    %{confeccionista: "C05", linea: "L2", dia: 3, prendas: 145, defectos: 16.2},
    %{confeccionista: "C05", linea: "L4", dia: 4, prendas: 105, defectos: 9.7},
    %{confeccionista: "C05", linea: "L1", dia: 5, prendas: 180, defectos: 25.5},
    %{confeccionista: "C05", linea: "L3", dia: 6, prendas: 125, defectos: 13.4},

    %{confeccionista: "C06", linea: "L1", dia: 1, prendas: 45, defectos: 2.6},
    %{confeccionista: "C06", linea: "L4", dia: 1, prendas: 90, defectos: 10.5},
    %{confeccionista: "C06", linea: "L3", dia: 2, prendas: 75, defectos: 6.8},
    %{confeccionista: "C06", linea: "L2", dia: 2, prendas: 85, defectos: 12.1},
    %{confeccionista: "C06", linea: "L1", dia: 3, prendas: 155, defectos: 19.6},
    %{confeccionista: "C06", linea: "L4", dia: 4, prendas: 100, defectos: 7.4},
    %{confeccionista: "C06", linea: "L2", dia: 5, prendas: 135, defectos: 15.3},
    %{confeccionista: "C06", linea: "L3", dia: 6, prendas: 70, defectos: 4.8},

    %{confeccionista: "C07", linea: "L3", dia: 1, prendas: 55, defectos: 3.9},
    %{confeccionista: "C07", linea: "L2", dia: 1, prendas: 100, defectos: 14.7},
    %{confeccionista: "C07", linea: "L4", dia: 2, prendas: 60, defectos: 5.2},
    %{confeccionista: "C07", linea: "L1", dia: 2, prendas: 110, defectos: 17.8},
    %{confeccionista: "C07", linea: "L3", dia: 3, prendas: 175, defectos: 22.3},
    %{confeccionista: "C07", linea: "L2", dia: 4, prendas: 85, defectos: 8.6},
    %{confeccionista: "C07", linea: "L1", dia: 5, prendas: 140, defectos: 11.9},
    %{confeccionista: "C07", linea: "L4", dia: 6, prendas: 160, defectos: 27.5},

    %{confeccionista: "C08", linea: "L4", dia: 1, prendas: 70, defectos: 6.1},
    %{confeccionista: "C08", linea: "L1", dia: 1, prendas: 95, defectos: 13.8},
    %{confeccionista: "C08", linea: "L2", dia: 2, prendas: 55, defectos: 4.5},
    %{confeccionista: "C08", linea: "L3", dia: 2, prendas: 90, defectos: 9.3},
    %{confeccionista: "C08", linea: "L4", dia: 3, prendas: 130, defectos: 16.7},
    %{confeccionista: "C08", linea: "L1", dia: 4, prendas: 150, defectos: 20.2},
    %{confeccionista: "C08", linea: "L2", dia: 5, prendas: 115, defectos: 7.8},
    %{confeccionista: "C08", linea: "L3", dia: 6, prendas: 180, defectos: 30.6},

    %{confeccionista: "C09", linea: "L2", dia: 1, prendas: 85, defectos: 8.4},
    %{confeccionista: "C09", linea: "L3", dia: 1, prendas: 75, defectos: 11.6},
    %{confeccionista: "C09", linea: "L1", dia: 2, prendas: 95, defectos: 5.7},
    %{confeccionista: "C09", linea: "L4", dia: 2, prendas: 80, defectos: 14.2},
    %{confeccionista: "C09", linea: "L2", dia: 3, prendas: 165, defectos: 23.1},
    %{confeccionista: "C09", linea: "L3", dia: 4, prendas: 125, defectos: 10.4},
    %{confeccionista: "C09", linea: "L1", dia: 5, prendas: 90, defectos: 3.6},
    %{confeccionista: "C09", linea: "L4", dia: 6, prendas: 155, defectos: 18.9},

    %{confeccionista: "C10", linea: "L1", dia: 1, prendas: 60, defectos: 5.3},
    %{confeccionista: "C10", linea: "L4", dia: 1, prendas: 110, defectos: 16.5},
    %{confeccionista: "C10", linea: "L3", dia: 2, prendas: 70, defectos: 7.9},
    %{confeccionista: "C10", linea: "L2", dia: 2, prendas: 100, defectos: 12.7},
    %{confeccionista: "C10", linea: "L1", dia: 3, prendas: 180, defectos: 32.4},
    %{confeccionista: "C10", linea: "L4", dia: 4, prendas: 95, defectos: 6.2},
    %{confeccionista: "C10", linea: "L3", dia: 5, prendas: 145, defectos: 19.8},
    %{confeccionista: "C10", linea: "L2", dia: 6, prendas: 120, defectos: 9.5}
  ]
end
end
