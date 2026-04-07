# Ranchox API (outline)

## Base
`/api/v1`

## Auth
- `POST /auth/login`
- `POST /auth/refresh`
- `POST /auth/logout`

## Catálogos
- `GET /species`
- `POST /species`

## Animales
- `GET /animals`
- `POST /animals`
- `GET /animals/{id}`
- `PUT /animals/{id}`
- `DELETE /animals/{id}`

## Sanidad
- `POST /animals/{id}/vaccinations`
- `GET /animals/{id}/vaccinations`
- `POST /animals/{id}/health-events`
- `GET /animals/{id}/health-events`

## Producción
- `POST /animals/{id}/production-logs`
- `GET /animals/{id}/production-logs`

## Finanzas
- `POST /finance-transactions`
- `GET /finance-transactions`

## Imágenes
- `POST /animals/{id}/images`
- `GET /animals/{id}/images`

## Veterinario virtual
- `POST /virtual-vet/evaluate`

### Body sugerido
```json
{
  "animal_id": 7,
  "symptoms": ["tos", "fiebre", "secrecion_nasal"],
  "temperature_c": 39.6,
  "duration_hours": 24
}
```

### Respuesta sugerida
```json
{
  "severity": "media",
  "possible_conditions": ["infeccion_respiratoria"],
  "first_aid": ["aislar", "hidratar", "monitorear_fiebre"],
  "requires_vet": true,
  "alert": "Solicitar visita veterinaria en <24h"
}
```
