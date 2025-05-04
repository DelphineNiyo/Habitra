import 'package:flutter/material.dart';
import '../../../app/colors.dart';
import '../../../app/text.dart';
import '../../../app/routes.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
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
            _buildSectionTitle('Personal Information'),
            _buildPersonalInfoSection(),
            const SizedBox(height: 24),
            _buildSectionTitle('Security'),
            _buildSecuritySection(),
            const SizedBox(height: 24),
            _buildSectionTitle('Account Actions'),
            _buildAccountActionsSection(),
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

  Widget _buildPersonalInfoSection() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Edit Profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to edit profile page
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text('Change Email'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to change email page
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.phone_outlined),
            title: const Text('Phone Number'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to phone number settings
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to change password page
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text('Two-Factor Authentication'),
            trailing: Switch(
              value: false,
              onChanged: (value) {
                // Handle 2FA toggle
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.devices_outlined),
            title: const Text('Connected Devices'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to connected devices page
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountActionsSection() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: const Text('Download Data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Handle data download
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Delete Account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Show delete account confirmation
            },
          ),
        ],
      ),
    );
  }
} 