import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/god_model.dart';
import '../providers/language_provider.dart';
import '../services/firestore_service.dart';

class GodListScreen extends StatelessWidget {
  const GodListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langCode =
        context.watch<LanguageProvider>().locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Deities"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFFFE8C5),
        foregroundColor: const Color(0xFF3A2A1A),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE8C5),
              Color(0xFFFFB74D),
            ],
          ),
        ),
        child: FutureBuilder<List<GodModel>>(
          future: FirestoreService().getGods(
            languageCode: langCode,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No deities found"),
              );
            }

            final gods = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: gods.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 📱 perfect for mobile
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  final god = gods[index];
                  return _GodGridCard(
                    name: god.name,
                    image: "assets/images/${god.image}",
                    onTap: () {
                      // 🔜 NEXT STEP: Navigate to Aarti List
                      // Navigator.push(...)
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GodGridCard extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  const _GodGridCard({
    required this.name,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 6,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3A2A1A),
            ),
          ),
        ],
      ),
    );
  }
}
