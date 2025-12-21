# EcommerceAPI
API RESTful de eCommerce desarrollada en C# (.NET 9), arquitectura monolítica, autenticación JWT, PostgreSQL, Docker, pagos con MercadoPago y observabilidad integrada.


# 🛒 eCommerce API

API RESTful para un sistema de **eCommerce**, desarrollada en **C# con .NET 9**, bajo una **arquitectura monolítica**, orientada a ser escalable, segura y observable.

El proyecto integra autenticación basada en **JWT**, persistencia de datos en **PostgreSQL**, procesamiento de pagos mediante **MercadoPago**, ejecución en contenedores **Docker** y herramientas de **observabilidad** para monitoreo y diagnóstico.

---

## 🚀 Tecnologías y Herramientas

- **.NET 9**
- **C#**
- **ASP.NET Core Web API**
- **PostgreSQL**
- **Entity Framework Core**
- **JWT (JSON Web Tokens)**
- **Docker & Docker Compose**
- **MercadoPago SDK**
- **Scalar (OpenAPI Documentation)**
- **Observabilidad** (logs, métricas y trazas)

---

## 🏗️ Arquitectura

El sistema utiliza una **arquitectura monolítica**, organizada en capas para mantener separación de responsabilidades:

- **API**: Controladores y endpoints REST
- **Application**: Casos de uso y lógica de negocio
- **Domain**: Entidades, Value Objects y reglas del dominio
- **Infrastructure**: Persistencia, integraciones externas y servicios técnicos

Esta estructura facilita el mantenimiento, pruebas y una posible evolución futura hacia microservicios si se requiere.

---

## 🔐 Autenticación y Seguridad

- Autenticación basada en **JWT**
- Protección de endpoints mediante **Authorization Policies**
- Manejo seguro de credenciales y secretos mediante variables de entorno

---

## 💳 Pagos con MercadoPago

La API integra **MercadoPago** para la gestión de pagos:

- Creación de preferencias de pago
- Manejo de notificaciones (webhooks)
- Validación del estado de transacciones

> ⚠️ Las credenciales de MercadoPago se gestionan exclusivamente por variables de entorno.

---

## 🐘 Base de Datos

- **PostgreSQL** como motor de base de datos
- **Entity Framework Core** para el acceso a datos
- Migraciones controladas por código

---

## 🐳 Docker

El proyecto está preparado para ejecutarse en contenedores mediante **Docker**:

### Levantar el entorno

```bash
docker-compose up -d
