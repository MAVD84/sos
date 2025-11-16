# Blueprint de la Aplicación de Notificaciones

## Descripción General

Esta aplicación de Flutter tiene como propósito principal recibir y gestionar notificaciones push enviadas a través de OneSignal. Permite a los usuarios ver las notificaciones entrantes y consultar un historial de las notificaciones recibidas anteriormente, con la opción de gestionarlas e interactuar con ellas.

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
*   **Abrir Enlaces desde el Historial:**
    *   **Captura de URL:** La aplicación ahora captura la URL (`launchUrl`) que puede venir en una notificación de OneSignal.
    *   **Interacción en el Historial:** Las notificaciones que contienen una URL se pueden tocar. Al hacerlo, se abre el enlace en el navegador externo del dispositivo.
    *   **Indicador Visual:** Un icono de enlace distingue claramente las notificaciones interactivas de las que son solo informativas.

## Plan de Implementación Actual

**Estado:** ¡Completado!

**Última Funcionalidad Añadida: Abrir Enlaces desde Notificaciones**

1.  **Añadir Dependencia:** Se agregó `url_launcher` para manejar la apertura de URLs.
2.  **Actualizar Modelo:** Se modificó `NotificationModel` para incluir un campo opcional para la URL.
3.  **Capturar URL:** Se actualizó la lógica en `main.dart` para extraer y guardar la `launchUrl` al recibir una notificación.
4.  **Implementar Apertura de URL:** En `NotificationHistoryScreen`, se añadió la lógica para que al tocar una notificación, se abra la URL asociada usando `url_launcher`.
5.  **Añadir Indicador Visual:** Se agregó un icono para diferenciar las notificaciones con enlaces.
6.  **Actualizar el Blueprint:** Se ha documentado la nueva funcionalidad en este archivo.
