import 'package:aarti_granth/screens/SettingsScreen.dart';
import '../l10n/app_localizations.dart';
import 'app_drawer.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      drawer: const AppDrawer(),

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
        child: SafeArea(
          child: CustomScrollView(
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
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const SettingsScreen(),
                          transitionsBuilder: (_, animation, __, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1.0, 0.0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
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
                      const SizedBox(height: 20),

                      _sectionTitle(loc.deities),
                      const SizedBox(height: 12),
                      _deitiesRow(),

                      const SizedBox(height: 20),
                      _aartiOfDay(loc),

                      const SizedBox(height: 20),
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
    );
  }

  // 🔍 SEARCH
  static Widget _searchBar(AppLocalizations loc) {
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

  static Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF3A2A1A),
      ),
    );
  }

  static Widget _deitiesRow() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _GodCard("Ganesh", "assets/images/Ganesh.png"),
          _GodCard("Shiva", "assets/images/Shiva.png"),
          _GodCard("Hanuman", "assets/images/Hanuman.png"),
          _GodCard("Durga", "assets/images/Durga.png"),
          _GodCard("Vishnu", "assets/images/Vishnu.png"),
          _GodCard("Saraswati", "assets/images/Saraswati.png"),
          _GodCard("Lakshmi", "assets/images/Lakshmi.png"),
          _GodCard("Krishna", "assets/images/Krishna.png"),
        ],
      ),
    );
  }

  static Widget _aartiOfDay(AppLocalizations loc) {
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

  static Widget _aartiTile(String title) {
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

// 🕉️ GOD CARD
class _GodCard extends StatelessWidget {
  final String name;
  final String image;

  const _GodCard(this.name, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 70,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF3A2A1A),
            ),
          ),
        ],
      ),
    );
  }
}
