import 'package:aarti_granth/screens/app_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

              // 🌟 ANIMATED APP BAR
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
                    onPressed: () {},
                  ),
                ],

                // ❌ REMOVE THIS (important)
                // title: const Text("AartiGranth"),

                // ✅ KEEP ONLY THIS
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


              // 📦 BODY CONTENT
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      _searchBar(),
                      const SizedBox(height: 20),
                      _sectionTitle("Deities"),
                      const SizedBox(height: 12),
                      _deitiesRow(),
                      const SizedBox(height: 20),
                      _aartiOfDay(),
                      const SizedBox(height: 20),
                      _sectionTitle("Popular Aartis"),
                      const SizedBox(height: 10),
                      _aartiTile("Sukhkarta Dukhaharta"),
                      _aartiTile("Om Jai Shiv Omkara"),
                      _aartiTile("Hanuman Chalisa"),
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
  static Widget _searchBar() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search Aarti or God name",
            border: InputBorder.none,
            icon: Icon(Icons.search),
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

  static Widget _aartiOfDay() {
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
            const Text(
              "Aarti of the Day",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            const Text(
              "Om Jai Jagdish Hare",
              style: TextStyle(
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
                  backgroundColor: Color(0xFFFF9800),
                ),
                child: const Text("Read"),
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
