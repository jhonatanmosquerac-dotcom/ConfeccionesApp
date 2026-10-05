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
end
