# Blueprint de la Aplicación de Notificaciones

## Descripción General

Esta aplicación de Flutter tiene como único propósito actuar como un cliente para recibir notificaciones push enviadas a través del servicio de OneSignal. No contiene ninguna otra funcionalidad interactiva para el usuario. Su diseño es minimalista y se centra en informar al usuario sobre su propósito.

## Características Implementadas

*   **Página de Inicio Estática:** Una única pantalla que informa al usuario que la aplicación está configurada para recibir notificaciones.
*   **Integración con OneSignal:** El SDK de `onesignal_flutter` está integrado y se inicializa al arrancar la aplicación.
*   **Solicitud de Permisos:** La aplicación solicita automáticamente los permisos necesarios para recibir notificaciones push en el dispositivo del usuario.
*   **Diseño Moderno y Limpio:** Una interfaz visualmente agradable con un degradado de fondo, tipografía clara y un ícono relevante.

## Plan de Implementación Actual

**Estado:** ¡Completado!

1.  **Simplificar `pubspec.yaml`:** Eliminar todas las dependencias innecesarias (como `cloud_firestore`, `firebase_storage`, `go_router`, `image_picker`).
2.  **Eliminar Archivos Antiguos:** Borrar los archivos de la estructura anterior (pantallas, modelos, enrutador, etc.).
3.  **Crear la Interfaz Principal:** Diseñar una pantalla estática en `lib/main.dart`.
4.  **Configurar OneSignal:** Añadir el código de inicialización de OneSignal en `lib/main.dart`.
5.  **Actualizar el Blueprint:** Documentar el nuevo y único propósito de la aplicación en este archivo.
