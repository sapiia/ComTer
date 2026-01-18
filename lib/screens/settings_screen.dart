import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Account'),
            _buildSettingsCard(context, [
              _buildSettingsTile(context, Icons.person_outline, 'Edit Profile', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()))),
              _buildSettingsTile(context, Icons.lock_outline, 'Change Password', () {}),
            ]),
            const SizedBox(height: 20),
            _buildSectionHeader(context, 'General'),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return _buildSettingsCard(context, [
                  _buildSwitchTile(context, Icons.notifications_outlined, 'Push Notifications', true, (value) {}), // Placeholder
                  _buildSwitchTile(context, Icons.dark_mode_outlined, 'Dark Mode', themeProvider.themeMode == ThemeMode.dark, (value) {
                    themeProvider.toggleTheme(value);
                  }),
                ]);
              },
            ),
            const SizedBox(height: 20),
            _buildSectionHeader(context, 'Feedback & Information'),
            _buildSettingsCard(context, [
              _buildSettingsTile(context, Icons.help_outline, 'Help & Support', () {}),
              _buildSettingsTile(context, Icons.info_outline, 'About', () {}),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSettingsCard(BuildContext context, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).cardColor,
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(BuildContext context, IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      secondary: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
