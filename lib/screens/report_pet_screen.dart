
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportPetScreen extends StatefulWidget {
  const ReportPetScreen({super.key});

  @override
  State<ReportPetScreen> createState() => _ReportPetScreenState();
}

class _ReportPetScreenState extends State<ReportPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController(); // Controller for phone number

  File? _imageFile;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona una imagen de la mascota.')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final fileName = 'pets/${DateTime.now().millisecondsSinceEpoch}_${_nameController.text}.jpg';
      final storageRef = FirebaseStorage.instance.ref().child(fileName);
      final uploadTask = await storageRef.putFile(_imageFile!);
      final imageUrl = await uploadTask.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('lost_pets').add({
        'name': _nameController.text,
        'breed': _breedController.text,
        'age': _ageController.text,
        'location': _locationController.text,
        'phone': _phoneController.text, // Save phone number
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (!mounted) return; // Guard for async context usage

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reporte enviado con éxito!')),
      );
      context.pop();

    } catch (e) {
       if (!mounted) return; // Guard for async context usage
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al enviar el reporte: $e')),
      );
    } finally {
       if (mounted) { // Guard for async context usage
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    _locationController.dispose();
    _phoneController.dispose(); // Dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Mascota'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildImagePicker(),
                  const SizedBox(height: 24),
                  _buildTextFormField(_nameController, 'Nombre de la mascota'),
                  const SizedBox(height: 16),
                  _buildTextFormField(_breedController, 'Raza'),
                  const SizedBox(height: 16),
                  _buildTextFormField(_ageController, 'Edad'),
                  const SizedBox(height: 16),
                  _buildTextFormField(_locationController, 'Última ubicación conocida'),
                  const SizedBox(height: 16),
                  // Phone Number Field
                  _buildTextFormField(
                    _phoneController,
                    'Número de Teléfono de Contacto',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: _isUploading ? null : _submitReport,
                    icon: const Icon(Icons.send),
                    label: const Text('ENVIAR REPORTE'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isUploading)
            Container(
              color: Colors.black54, // Fixed deprecated member
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImagePicker() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
            child: _imageFile != null
                ? ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(_imageFile!, fit: BoxFit.cover))
                : const Center(child: Icon(Icons.pets, size: 80, color: Colors.grey)),
          ),
          const SizedBox(height: 10),
          TextButton.icon(onPressed: _pickImage, icon: const Icon(Icons.image), label: const Text('Seleccionar Imagen')),
        ],
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, completa este campo';
        }
        return null;
      },
    );
  }
}
