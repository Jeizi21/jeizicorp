# Módulo de Auxiliar de Limpieza (Flutter + PHP + MySQL)

Este repositorio contiene una base para conectar tu sistema actual con un **módulo visual** para auxiliar de limpieza con:

- Entrega de EPP.
- Entrega de químicos.
- Recibo de etiquetas.
- Registro de limpiezas por área.
- Inventario de EPP, químicos y etiquetas.
- KPIs e historial.

## Estructura

- `lib/`: pantalla Flutter del panel (KPIs, historial e inventario).
- `backend/`: endpoints PHP y script SQL para MySQL.

## Flujo de datos

1. Flutter consulta:
   - `GET /backend/kpis.php`
   - `GET /backend/movimientos.php`
   - `GET /backend/inventario.php`
2. PHP consulta MySQL y devuelve JSON.
3. La pantalla muestra indicadores e historial en tiempo real (con botón de refrescar).

## Ejecución rápida

### Backend (PHP)

```bash
php -S 0.0.0.0:8080
```

### Base de datos

```bash
mysql -u root -p < backend/schema.sql
```

### Flutter

Ajusta `baseUrl` en `lib/cleaning_dashboard_screen.dart` según tu entorno y ejecuta:

```bash
flutter pub get
flutter run
```

## Próximos pasos sugeridos

- Crear endpoints `POST` para registrar nuevas entregas/recibos/limpiezas.
- Agregar login y roles (auxiliar/supervisor).
- Añadir exportación de reportes (PDF/Excel).
- Notificaciones automáticas de stock bajo.
