defmodule Reportes do
@moduledoc """
  Genera los reportes de producción y liquidación.
  """

  @doc """
  Organiza los lotes rechazados y cuenta cuántos hay por motivo.
  """

def reporte_r1(lotes_rechazados) do
  conteo_por_motivo =
    Enum.frequencies_by(lotes_rechazados, fn {_lote, motivo} -> motivo end)

    %{lotes: lotes_rechazados, conteo: conteo_por_motivo}


  end

  @doc """
Calcula las prendas y la productividad semanal de cada línea.
"""

def reporte_r2(lotes_validos, lineas) do
  totales_iniciales =
    Enum.reduce(lineas, %{}, fn linea, acumulador ->
      Map.put(acumulador, linea.id, 0)
    end)

  totales_por_linea =
    Enum.reduce(lotes_validos, totales_iniciales, fn lote, acumulador ->
      Map.update(
        acumulador,
        lote.linea,
        lote.prendas,
        fn total_actual -> total_actual + lote.prendas end)
    end)

    reporte =
    Enum.map(lineas, fn linea ->
      prendas = Map.get(totales_por_linea, linea.id, 0)
      productividad = prendas / linea.puestos

      %{
        id: linea.id,
        nombre: linea.nombre,
        prendas: prendas,
        puestos: linea.puestos,
        productividad: productividad
      }
    end)

  Enum.sort_by(reporte, fn linea -> linea.productividad end, :desc)
end


  @doc """
Calcula las prendas producidas cada día y verifica la meta semanal.
"""
def reporte_r3(lotes_validos) do
  totales_iniciales =
    Enum.reduce(1..6, %{}, fn dia, acumulador ->
      Map.put(acumulador, dia, 0)
    end)

  totales_por_dia =
    Enum.reduce(lotes_validos, totales_iniciales, fn lote, acumulador ->
      Map.update(
        acumulador,
        lote.dia,
        lote.prendas,
        fn total_actual -> total_actual + lote.prendas end
      )
    end)

  dias =
    Enum.map(1..6, fn dia ->
      prendas = Map.get(totales_por_dia, dia, 0)

      %{
        dia: dia,
        prendas: prendas,
        meta_alcanzada: prendas >= 600
      }
    end)

  meta_todos_los_dias =
    Enum.reduce(dias, true, fn resultado, acumulado ->
      acumulado and resultado.meta_alcanzada
    end)

  meta_algun_dia =
    Enum.reduce(dias, false, fn resultado, acumulado ->
      acumulado or resultado.meta_alcanzada
    end)

  %{
    dias: dias,
    meta_todos_los_dias: meta_todos_los_dias,
    meta_algun_dia: meta_algun_dia
  }
end

@doc """
Ordena las liquidaciones por pago neto, de mayor a menor.
"""
def reporte_r4(liquidaciones) do
  Enum.sort_by(liquidaciones, fn liquidacion -> liquidacion.neto end, :desc)
end

@doc """
Encuentra los máximos productores de cada día y quién ocupó más veces el primer lugar.
"""
def reporte_r5(lotes_validos) do
  dias =
    Enum.map(1..6, fn dia ->
      lotes_del_dia =
        Enum.filter(lotes_validos, fn lote -> lote.dia == dia end)

      totales_por_confeccionista =
        Enum.reduce(lotes_del_dia, %{}, fn lote, acumulador ->
          Map.update(
            acumulador,
            lote.confeccionista,
            lote.prendas,
            fn total_actual -> total_actual + lote.prendas end
          )
        end)

      if totales_por_confeccionista == %{} do
        %{dia: dia, ganadores: [], prendas: 0}
      else
        {_codigo, maximo} =
          Enum.max_by(totales_por_confeccionista, fn {_codigo, prendas} -> prendas end)

        empatados =
          Enum.filter(totales_por_confeccionista, fn {_codigo, prendas} ->
            prendas == maximo
          end)

        ganadores =
          Enum.map(empatados, fn {codigo, _prendas} -> codigo end)

        %{dia: dia, ganadores: ganadores, prendas: maximo}
      end
    end)

  primeros_por_confeccionista =
    Enum.reduce(dias, %{}, fn resultado_dia, acumulador ->
      Enum.reduce(resultado_dia.ganadores, acumulador, fn codigo, conteo ->
        Map.update(conteo, codigo, 1, fn cantidad -> cantidad + 1 end)
      end)
    end)

  if primeros_por_confeccionista == %{} do
    %{
      dias: dias,
      quienes_lideran: [],
      cantidad_de_dias: 0
    }
  else
    {_codigo, maximo_de_primeros} =
      Enum.max_by(primeros_por_confeccionista, fn {_codigo, cantidad} -> cantidad end)

    quienes_lideran =
      Enum.filter(primeros_por_confeccionista, fn {_codigo, cantidad} ->
        cantidad == maximo_de_primeros
      end)

    codigos_lideres =
      Enum.map(quienes_lideran, fn {codigo, _cantidad} -> codigo end)

    %{
      dias: dias,
      quienes_lideran: codigos_lideres,
      cantidad_de_dias: maximo_de_primeros
    }
  end
