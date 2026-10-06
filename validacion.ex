# Autores: Juan Camilo, Jhonatan, Esteban

defmodule Validacion do
  @moduledoc """
  Validación de lotes de producción.
  Aplica cinco reglas en orden y devuelve {:ok, lote} o {:error, motivo}.
  """

  @dia_minimo 1
  @dia_maximo 6
  @prendas_minimo 1
  @prendas_maximo 180

  @doc """
  Valida un lote contra las cinco reglas, en orden estricto.
  Solo informa el primer motivo de rechazo usando 'with'.
  """
  def validar(lote, confeccionistas, lineas) do
    with :ok <- verificar_confeccionista(lote.confeccionista, confeccionistas),
         :ok <- verificar_linea(lote.linea, lineas),
         :ok <- verificar_dia(lote.dia),
         :ok <- verificar_prendas(lote.prendas),
         :ok <- verificar_defectos(lote.defectos) do
      {:ok, lote}
    end
  end

  # --- Regla 1 ---
  defp verificar_confeccionista(codigo, confeccionistas) do
    if Enum.any?(confeccionistas, fn c -> c.codigo == codigo end) do
      :ok
    else
      {:error, :confeccionista_desconocido}
    end
  end

  # --- Regla 2 ---
  defp verificar_linea(id_linea, lineas) do
    if Enum.any?(lineas, fn l -> l.id == id_linea end) do
      :ok
    else
      {:error, :linea_desconocida}
    end
  end

  # --- Regla 3 --- (Usando guardas 'when' correctamente)
  defp verificar_dia(dia) when is_integer(dia) and dia >= @dia_minimo and dia <= @dia_maximo do
    :ok
  end
  defp verificar_dia(_dia) do
    {:error, :dia_invalido}
  end

  # --- Regla 4 ---
  defp verificar_prendas(prendas) when is_integer(prendas) and prendas >= @prendas_minimo and prendas <= @prendas_maximo do
    :ok
  end
  defp verificar_prendas(_prendas) do
    {:error, :prendas_invalidas}
  end

  # --- Regla 5 ---
  defp verificar_defectos(defectos) when is_number(defectos) and defectos >= 0 and defectos <= 100 do
    :ok
  end
  defp verificar_defectos(_defectos) do
    {:error, :porcentaje_invalido}
  end

  @doc """
  Recorre toda la lista de lotes y los separa en dos grupos:
  {lista_de_validos, lista_de_rechazados_con_motivo}
  """
  def separar_lotes(lotes, confeccionistas, lineas) do
    # Validamos todos los lotes uno por uno
    resultados =
      Enum.map(lotes, fn lote -> {lote, validar(lote, confeccionistas, lineas)} end)

    # Dividimos la lista en dos según si respondieron {:ok, _} o {:error, _}
    {aceptados, con_error} =
      Enum.split_with(resultados, fn {_lote, r} -> match?({:ok, _}, r) end)

    # Limpiamos los datos para entregarlos exactamente como pide el PDF
    validos = Enum.map(aceptados, fn {lote, _} -> lote end)
    rechazados = Enum.map(con_error, fn {lote, {:error, motivo}} -> {lote, motivo} end)

    {validos, rechazados}
  end
end