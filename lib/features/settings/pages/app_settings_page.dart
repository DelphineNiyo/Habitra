import 'package:flutter/material.dart';
import '../../../app/colors.dart';
import '../../../app/text.dart';
import '../../../app/routes.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  String _theme = 'System Default';
  String _fontSize = 'Medium';
  TimeOfDay _reminderTime = const TimeOfDay(hour: 8, minute: 0);

  void _selectTheme() async {
    final theme = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('System Default'),
            onTap: () => Navigator.pop(context, 'System Default'),
          ),
          ListTile(
            title: const Text('Light'),
            onTap: () => Navigator.pop(context, 'Light'),
          ),
          ListTile(
            title: const Text('Dark'),
            onTap: () => Navigator.pop(context, 'Dark'),
          ),
        ],
      ),
    );
    if (theme != null) {
      setState(() {
        _theme = theme;
      });
    }
  }

  void _selectFontSize() async {
    final fontSize = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Small'),
            onTap: () => Navigator.pop(context, 'Small'),
          ),
          ListTile(
            title: const Text('Medium'),
            onTap: () => Navigator.pop(context, 'Medium'),
          ),
          ListTile(
            title: const Text('Large'),
            onTap: () => Navigator.pop(context, 'Large'),
          ),
        ],
      ),
    );
    if (fontSize != null) {
      setState(() {
        _fontSize = fontSize;
      });
    }
  }

  void _selectReminderTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (picked != null) {
      setState(() {
        _reminderTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.home);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Appearance'),
            _buildAppearanceSettings(),
            const SizedBox(height: 24),
            _buildSectionTitle('Notifications'),
            _buildNotificationSettings(),
            const SizedBox(height: 24),
            _buildSectionTitle('Data & Storage'),
            _buildDataSettings(),
            const SizedBox(height: 24),
            _buildSectionTitle('About'),
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: AppText.heading3.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildAppearanceSettings() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Theme'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_theme, style: AppText.bodySmall),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: _selectTheme,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: const Text('Font Size'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_fontSize, style: AppText.bodySmall),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: _selectFontSize,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Push Notifications'),
            trailing: Switch(
              value: _pushNotifications,
              onChanged: (value) {
                setState(() {
                  _pushNotifications = value;
                });
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text('Email Notifications'),
            trailing: Switch(
              value: _emailNotifications,
              onChanged: (value) {
                setState(() {
                  _emailNotifications = value;
                });
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Reminder Time'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_reminderTime.format(context), style: AppText.bodySmall),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: _selectReminderTime,
          ),
        ],
      ),
    );
  }

  Widget _buildDataSettings() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('Backup Data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to backup settings
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Clear Cache'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Handle clear cache
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Version'),
            trailing: const Text('1.0.0'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to privacy policy
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to terms of service
            },
          ),
        ],
      ),
    );
  }
} 