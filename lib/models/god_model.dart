import 'package:cloud_firestore/cloud_firestore.dart';

class GodModel {
  final String id;
  final String name;
  final String image;
  final int order;

  GodModel({
    required this.id,
    required this.name,
    required this.image,
    required this.order,
  });

  factory GodModel.fromFirestore(
      DocumentSnapshot doc,
      String languageCode,
      ) {
    final data = doc.data() as Map<String, dynamic>;

    return GodModel(
      id: doc.id,
      name: data['name'][languageCode] ??
          data['name']['en'], // fallback
      image: data['image'],
      order: data['order'],
    );
  }
}
