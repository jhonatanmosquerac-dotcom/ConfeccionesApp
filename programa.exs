defmodule Programa do
  @moduledoc """
  Punto de entrada principal. Orquesta los módulos y maneja la consola.
  """

  def main do
    IO.puts("=== SISTEMA DE LIQUIDACIÓN - TALLER DE CONFECCIONES ===\n")

    # 1. Pedir el lote adicional por consola (Parte B.5)
    _lote_extra = pedir_lote_adicional()

    # (Aquí Jhonatan validará los datos y el tercer compañero imprimirá los reportes R1 al R8)
    IO.puts("\n[... Aquí se imprimirán los 8 reportes de tu compañero ...]\n")

    # Datos falsos temporales para que puedas probar tu función de comprobante hoy mismo
    liquidaciones_falsas = [
      %{codigo: "C01", nombre: "Maria Elena Rios", total_prendas: 125, bruto: 394560.0, bonificaciones: 18000.0, descuento_alquiler: 30000.0, neto: 382560.0},
      %{codigo: "C02", nombre: "Andres Salazar", total_prendas: 50, bruto: 160000.0, bonificaciones: 0.0, descuento_alquiler: 0.0, neto: 160000.0}
    ]

    # 2. Pedir e imprimir el comprobante individual (Parte B.5)
    pedir_comprobante(liquidaciones_falsas)
  end

  def pedir_lote_adicional do
    entrada = IO.gets("Ingrese un lote adicional (confeccionista;linea;dia;prendas;defectos)\no Enter para omitir: ")
    entrada_limpia = String.trim(entrada)

    if entrada_limpia == "" do
      IO.puts("Lote omitido. Continuando...")
      nil
    else
      campos = String.split(entrada_limpia, ";")

      if length(campos) == 5 do
        [confeccionista, linea, dia_str, prendas_str, defectos_str] = campos

        with {dia, ""} <- Integer.parse(dia_str),
             {prendas, ""} <- Integer.parse(prendas_str),
             {defectos, _resto} <- Float.parse(defectos_str <> ".0")
        do
          lote = %{confeccionista: confeccionista, linea: linea, dia: dia, prendas: prendas, defectos: defectos}
          IO.puts("¡Lote creado con éxito y formato correcto!")
          {:ok, lote}
        else
          _ ->
            IO.puts("Error: El día/prendas deben ser enteros, y defectos debe ser numérico.")
            {:error, :formato_invalido}
        end
      else
        IO.puts("Error: Formato inválido. No hay 5 campos.")
        {:error, :formato_invalido}
      end
    end
  end

  def pedir_comprobante(liquidaciones) do
    IO.puts("--- CONSULTA DE COMPROBANTE ---")
    entrada = IO.gets("Ingrese el código del confeccionista: ")
    codigo_buscado = entrada |> String.trim() |> String.upcase()

    # Buscamos en la lista usando la función pura Enum.find
    encontrado = Enum.find(liquidaciones, fn liq -> liq.codigo == codigo_buscado end)

    if encontrado do
      IO.puts("\n=== COMPROBANTE DE PAGO ===")
      IO.puts("Nombre: #{encontrado.nombre} (Código: #{encontrado.codigo})")
      IO.puts("Total prendas válidas: #{encontrado.total_prendas}")
      IO.puts("Valor bruto lotes: $#{encontrado.bruto}")
      IO.puts("Bonificaciones: $#{encontrado.bonificaciones}")
      IO.puts("Descuento alquiler: $#{encontrado.descuento_alquiler}")
      IO.puts("---------------------------")
      IO.puts("NETO A PAGAR: $#{encontrado.neto}")
      IO.puts("===========================\n")
    else
      IO.puts("\nEl código '#{codigo_buscado}' no existe en el sistema o no tiene registros.")
    end
  end
end

Programa.main()
