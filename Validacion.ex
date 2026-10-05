
@moduledoc """
Validación de lotes de producción.
Aplica cinco reglas en orden y devuelve {:ok, lote} o {:error, motivo}.
"""

defmodule Validacion do

@doc """
Valida un lote contra las cinco reglas, en orden.
Solo informa el primer motivo de rechazo.
"""
  @dia_minimo 1
  @dia_maximo 6
  @prendas_minimo 1
  @prendas_maximo 180

def validar_lotes(confeccionistas, lotes, lineas) do

    with :ok <- verificar_confeccionista(lote.confeccionistas, confeccionistas),
         :ok <- verificar_linea(lote.linea, lineas),
         :ok <- verificar_dia(lote.dia),
         :ok <- verificar_prendas(lote.prendas),
         :ok <- verificar_defectos(lote.defectos) do
      {:ok, lote}
    end

    # Condicion Uno

    defp verificar_confeccionista(codigo, confeccionistas) do

        if existe_confeccionista(codigo, confeccionistas) do
        :ok
        else
        {:error , :confeccionista_desconocido}
            end
        end

        #Enum,any? se encarga de preguntar si hay al menos algun elemento que cumpla una condicion
    defp existe_confeccionista(codigo, confeccionistas) do
    Enum.any?(confeccionistas, fn identificador -> identificador.codigo == codigo)
    end

    # Condicion Dos, es igual a la condicion anterior solo que aqui verificamos que sea una linea la que exista

    defp verificar_linea(id, linea) do
       if existe_linea(id, linea)do
        :ok
       else
        {:error, :line_desconocida}
        end
    end

    #Enum,any? se encarga de preguntar si hay al menos algun elemento que cumpla una condicion
    defp existe_linea(id, linea) do
    Enum.any?(lineas, fn 1 -> 1.id == id)
    end

    # Condicion 3 usando una verificacion de que el dato recibido sea un entero
    y luego que ese entero este dentro de los limites

    defp verificar_dia(dia)do
        when is_integer(dia) and dia => @dia_minimo and dia <= @dia_maximo do
            :ok

    defp verificar(), do {:error, :dia_invalido}
        end
    end

    # Condicion 4

    defp verificar_prendas(lote, prendas) do
         when is_integer(prendas) and prendas => @prendas_minimo and prendas <= @prendas_maximo do
            :ok
    defp verificar_prendas(), do {:error, :dia_invalido}
        end
    end

    # Condicion 5

    defp verificar_defectos(lote, defectos)do

        when is_number (defectos) and defectos => 0 and defectos <= 100
        :ok
    defp verificar_defectos() do {:error, :porcentaje_invalido}
    end
    end

    @doc """
  Separa los lotes en {validos, rechazados}.
  Los rechazados quedan como {lote, motivo}.
  """
  def separar_lotes(lotes, confeccionistas, lineas) do
    resultados =
    Enum.map(lotes, fn lote -> {lote, validar_lotes(lote, confeccionistas, lineas)}
    end)

    {ok, error} = Enum.split_with(resultados, fn {_lote, r} -> match?({:ok, _}, r) end)

    validos = Enum.map(ok, fn {lote, _} -> lote end)
    rechazados = Enum.map(error, fn {lote, {:error, motivo}} -> {lote, motivo} end)

    {validos, rechazados}
  end
end

end
end
