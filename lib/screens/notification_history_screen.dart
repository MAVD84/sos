import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/notification_model.dart';
import '../services/notification_service.dart';

class NotificationHistoryScreen extends StatefulWidget {
  const NotificationHistoryScreen({super.key});

  @override
  State<NotificationHistoryScreen> createState() =>
      _NotificationHistoryScreenState();
}

class _NotificationHistoryScreenState extends State<NotificationHistoryScreen> {
  final NotificationService _notificationService = NotificationService();
  List<NotificationModel> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final notifications = await _notificationService.loadNotifications();
    setState(() {
      _notifications = notifications.reversed.toList();
    });
  }

  Future<void> _deleteNotification(String id) async {
    await _notificationService.deleteNotification(id);
    _loadNotifications();
  }

  Future<void> _clearAllNotifications() async {
    await _notificationService.clearAllNotifications();
    _loadNotifications();
  }

  Future<void> _launchURL(String? urlString) async {
    if (urlString == null || urlString.isEmpty) return;

    final Uri uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo abrir el enlace: $urlString')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Notificaciones', style: GoogleFonts.poppins()),
        backgroundColor: Colors.deepPurple.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _showClearAllConfirmationDialog,
            tooltip: 'Borrar todo el historial',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade800, Colors.purple.shade800],
          ),
        ),
        child: _notifications.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.history_toggle_off, size: 80, color: Colors.white70),
                    const SizedBox(height: 16),
                    Text(
                      'No hay notificaciones',
                      style: GoogleFonts.poppins(fontSize: 18, color: Colors.white70),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  final hasUrl = notification.url != null && notification.url!.isNotEmpty;
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.black.withOpacity(0.2),
                    child: ListTile(
                      leading: Icon(
                        hasUrl ? Icons.link : Icons.notifications,
                        color: hasUrl ? Colors.lightBlueAccent : Colors.white70,
                      ),
                      title: Text(
                        notification.title,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(
                        notification.body,
                        style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8)),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => _deleteNotification(notification.id),
                      ),
                      onTap: () => _launchURL(notification.url),
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _showClearAllConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text('Confirmar', style: GoogleFonts.poppins(color: Colors.white)),
          content: Text(
            '¿Estás seguro de que quieres borrar todas las notificaciones? Esta acción no se puede deshacer.',
            style: GoogleFonts.poppins(color: Colors.white70),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: GoogleFonts.poppins(color: Colors.white70)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Borrar Todo', style: GoogleFonts.poppins(color: Colors.redAccent)),
              onPressed: () {
                _clearAllNotifications();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
