import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/aarti_model.dart';
import '../providers/language_provider.dart';
import '../services/firestore_service.dart';

class AartiListScreen extends StatelessWidget {
  final String godId;
  final String godName;

  const AartiListScreen({
    super.key,
    required this.godId,
    required this.godName,
  });

  @override
  Widget build(BuildContext context) {
    final langCode =
        context.watch<LanguageProvider>().locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(godName),
        centerTitle: true,
      ),
      body: FutureBuilder<List<AartiModel>>(
        future: FirestoreService().getAartis(godId, langCode),
        builder: (context, snapshot) {
          // ⏳ LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ EMPTY
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Aartis found"));
          }

          final aartis = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: aartis.length,
            separatorBuilder: (_, __) =>
            const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final aarti = aartis[index];

              return Card(
                elevation: 3,
                child: ListTile(
                  title: Text(
                    aarti.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing:
                  const Icon(Icons.chevron_right),
                  onTap: () {
                    // 🔜 NEXT: Aarti detail screen
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
