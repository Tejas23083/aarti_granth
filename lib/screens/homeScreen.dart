import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/language_provider.dart';
import '../models/god_model.dart';
import '../services/firestore_service.dart';

import 'app_drawer.dart';
import 'SettingsScreen.dart';
import 'GodListScreen.dart'; // ✅ ADD THIS

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<GodModel>> _godsFuture;

  @override
  void initState() {
    super.initState();
    _loadGods();
  }

  void _loadGods() {
    final langCode =
        context.read<LanguageProvider>().locale.languageCode;

    // 🔥 ONLY 5 GODS ON HOME
    _godsFuture = FirestoreService().getGods(
      languageCode: langCode,
      limit: 5,
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      _loadGods();
    });
    await _godsFuture;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      drawer: const AppDrawer(),
      body: Container(
        // ❌ DO NOT CHANGE – AS REQUESTED
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
        child: SafeArea(
          child: RefreshIndicator(
            color: Colors.orange,
            onRefresh: _onRefresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [

                // 🌟 APP BAR
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  expandedHeight: 110,
                  backgroundColor: Colors.transparent,
                  iconTheme: const IconThemeData(
                    color: Color(0xFF3A2A1A),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.settings_outlined),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: const EdgeInsets.only(bottom: 12),
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "AartiGranth",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3A2A1A),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "आरतीग्रन्थ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6D4C41),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 📦 BODY
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        _searchBar(loc),
                        const SizedBox(height: 10),

                        // 🔱 DEITIES + SEE ALL
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            _sectionTitle(loc.deities),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const GodListScreen(),
                                  ),
                                );

                              },
                              child: const Text(
                                "See all",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3A2A1A),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        _deitiesFromFirestore(),

                        const SizedBox(height: 24),
                        _aartiOfDay(loc),

                        const SizedBox(height: 24),
                        _sectionTitle(loc.popularAartis),
                        const SizedBox(height: 10),

                        _aartiTile(loc.sukhkarta),
                        _aartiTile(loc.omJaiShiv),
                        _aartiTile(loc.hanumanChalisa),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔍 SEARCH BAR
  Widget _searchBar(AppLocalizations loc) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          decoration: InputDecoration(
            hintText: loc.searchHint,
            border: InputBorder.none,
            icon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF3A2A1A),
      ),
    );
  }

  // 🔥 GODS FROM FIRESTORE
  Widget _deitiesFromFirestore() {
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<GodModel>>(
        future: _godsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No deities found"));
          }

          final gods = snapshot.data!;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: gods.length,
            itemBuilder: (context, index) {
              final god = gods[index];
              return _GodCard(
                name: god.name,
                image: "assets/images/${god.image}",
              );
            },
          );
        },
      ),
    );
  }

  // 🕉️ AARTI OF THE DAY
  Widget _aartiOfDay(AppLocalizations loc) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.aartiOfDay,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              loc.omJaiJagdish,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3A2A1A),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9800),
                ),
                child: Text(loc.read),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aartiTile(String title) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

// 🕉️ BIG GOD CARD
class _GodCard extends StatelessWidget {
  final String name;
  final String image;

  const _GodCard({
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3A2A1A),
            ),
          ),
        ],
      ),
    );
  }
}
