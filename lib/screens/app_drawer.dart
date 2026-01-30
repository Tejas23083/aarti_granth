import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          // 👤 PROFILE HEADER ONLY
          DrawerHeader(
            padding: EdgeInsets.zero, // IMPORTANT
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
            child: SizedBox(
              width: double.infinity, // 👈 FORCE FULL WIDTH
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 42,
                      color: Color(0xFF3A2A1A),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "My Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),


          // 📜 MENU ITEMS
          _drawerItem(Icons.home, "Home", () {}),
          _drawerItem(Icons.favorite, "Favorites", () {}),
          _drawerItem(Icons.calendar_today, "Festivals", () {}),
          _drawerItem(Icons.settings, "Settings", () {}),
          _drawerItem(Icons.info_outline, "About", () {}),
        ],
      ),
    );
  }

  Widget _drawerItem(
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF3A2A1A)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
