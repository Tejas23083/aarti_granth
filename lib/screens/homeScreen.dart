import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<Map<String, dynamic>> gods = [
    {"name": "Ganesh", "icon": Icons.self_improvement},
    {"name": "Shiva", "icon": Icons.temple_hindu},
    {"name": "Krishna", "icon": Icons.music_note},
    {"name": "Durga", "icon": Icons.shield},
    {"name": "Hanuman", "icon": Icons.flash_on},
    {"name": "Lakshmi", "icon": Icons.monetization_on},
    {"name": "Saraswati", "icon": Icons.menu_book},
    {"name": "Vishnu", "icon": Icons.auto_awesome},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A0E0E),

      // Drawer
      drawer: Drawer(
        backgroundColor: const Color(0xFF5C1A1A),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB8860B), Color(0xFFFFD700)],
                ),
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Color(0xFFB8860B),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Devotee",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Profile
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // Settings
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text(
                "Settings",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const Spacer(),

            const Divider(color: Colors.white30),

            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Arthigranth v1.0",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ],
        ),
      ),

      // AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFFB8860B),
        title: const Text(
          "Arthigranth",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Body
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          itemCount: gods.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5C1A1A),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color(0xFFFFD700), width: 1.5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
                      ),
                    ),
                    child: Icon(
                      gods[index]["icon"],
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    gods[index]["name"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
