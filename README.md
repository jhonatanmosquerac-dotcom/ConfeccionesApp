# 🧵 Sistema de Liquidación - Taller de Confecciones

**Proyecto Final de Programación Funcional con Elixir**

Este proyecto es un sistema completo para la gestión, validación, cálculo de nómina y generación de reportes estadísticos de un taller de confecciones. Está desarrollado bajo el paradigma de programación funcional, garantizando inmutabilidad, uso de funciones puras, y el aprovechamiento exhaustivo del módulo `Enum` y *List Comprehensions*.

## 👥 Equipo de Desarrollo
* **Juan Camilo** - Lógica Financiera y Liquidación (`Liquidacion.ex`)
* **Jhonatan** - Filtros y Reglas de Negocio (`Validacion.ex`)
* **Esteban** - Analítica y Reportes Estadísticos (`Reportes.ex`)
🏗 Arquitectura del Proyecto
El sistema está dividido en 5 archivos modulares para separar las responsabilidades:

datos.exs: Actúa como la base de datos inyectable del sistema (confeccionistas, líneas de producción y lotes iniciales).

Validacion.ex: Procesa la entrada de datos aplicando 5 reglas de negocio estrictas utilizando guardas (when) y la estructura with para el control de flujo y manejo de errores ({:ok, lote} / {:error, motivo}).

Liquidacion.ex: Motor financiero que inyecta el valor monetario a la producción, calculando tarifas base, bonificaciones por cumplimiento y deducciones por alquiler de equipos.

Reportes.ex: Motor de analítica que procesa las colecciones de datos para generar 8 reportes gerenciales (R1 al R8) manejando casos extremos (como divisiones por cero o empates en liderazgo).

programa.exs: El orquestador principal (Punto de entrada). Conecta el flujo de datos entre los módulos y gestiona la interacción por consola con el usuario.

🚀 Instrucciones de Ejecución
Para evaluar el proyecto, asegúrese de tener Elixir instalado.

1. Clonar el repositorio y acceder a la carpeta:

Bash
git clone [https://github.com/jhonatanmosquerac-dotcom/ConfeccionesApp.git](https://github.com/jhonatanmosquerac-dotcom/ConfeccionesApp.git)
cd ConfeccionesApp
2. Compilar los módulos en memoria:
Es indispensable compilar los módulos de soporte antes de ejecutar el programa principal para que el orquestador pueda localizarlos:

Bash
elixirc datos.exs validacion.ex reportes.ex Liquidacion.ex
3. Ejecutar el orquestador principal:

Bash
elixir programa.exs
💻 Guía de Uso Interactivo
Al ejecutar el programa, el sistema le guiará por tres fases:

Inyección de Lote Adicional: El sistema le pedirá ingresar un lote manual con el formato codigo;linea;dia;prendas;defectos. Si desea probar el flujo con los datos por defecto, simplemente presione Enter para omitir.

Cascada de Reportes: Automáticamente, la consola imprimirá los 8 reportes gerenciales solicitados (Lotes rechazados, Productividad, Cumplimiento de metas, Ranking, Liderazgo, Calidad, Finanzas y Versatilidad).

Consulta de Comprobante: Al final de la ejecución, el sistema se pausará y le pedirá el código de un trabajador (ej. C01, C02, C10). Al ingresarlo, imprimirá el desprendible de pago detallado de ese empleado y finalizará su ejecución.