# Sistema Industrial de Control Diario (Flutter + PHP + MySQL)

Este proyecto implementa un sistema **fácil de usar pero profesional** para registrar el control diario de desinfectantes (pH, temperatura, turbidez y concentración), inspirado en el formato de tu imagen.

## Arquitectura

- **Frontend:** Flutter (tablet y computadora, diseño responsive).
- **Backend:** PHP 8+ (API REST simple con autenticación por token).
- **Base de datos:** MySQL 8+.

## Colores y diseño

La interfaz usa una paleta **naranja industrial**:
- Principal: `#F57C00`
- Fondo suave: `#FFF3E0`

## Estructura

- `flutter_app/` → app Flutter.
- `backend/` → API PHP + script SQL.

## 1) Configurar la base de datos

1. Crear base y tablas:
   ```bash
   mysql -u root -p < backend/database.sql
   ```
2. Usuario demo creado:
   - Usuario: `admin`
   - Contraseña: `Admin123*`

## 2) Configurar backend PHP

Edita `backend/config/config.php` con tus credenciales MySQL:

- `DB_HOST`
- `DB_NAME`
- `DB_USER`
- `DB_PASS`

Levanta el backend en local:

```bash
php -S 0.0.0.0:8000 -t backend/api
```

## 3) Configurar Flutter

1. En `flutter_app/lib/screens/login_screen.dart` cambia:
   - `http://TU_SERVIDOR/backend/api`
   por la URL real de tu API (ejemplo: `http://192.168.1.10:8000`).

2. Ejecuta:

```bash
cd flutter_app
flutter pub get
flutter run
```

## Módulos implementados

- Inicio de sesión con token.
- Registro diario de monitoreo (cabecera + medición).
- Validación de campos obligatorios.
- Endpoint de catálogos de límites operacionales.
- Endpoint para listar y actualizar registros.

## Endpoints

- `POST /login.php`
- `POST /records_create.php`
- `POST /records_update.php`
- `GET /records_list.php?date=YYYY-MM-DD&shift=Mañana`
- `GET /catalogs.php`

## Recomendaciones pro de producción

- Mover credenciales a variables de entorno.
- Activar HTTPS.
- Implementar roles por permisos y bitácora de auditoría.
- Programar respaldos automáticos de MySQL.
- Agregar exportación PDF del formato diario.
