# Arquitectura de Ranchox

## 1) Visión general
Ranchox usa una arquitectura cliente-servidor con Flutter consumiendo una API REST en PHP, persistida en MySQL.

```text
Flutter (Android/iOS/Web/Desktop)
        |
     HTTPS + JWT
        |
   PHP REST API (modular)
        |
      MySQL 8
```

## 2) Capas

### Frontend (Flutter)
- Gestión de estado recomendada: Riverpod o Bloc.
- Navegación por módulos: Dashboard, Animales, Sanidad, Producción, Finanzas, Veterinario Virtual, Reportes.
- Funcionalidades offline-first opcionales para campo.

### Backend (PHP)
- Framework sugerido: Laravel (o Slim para versión ligera).
- Autenticación JWT/Sanctum.
- Validación centralizada por Request DTO.
- Cola de trabajos para alertas y recordatorios.

### Datos (MySQL)
- Modelo relacional con entidades por animal y tablas transaccionales.
- Auditoría mínima con `created_at`, `updated_at`, `created_by`.

## 3) Módulos de negocio

1. **Catálogo de especies y razas**.
2. **Registro de animales** (ID interno + código visible).
3. **Sanidad** (vacunas, enfermedades, tratamientos, alertas).
4. **Producción**:
   - Bovino: litros de leche, crías/año, clasificación (reproductora/lechera/carne).
   - Equino: condición física, entrenamiento, historial médico.
   - Porcino: engorde, reproducción, costos por fase.
   - Aves: postura de huevos, conversión alimenticia.
5. **Economía** (gastos, inversión, ingresos, ventas por animal o lote).
6. **Imágenes y documentos** (evidencias, historial visual).
7. **Veterinario virtual** (reglas + motor de recomendaciones).

## 4) Veterinario virtual (enfoque seguro)

### Entrada
- Especie
- Edad
- Síntomas
- Temperatura (si existe)
- Historial reciente (vacunas/medicación)

### Lógica base (MVP)
- Motor de reglas (if/then) por especie y síntoma.
- Clasificación de severidad: Baja / Media / Alta / Emergencia.
- Sugerencias de soporte temporal:
  - Aislamiento.
  - Hidratación.
  - Control de temperatura.
  - Medidas higiénicas.
- Recomendación de **contacto veterinario inmediato** cuando corresponda.

### Ejemplo
Caso: "Caballo Pepe código 7 con gripe".
Salida:
- Riesgo: Medio (si no hay dificultad respiratoria).
- Acciones iniciales: reposo, agua limpia, control de fiebre, separar del grupo.
- Bandera roja: si hay secreción intensa, fiebre alta persistente o disnea -> urgencia veterinaria.

## 5) Seguridad
- JWT + refresh token.
- Roles: Admin, Encargado, Veterinario, Consulta.
- Cifrado en tránsito (HTTPS).
- Trazabilidad de cambios clínicos y económicos.

## 6) Despliegue
- Backend PHP + Nginx en VPS o cloud.
- MySQL administrado o autogestionado.
- Flutter Web para escritorio vía navegador.
- Flutter móvil para Android/iOS.

## 7) Roadmap por fases

### Fase 1 (MVP)
- Registro animales
- Sanidad básica
- Producción principal
- Finanzas básicas

### Fase 2
- Veterinario virtual por reglas
- Alertas automáticas
- Reportería avanzada

### Fase 3
- IA asistida (clasificación de síntomas con historial)
- Predicción productiva y de costos
