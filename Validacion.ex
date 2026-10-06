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

  def validar_lotes(lote, confeccionistas, lineas) do
    with :ok <- verificar_confeccionista(lote.confeccionistas, confeccionistas),
         :ok <- verificar_linea(lote.linea, lineas),
         :ok <- verificar_dia(lote.dia),
         :ok <- verificar_prendas(lote.prendas),
         :ok <- verificar_defectos(lote.defectos) do

      {:ok, lote}
    end
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
    Enum.any?(confeccionistas, fn identificador -> identificador.codigo == codigo end)

  # Condición 1
  defp verificar_confeccionista(codigo, confeccionistas) do
    if existe_confeccionista(codigo, confeccionistas) do
      :ok
    else
      {:error, :confeccionista_desconocido}

    end
  end

  defp existe_confeccionista(codigo, confeccionistas) do
    Enum.any?(
      confeccionistas,
      fn identificador -> identificador.codigo == codigo end
    )
  end

  # Condición 2
  defp verificar_linea(id, lineas) do
    if existe_linea(id, lineas) do
      :ok
    else
      {:error, :linea_desconocida}
    end
  end

  defp existe_linea(id, lineas) do
    Enum.any?( lineas, fn linea -> linea.id == id end )
  end


    defp existe_linea(id, linea) do
    Enum.any?(lineas, fn 1 -> 1.id == id end)

  # Condición 3
  defp verificar_dia(dia) do
    if is_integer(dia) and
       dia >= @dia_minimo and
       dia <= @dia_maximo do
      :ok
    else
      {:error, :dia_invalido}

    end
  end

  # Condición 4
  defp verificar_prendas(prendas) do
    if is_integer(prendas) and
       prendas >= @prendas_minimo and
       prendas <= @prendas_maximo do
      :ok
    else
      {:error, :cantidad_prendas_invalida}
    end
  end

  # Condición 5
  defp verificar_defectos(defectos) do
    if is_number(defectos) and
       defectos >= 0 and
       defectos <= 100 do
      :ok
    else
      {:error, :porcentaje_invalido}
    end
  end

  @doc """
  Separa los lotes en {validos, rechazados}.
  Los rechazados quedan como {lote, motivo}.
  """

  def separar_lotes(lotes, confeccionistas, lineas) do
    resultados =
      Enum.map(lotes, fn lote ->
        {lote, validar_lotes(lote, confeccionistas, lineas)}
      end)

    {aceptados, rechazados} =
      Enum.split_with(
        resultados,
        fn {_lote, resultado} ->
          match?({:ok, _}, resultado)
        end
      )

    validos =
      Enum.map(aceptados, fn {lote, _} ->
        lote
      end)

    rechazados =
      Enum.map(rechazados, fn {lote, {:error, motivo}} ->
        {lote, motivo}
      end)

    {validos, rechazados}
  end
end
    end
end
