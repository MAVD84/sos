
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_pet/models/pet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mascotas Extraviadas'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Buscar por nombre, raza, o ubicación...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('lost_pets').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'Aún no hay mascotas reportadas.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          // Filter the documents based on the search query
          final filteredDocs = snapshot.data!.docs.where((doc) {
            final pet = Pet.fromFirestore(doc);
            final query = _searchQuery.toLowerCase();
            return pet.name.toLowerCase().contains(query) ||
                   pet.breed.toLowerCase().contains(query) ||
                   pet.location.toLowerCase().contains(query);
          }).toList();

          if (filteredDocs.isEmpty) {
            return const Center(
              child: Text(
                'No se encontraron resultados para tu búsqueda.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              final pet = Pet.fromFirestore(filteredDocs[index]);
              return PetCard(pet: pet);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/report'),
        label: const Text('Reportar'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            pet.imageUrl,
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()));
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 50, color: Colors.grey[600]));
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pet.name, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                const SizedBox(height: 8),
                Row(children: [Icon(Icons.pets, size: 16), const SizedBox(width: 8), Text(pet.breed)]),
                const SizedBox(height: 4),
                Row(children: [Icon(Icons.cake, size: 16), const SizedBox(width: 8), Text(pet.age)]),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: Colors.green[700]),
                    const SizedBox(width: 8),
                    Text(pet.phone, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                Row(children: [Icon(Icons.location_on, size: 16, color: Colors.redAccent), const SizedBox(width: 8), Expanded(child: Text('Se extravió en: ${pet.location}', style: TextStyle(fontStyle: FontStyle.italic)))]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
