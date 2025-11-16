
import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  final String name;
  final String breed;
  final String imageUrl;
  final String location;
  final String age;
  final String phone; // Added phone number

  Pet({
    required this.name,
    required this.breed,
    required this.imageUrl,
    required this.location,
    required this.age,
    required this.phone, // Added to constructor
  });

  // Factory constructor to create a Pet object from a Firestore document
  factory Pet.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Pet(
      name: data['name'] ?? '',
      breed: data['breed'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      location: data['location'] ?? '',
      age: data['age'] ?? '',
      phone: data['phone'] ?? '', // Added phone from Firestore
    );
  }
}
