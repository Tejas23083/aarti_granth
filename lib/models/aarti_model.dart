import 'package:cloud_firestore/cloud_firestore.dart';

class AartiModel {
  final String id;
  final String title;
  final String content;
  final int order;

  AartiModel({
    required this.id,
    required this.title,
    required this.content,
    required this.order,
  });

  factory AartiModel.fromFirestore(
      DocumentSnapshot doc,
      String langCode,
      ) {
    final data = doc.data() as Map<String, dynamic>;

    return AartiModel(
      id: doc.id,
      title: data['title'][langCode] ?? '',
      content: data['content'][langCode] ?? '',
      order: data['order'] ?? 0,
    );
  }
}