end

@doc """
Encuentra al confeccionista o confeccionistas con menor porcentaje ponderado de defectos.
"""
def reporte_r6(lotes_validos) do
  acumulados =
    Enum.reduce(lotes_validos, %{}, fn lote, acumulador ->
      Map.update(
        acumulador,
        lote.confeccionista,
        %{
          cantidad_lotes: 1,
          defectos_por_prendas: lote.defectos * lote.prendas,
          total_prendas: lote.prendas
        },
        fn datos ->
          %{
            cantidad_lotes: datos.cantidad_lotes + 1,
            defectos_por_prendas:
              datos.defectos_por_prendas + lote.defectos * lote.prendas,
            total_prendas: datos.total_prendas + lote.prendas
          }
        end
      )
    end)

  con_tres_lotes =
    Enum.filter(acumulados, fn {_codigo, datos} ->
      datos.cantidad_lotes >= 3
    end)

  calidades =
    Enum.map(con_tres_lotes, fn {codigo, datos} ->
      %{
        codigo: codigo,
        porcentaje_ponderado: datos.defectos_por_prendas / datos.total_prendas
      }
    end)

  if calidades == [] do
    %{mejores: [], mensaje: :sin_confeccionistas_con_tres_lotes}
  else
    mejor =
      Enum.min_by(calidades, fn confeccionista ->
        confeccionista.porcentaje_ponderado
      end)

    empatados =
      Enum.filter(calidades, fn confeccionista ->
        confeccionista.porcentaje_ponderado == mejor.porcentaje_ponderado
      end)

    %{
      mejores: empatados,
      porcentaje_ponderado: mejor.porcentaje_ponderado
    }
  end
end

@doc """
Calcula el pago total del taller y el costo promedio por prenda válida.
"""
def reporte_r7(liquidaciones, lotes_validos) do
  total_pagado =
    Enum.reduce(liquidaciones, 0, fn liquidacion, acumulador ->
      acumulador + liquidacion.neto
    end)

  total_prendas_validas =
    Enum.reduce(lotes_validos, 0, fn lote, acumulador ->
      acumulador + lote.prendas
    end)

  if total_prendas_validas == 0 do
    %{
      total_pagado: total_pagado,
      total_prendas_validas: 0,
      costo_promedio: nil,
      mensaje: :promedio_no_calculable
    }
  else
    %{
      total_pagado: total_pagado,
      total_prendas_validas: total_prendas_validas,
      costo_promedio: total_pagado / total_prendas_validas
    }
  end
end

@doc """
Encuentra quiénes tuvieron al menos un lote válido en todas las líneas.
"""
def reporte_r8(lotes_validos, lineas) do
  lineas_por_confeccionista =
    Enum.reduce(lotes_validos, %{}, fn lote, acumulador ->
      Map.update(
        acumulador,
        lote.confeccionista,
        [lote.linea],
        fn lineas_trabajadas -> [lote.linea | lineas_trabajadas] end
      )
    end)

  confeccionistas_en_todas =
    Enum.filter(lineas_por_confeccionista, fn {_codigo, lineas_trabajadas} ->
      lineas_unicas = Enum.uniq(lineas_trabajadas)

      cantidad_trabajadas =
        Enum.reduce(lineas_unicas, 0, fn _linea, cantidad ->
          cantidad + 1
        end)

      cantidad_total =
        Enum.reduce(lineas, 0, fn _linea, cantidad ->
          cantidad + 1
        end)

      cantidad_trabajadas == cantidad_total
    end)

  codigos =
    Enum.map(confeccionistas_en_todas, fn {codigo, _lineas} -> codigo end)

  if codigos == [] do
    %{confeccionistas: [], mensaje: :ninguno_en_todas_las_lineas}
  else
    %{confeccionistas: codigos}
  end
end



end
