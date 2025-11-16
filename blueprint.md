# Blueprint de la Aplicación de Notificaciones

## Descripción General

Esta aplicación de Flutter tiene como propósito principal recibir y gestionar notificaciones push enviadas a través de OneSignal. Permite a los usuarios ver las notificaciones entrantes y consultar un historial de las notificaciones recibidas anteriormente, con la opción de gestionarlas.

## Características Implementadas

*   **Página de Inicio Estática:** Una pantalla principal que informa al usuario que la app está lista para recibir notificaciones.
*   **Integración con OneSignal:** El SDK de `onesignal_flutter` está integrado para la recepción de notificaciones push.
*   **Solicitud de Permisos:** La app solicita automáticamente los permisos para recibir notificaciones.
*   **Diseño Moderno y Limpio:** Una interfaz visualmente agradable con un degradado de fondo y tipografía clara.
*   **Historial de Notificaciones:**
    *   **Almacenamiento Local:** Las notificaciones recibidas se guardan de forma persistente en el dispositivo utilizando `shared_preferences`.
    *   **Pantalla de Historial:** Una nueva pantalla (`NotificationHistoryScreen`) muestra una lista de todas las notificaciones guardadas, con la más reciente primero.
    *   **Eliminar Notificaciones:** Los usuarios pueden eliminar notificaciones individualmente desde el historial.
    *   **Borrar Todo el Historial:** Un botón permite a los usuarios eliminar todas las notificaciones almacenadas de una sola vez, con un diálogo de confirmación.
*   **Navegación Intuitiva:** Un `FloatingActionButton` en la pantalla principal permite un acceso fácil y rápido a la pantalla del historial.

## Plan de Implementación Actual

**Estado:** ¡Completado!

**Última Funcionalidad Añadida: Historial de Notificaciones**

1.  **Añadir Dependencias:** Se agregó `shared_preferences` para el almacenamiento local y `uuid` para generar identificadores únicos.
2.  **Crear Modelo de Datos:** Se definió la clase `NotificationModel` para estructurar los datos de cada notificación.
3.  **Implementar Servicio de Notificaciones:** Se creó `NotificationService` para manejar la lógica de guardar, cargar y eliminar notificaciones.
4.  **Integrar con OneSignal:** Se actualizó `main.dart` para que las notificaciones entrantes se guarden automáticamente a través del `NotificationService`.
5.  **Diseñar Pantalla de Historial:** Se creó `NotificationHistoryScreen` para visualizar y gestionar el historial de notificaciones.
6.  **Añadir Navegación:** Se integró un botón flotante en la pantalla principal para navegar al historial.
7.  **Actualizar el Blueprint:** Se ha documentado la nueva funcionalidad en este archivo.
