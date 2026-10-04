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
    %{confeccionista: "C5", linea: "L2", dia: 1, prendas: 55, defectos: 7},
    %{confeccionista: "C01", linea: "L5", dia: 1, prendas: 55, defectos: 7},
    %{confeccionista: "C01", linea: "L9", dia: 1, prendas: 55, defectos: 7},
    %{confeccionista: "C01", linea: "L2", dia: 0, prendas: 55, defectos: 7},
    %{confeccionista: "C01", linea: "L2", dia: 11, prendas: 55, defectos: 7},
    %{confeccionista: "C01", linea: "L2", dia: 1, prendas: 55.4, defectos: 7},
    %{confeccionista: "C01", linea: "L2", dia: 1, prendas: 180, defectos: 7},
    %{confeccionista: "C01", linea: "L2", dia: 1, prendas: 55, defectos: 101},
    %{confeccionista: "C01", linea: "L2", dia: 1, prendas: 55, defectos: -1}

]
end
end
