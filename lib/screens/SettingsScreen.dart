import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    final currentLang = languageProvider.locale.languageCode;
    final currentTheme = themeProvider.themeMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 👤 PROFILE
          _sectionTitle("Profile"),
          _settingsCard(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: const Text("My Profile"),
              subtitle: const Text("View or edit profile"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),

          const SizedBox(height: 24),

          // 🌐 LANGUAGE
          _sectionTitle("Language"),
          _languageTile(
            title: "English",
            value: 'en',
            groupValue: currentLang,
            onTap: () => languageProvider.changeLanguage('en'),
          ),
          _languageTile(
            title: "हिंदी",
            value: 'hi',
            groupValue: currentLang,
            onTap: () => languageProvider.changeLanguage('hi'),
          ),
          _languageTile(
            title: "मराठी",
            value: 'mr',
            groupValue: currentLang,
            onTap: () => languageProvider.changeLanguage('mr'),
          ),

          const SizedBox(height: 24),

          // 🌙 APPEARANCE
          _sectionTitle("Appearance"),
          _themeTile(
            title: "Light Mode",
            icon: Icons.light_mode,
            isSelected: currentTheme == ThemeMode.light,
            onTap: themeProvider.setLightMode,
          ),
          _themeTile(
            title: "Dark Mode",
            icon: Icons.dark_mode,
            isSelected: currentTheme == ThemeMode.dark,
            onTap: themeProvider.setDarkMode,
          ),
          _themeTile(
            title: "System Default",
            icon: Icons.settings,
            isSelected: currentTheme == ThemeMode.system,
            onTap: themeProvider.setSystemMode,
          ),

          const SizedBox(height: 30),

          // ℹ️ ABOUT
          _settingsCard(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("About AartiGranth"),
              subtitle: const Text("Version 1.0.0"),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 SECTION TITLE
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // 🔹 CARD WRAPPER
  Widget _settingsCard({required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }

  // 🌐 LANGUAGE TILE
  Widget _languageTile({
    required String title,
    required String value,
    required String groupValue,
    required VoidCallback onTap,
  }) {
    final isSelected = value == groupValue;

    return Card(
      elevation: isSelected ? 3 : 1,
      color: isSelected ? Colors.orange.withOpacity(0.15) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.orange)
            : const Icon(Icons.radio_button_unchecked),
        onTap: onTap,
      ),
    );
  }

  // 🌙 THEME TILE
  Widget _themeTile({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: isSelected ? 3 : 1,
      color: isSelected ? Colors.orange.withOpacity(0.15) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.orange)
            : null,
        onTap: onTap,
      ),
    );
  }
}
