# Autores: Juan Camilo, Jhonatan, Esteban
defmodule Programa do
  @moduledoc """
  Punto de entrada principal. Orquesta los módulos y maneja la consola.
  """

  def main do
    IO.puts("=== SISTEMA DE LIQUIDACIÓN - TALLER DE CONFECCIONES ===\n")

    # 1. Cargar la base de datos real
    confeccionistas = Datos.confeccionistas()
    lineas = Datos.lineas()
    lotes_base = Datos.lotes()

    # 2. Pedir el lote adicional por consola (Parte B.5)
    lote_extra = pedir_lote_adicional()

    # Sumar el lote extra a la lista si fue escrito correctamente
    lotes_totales =
      case lote_extra do
        {:ok, lote} -> [lote | lotes_base]
        _ -> lotes_base
      end

    # 3. VALIDACIÓN (Turno de Jhonatan)
    {validos, rechazados} = Validacion.separar_lotes(lotes_totales, confeccionistas, lineas)

    # 4. LIQUIDACIÓN (Tu turno)
    # IMPORTANTE: Cambia "Liquidacion.liquidar" por el nombre exacto de tu función.
    liquidaciones = Liquidacion.liquidar(validos, confeccionistas, lineas)

    # 5. REPORTES (Turno de Esteban)
    IO.puts("\n=== REPORTES DE PRODUCCIÓN ===")
    
    imprimir_reporte_r1(Reportes.reporte_r1(rechazados))

    IO.puts("\n--- R2: Productividad por Línea ---")
    IO.inspect(Reportes.reporte_r2(validos, lineas), pretty: true)

    IO.puts("\n--- R3: Cumplimiento de Meta Diaria ---")
    IO.inspect(Reportes.reporte_r3(validos), pretty: true)

    IO.puts("\n--- R4: Ranking de Pagos Netos ---")
    IO.inspect(Reportes.reporte_r4(liquidaciones), pretty: true)

    IO.puts("\n--- R5: Liderazgo Diario ---")
    IO.inspect(Reportes.reporte_r5(validos), pretty: true)

    IO.puts("\n--- R6: Mayor Calidad (Menor % Defectos) ---")
    IO.inspect(Reportes.reporte_r6(validos), pretty: true)

    IO.puts("\n--- R7: Totales Financieros ---")
    IO.inspect(Reportes.reporte_r7(liquidaciones, validos), pretty: true)

    IO.puts("\n--- R8: Versatilidad (Todas las líneas) ---")
    IO.inspect(Reportes.reporte_r8(validos, lineas), pretty: true)

    # 6. COMPROBANTE FINAL
    IO.puts("\n")
    pedir_comprobante(liquidaciones)
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
  
  def imprimir_reporte_r1(reporte) do
    IO.puts("\n--- R1: LOTES RECHAZADOS ---")

    Enum.each(reporte.lotes, fn {lote,motivo} ->
      IO.puts("Motivo: #{motivo}")
      IO.puts("Lote:")
      IO.inspect(lote)
    end)

    IO.puts("\nCantidad de rechazos por motivo:")

    Enum.each(reporte.conteo, fn{motivo, cantidad} ->
      IO.puts("#{motivo}: #{cantidad}")
    end)
  end
end

Programa.main()