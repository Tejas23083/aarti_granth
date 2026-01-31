import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [

          // 👤 PROFILE
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: const Text("Profile"),
            subtitle: const Text("View or edit profile"),
            onTap: () {},
          ),

          const Divider(),

          // 🌐 LANGUAGE
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            subtitle: const Text("Change app language"),
          ),

          RadioListTile(
            value: 'en',
            groupValue: languageProvider.locale.languageCode,
            title: const Text("English"),
            onChanged: (value) {
              languageProvider.changeLanguage('en');
            },
          ),

          RadioListTile(
            value: 'hi',
            groupValue: languageProvider.locale.languageCode,
            title: const Text("हिंदी"),
            onChanged: (value) {
              languageProvider.changeLanguage('hi');
            },
          ),

          RadioListTile(
            value: 'mr',
            groupValue: languageProvider.locale.languageCode,
            title: const Text("मराठी"),
            onChanged: (value) {
              languageProvider.changeLanguage('mr');
            },
          ),
        ],
      ),
    );
  }
}
