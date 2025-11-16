import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'models/notification_model.dart';
import 'services/notification_service.dart';
import 'screens/notification_history_screen.dart'; // Importa la nueva pantalla

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String _oneSignalAppId = 'abe3d400-0f44-4745-bd4c-6b609716662a';
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _initOneSignal();
  }

  Future<void> _initOneSignal() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(_oneSignalAppId);
    OneSignal.Notifications.requestPermission(true);

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      final notification = event.notification;
      _handleReceivedNotification(
        notification.notificationId,
        notification.title ?? 'Sin Título',
        notification.body ?? 'Sin Cuerpo',
      );
      event.preventDefault();
      notification.display();
    });
  }

  void _handleReceivedNotification(String id, String title, String body) {
    const uuid = Uuid();
    final notification = NotificationModel(
      id: uuid.v4(), // Genera un ID único
      title: title,
      body: body,
      receivedDate: DateTime.now(),
    );
    _notificationService.saveNotification(notification);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const NotificationInfoScreen(),
    );
  }
}

class NotificationInfoScreen extends StatelessWidget {
  const NotificationInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receptor de Notificaciones'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade800,
              Colors.purple.shade800,
              Colors.pink.shade800,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_active,
                  size: 80,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox(height: 32),
                Text(
                  'Notificaciones Activadas',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Esta aplicación está lista para recibir notificaciones importantes. Consulta el historial para ver las notificaciones pasadas.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationHistoryScreen()),
          );
        },
        backgroundColor: Colors.purple.shade400,
        child: const Icon(Icons.history, color: Colors.white),
        tooltip: 'Ver Historial',
      ),
    );
  }
}
