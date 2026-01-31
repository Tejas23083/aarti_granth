import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/god_model.dart';
import '../models/aarti_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 🔱 GODS (HOME + GOD LIST)
  Future<List<GodModel>> getGods({
    required String languageCode,
    int? limit, // ✅ OPTIONAL LIMIT
  }) async {
    Query query = _db
        .collection('gods')
        .where('isActive', isEqualTo: true)
        .orderBy('order');

    // 🔥 Apply limit only if passed (Home Screen)
    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => GodModel.fromFirestore(doc, languageCode))
        .toList();
  }

  // 📿 AARTIS OF A GOD
  Future<List<AartiModel>> getAartis(
      String godId,
      String languageCode,
      ) async {
    final snapshot = await _db
        .collection('gods')
        .doc(godId)
        .collection('aartis')
        .where('isActive', isEqualTo: true)
        .orderBy('order')
        .get();

    return snapshot.docs
        .map((doc) => AartiModel.fromFirestore(doc, languageCode))
        .toList();
  }
}
