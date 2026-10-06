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
  @doc """
  Función principal que agrupa los lotes por trabajador, usa las funciones de 
  reglas de negocio y genera la liquidación final para cada uno.
  """
  def liquidar(lotes_validos, confeccionistas, _lineas) do
    # Valoramos todos los lotes primero inyectándoles su valor en dinero
    lotes_con_dinero = Enum.map(lotes_validos, &valorar_lote/1)

    Enum.map(confeccionistas, fn trabajador ->
      # 1. Filtramos solo los lotes de este trabajador
      mis_lotes = Enum.filter(lotes_con_dinero, fn lote -> lote.confeccionista == trabajador.codigo end)

      # 2. Agrupamos por día para poder calcular los bonos diarios y días trabajados
      lotes_por_dia = Enum.group_by(mis_lotes, fn lote -> lote.dia end)
      dias_trabajados = map_size(lotes_por_dia) # Cantidad de días distintos en los que entregó algo

      # 3. Sumar el total de prendas
      total_prendas = Enum.reduce(mis_lotes, 0, fn lote, acc -> acc + lote.prendas end)

      # 4. Sumar el valor bruto de los lotes
      bruto = Enum.reduce(mis_lotes, 0.0, fn lote, acc -> acc + lote.valor end)

      # 5. Calcular bonificaciones (revisando día por día)
      bonificaciones =
        Enum.reduce(lotes_por_dia, 0.0, fn {_dia, lotes_del_dia}, acc ->
          prendas_del_dia = Enum.reduce(lotes_del_dia, 0, fn lote, suma -> suma + lote.prendas end)
          acc + calcular_bono_diario(prendas_del_dia)
        end)

      # 6. Calcular descuento de alquiler
      descuento = calcular_alquiler(trabajador.alquiler, dias_trabajados)

      # 7. Calcular el neto a pagar
      neto = bruto + bonificaciones - descuento

      # Devolvemos el mapa exacto que necesitan los reportes y el comprobante
      %{
        codigo: trabajador.codigo,
        nombre: trabajador.nombre,
        total_prendas: total_prendas,
        bruto: Float.round(bruto, 2),
        bonificaciones: Float.round(bonificaciones / 1, 2),
        descuento_alquiler: Float.round(descuento / 1, 2),
        neto: Float.round(neto, 2)
      }
    end)
  end
end
