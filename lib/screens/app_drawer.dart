import 'package:aarti_granth/screens/GodListScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'SettingsScreen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          // 🔶 FULL WIDTH HEADER (FIXED)
          SizedBox(
            width: double.infinity,
            height: 220,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // 🕉️ LOGO
                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.temple_hindu,
                      size: 42,
                      color: Color(0xFF3A2A1A),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "AartiGranth",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3A2A1A),
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "आरतीग्रन्थ",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6D4C41),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 📜 MENU ITEMS
          _drawerItem(
            context,
            icon: Icons.home_outlined,
            title: "Home",
            onTap: () {
              Navigator.pop(context);
            },
          ),

          _drawerItem(
            context,
            icon: Icons.temple_hindu_outlined,
            title: "All Deities",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GodListScreen(),
                ),
              );
            },
          ),

          _drawerItem(
            context,
            icon: Icons.settings_outlined,
            title: "Settings",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),

          const Spacer(),

          // 🌙 DARK MODE TOGGLE
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return SwitchListTile(
                value: themeProvider.themeMode == ThemeMode.dark,
                title: const Text("Dark Mode"),
                secondary: const Icon(Icons.dark_mode_outlined),
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF3A2A1A)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
