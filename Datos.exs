defmodule Datos do
  def confeccionistas do
  [
    %{codigo: "C01", nombre: "Maria Elena Rios", alquiler: true},
    %{codigo: "C02", nombre: "Andres Salazar", alquiler: false}
    # ...
  ]
  end

  def lineas do
  [
    %{id: "L1", nombre: "Linea Norte", puestos: 6},
    %{id: "L2", nombre: "Linea Central", puestos: 4}
    # ...
  ]
  end

  def lotes do
  [
    %{confeccionista: "C01", linea: "L1", dia: 1, prendas: 70, defectos: 1.5},
  %{confeccionista: "C01", linea: "L2", dia: 1, prendas: 55, defectos: 7}
  # ...
]
end
end
