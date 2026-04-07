# Módulos funcionales por especie

## Campos base para cualquier animal
- Código único
- Nombre
- Especie
- Raza
- Sexo
- Fecha de nacimiento / edad
- Peso actual e historial
- Estado (saludable, en observación, enfermo)
- Alimentación recomendada por etapa
- Vacunas aplicadas y próximas
- Fotos / evidencias
- Estado comercial (venta/no venta)

## Equinos (caballería)
- Disciplina o uso (trabajo, monta, reproducción)
- Condición física
- Historial de cascos/herraje
- Registro de enfermedades respiratorias
- Medicación vigente

## Bovinos
- Tipo productivo: lechera, carne, reproductora
- Litros de leche diarios
- Número de crías por año
- Historial reproductivo
- Ganancia de peso

## Porcinos
- Etapa (lechón, crecimiento, engorde, reproductor)
- Conversión alimenticia
- Peso por fase
- Estado sanitario grupal

## Aves (gallinas)
- Línea (postura/carne)
- Huevos por día/semana/mes
- Mortalidad
- Consumo de alimento por lote

## Módulo financiero transversal
- Costos de alimento
- Costos médicos y vacunas
- Mano de obra
- Inversión por infraestructura
- Ventas por animal/lote
- Rentabilidad neta

## Validaciones clave
- Código animal no duplicado.
- Peso y edad en rangos válidos.
- Fecha de vacuna no futura para registros aplicados.
- Medicación con dosis y frecuencia obligatorias.
- Alertar si síntomas críticos + sin atención veterinaria.
