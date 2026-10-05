# Autores: Juan Camilo, Jhonatan, Esteban
defmodule Liquidacion do
  @moduledoc """
  Módulo de funciones puras. Se encarga de aplicar las reglas de negocio
  para calcular el valor monetario de la producción de los confeccionistas.
  """

  # Parámetros exigidos por el PDF como atributos de módulo
  @tarifa_base 3200
  @prendas_para_bono 120
  @bono_diario 18000
  @alquiler_diario 15000

  @doc """
  Regla 2: Calcula el valor en pesos de un lote.
  Recibe la cantidad de prendas y el porcentaje de defectos.
  """
  def calcular_valor_lote(prendas, defectos) do
    valor_base = prendas * @tarifa_base

    # cond evalúa de arriba hacia abajo y entra en la primera que sea verdadera
    cond do
      defectos <= 2.0 -> valor_base * 1.07   # Bonificación del 7%
      defectos <= 5.0 -> valor_base * 1.00   # Sin ajuste (100%)
      defectos <= 10.0 -> valor_base * 0.88  # Descuento del 12%
      true -> valor_base * 0.75              # Descuento del 25% (más del 10%)
    end
  end

  @doc """
  Regla 3: Calcula la bonificación de un día específico.
  Recibe el total de prendas elaboradas (sumando todas las líneas) en ese día.
  """
  def calcular_bono_diario(prendas_del_dia) do
    if prendas_del_dia >= @prendas_para_bono do
      @bono_diario
    else
      0
    end
  end

  @doc """
  Regla 4: Calcula el descuento por usar la máquina del taller.
  Recibe un booleano (si alquila o no) y el número de días que registró lotes.
  """
  def calcular_alquiler(alquila_maquina?, dias_trabajados) do
    if alquila_maquina? do
      dias_trabajados * @alquiler_diario
    else
      0
    end
  end

@doc """
  Toma un mapa de lote validado y le inyecta la llave :valor con el cálculo monetario.
  """
  def valorar_lote(lote) do
    valor_calculado = calcular_valor_lote(lote.prendas, lote.defectos)
    Map.put(lote, :valor, valor_calculado)
  end
end
