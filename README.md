# Ranchox (R-A-N-C-H-O-X)

Sistema integral de gestión de rancho multiplataforma:

- **Frontend:** Flutter (Android, iOS, Web, Desktop).
- **Backend:** PHP 8.3 (API REST).
- **Base de datos:** MySQL 8.

## Objetivo
Ranchox centraliza el control de bovinos, equinos (caballería), porcinos y aves (gallinas), con módulos de:

- Inventario por animal (código, nombre, edad, peso, estado).
- Alimentación recomendada por etapa de vida.
- Vacunación y alertas sanitarias.
- Enfermedades y observaciones clínicas.
- Imágenes y documentos.
- Gestión económica (costos, inversión, ventas, ingresos).
- Producción (leche, huevos, crías, etc.).
- **Veterinario virtual** (asistente preventivo, no sustituto médico).

## Estructura propuesta

- `docs/ranchox-architecture.md`: arquitectura completa.
- `docs/ranchox-functional-modules.md`: módulos por especie.
- `backend/sql/schema.sql`: esquema base de MySQL.
- `backend/api/openapi-outline.md`: diseño de endpoints REST.

## Flujo principal

1. Registrar especie y animal (ej.: Caballo Pepe, código 7).
2. Registrar signos clínicos (ej.: gripe).
3. Consultar veterinario virtual para sugerencias de primeros auxilios y aislamiento.
4. Programar visita de veterinario real y seguimiento.
5. Medir costos, productividad e indicadores por periodo.

## Nota de seguridad
El módulo de veterinario virtual brinda **orientación inicial** y recomendaciones de soporte. No reemplaza diagnóstico ni tratamiento de un profesional veterinario certificado.
