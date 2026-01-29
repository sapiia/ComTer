import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/preferences_provider.dart';
import '../providers/user_provider.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w700)),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Account'),
            _buildSettingsCard(context, [
              _buildSettingsTile(
                context,
                Icons.person_outline,
                'Edit Profile',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                ),
              ),
              _buildSettingsTile(
                context,
                Icons.lock_outline,
                'Change Password',
                () => _showChangePasswordDialog(context),
              ),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Preferences'),
            Consumer2<ThemeProvider, PreferencesProvider>(
              builder: (context, themeProvider, preferencesProvider, child) {
                return _buildSettingsCard(context, [
                  _buildSwitchTile(
                    context,
                    Icons.notifications_outlined,
                    'Push Notifications',
                    preferencesProvider.pushNotifications,
                    (value) => preferencesProvider.togglePushNotifications(value),
                  ),
                  _buildSwitchTile(
                    context,
                    Icons.email_outlined,
                    'Email Notifications',
                    preferencesProvider.emailNotifications,
                    (value) => preferencesProvider.toggleEmailNotifications(value),
                  ),
                  _buildSwitchTile(
                    context,
                    Icons.shopping_bag_outlined,
                    'Order Updates',
                    preferencesProvider.orderUpdates,
                    (value) => preferencesProvider.toggleOrderUpdates(value),
                  ),
                  _buildSwitchTile(
                    context,
                    Icons.dark_mode_outlined,
                    'Dark Mode',
                    themeProvider.themeMode == ThemeMode.dark,
                    (value) => themeProvider.toggleTheme(value),
                  ),
                  _buildPreferenceTile(
                    context,
                    Icons.language_outlined,
                    'Language',
                    preferencesProvider.language,
                    () => _showLanguageDialog(context),
                  ),
                  _buildPreferenceTile(
                    context,
                    Icons.attach_money_outlined,
                    'Currency',
                    preferencesProvider.currency,
                    () => _showCurrencyDialog(context),
                  ),
                ]);
              },
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Support'),
            _buildSettingsCard(context, [
              _buildSettingsTile(
                context,
                Icons.help_outline,
                'Help & Support',
                () => _showHelpDialog(context),
              ),
              _buildSettingsTile(
                context,
                Icons.info_outline,
                'About',
                () => _showAboutDialog(context),
              ),
              _buildSettingsTile(
                context,
                Icons.shield_outlined,
                'Privacy Policy',
                () => _showPrivacyPolicyDialog(context),
              ),
            ]),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.error,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => _showLogoutConfirmation(context),
                child: const Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 4.0),
      child: Text(title, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700, color: theme.colorScheme.primary)),
    );
  }

  Widget _buildSettingsCard(BuildContext context, List<Widget> children) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.cardColor,
      child: Column(
        children: List.generate(
          children.length,
          (index) => Column(
            children: [
              children[index],
              if (index < children.length - 1)
                Divider(
                  height: 1,
                  color: theme.dividerColor,
                  indent: 60,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary, size: 24),
      title: Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: theme.textTheme.bodySmall?.color),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildSwitchTile(BuildContext context, IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    final theme = Theme.of(context);
    return SwitchListTile(
      secondary: Icon(icon, color: theme.colorScheme.primary, size: 24),
      title: Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
      value: value,
      onChanged: onChanged,
      activeColor: theme.colorScheme.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildPreferenceTile(BuildContext context, IconData icon, String title, String value, VoidCallback onTap) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary, size: 24),
      title: Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
      subtitle: Text(value, style: theme.textTheme.bodySmall),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: theme.textTheme.bodySmall?.color),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final theme = Theme.of(context);
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool showCurrentPassword = false;
    bool showNewPassword = false;
    bool showConfirmPassword = false;
    String? errorMessage;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Change Password', style: theme.textTheme.titleLarge),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: currentPasswordController,
                  obscureText: !showCurrentPassword,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    hintText: 'Enter your current password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    suffixIcon: IconButton(
                      icon: Icon(showCurrentPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => showCurrentPassword = !showCurrentPassword),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: newPasswordController,
                  obscureText: !showNewPassword,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Enter your new password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    suffixIcon: IconButton(
                      icon: Icon(showNewPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => showNewPassword = !showNewPassword),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: !showConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your new password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    suffixIcon: IconButton(
                      icon: Icon(showConfirmPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => showConfirmPassword = !showConfirmPassword),
                    ),
                  ),
                ),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      errorMessage!,
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  errorMessage = null;
                  if (currentPasswordController.text.isEmpty) {
                    errorMessage = 'Current password is required';
                  } else if (newPasswordController.text.isEmpty) {
                    errorMessage = 'New password is required';
                  } else if (newPasswordController.text.length < 6) {
                    errorMessage = 'Password must be at least 6 characters';
                  } else if (newPasswordController.text != confirmPasswordController.text) {
                    errorMessage = 'Passwords do not match';
                  } else if (currentPasswordController.text == newPasswordController.text) {
                    errorMessage = 'New password must be different from current password';
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password changed successfully!')),
                    );
                    Navigator.pop(context);
                  }
                });
              },
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final theme = Theme.of(context);
    final languages = ['English', 'Spanish', 'French', 'German', 'Chinese', 'Japanese'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Language', style: theme.textTheme.titleLarge),
        content: Consumer<PreferencesProvider>(
          builder: (context, preferencesProvider, _) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: languages
                    .map((lang) => RadioListTile<String>(
                          title: Text(lang),
                          value: lang,
                          groupValue: preferencesProvider.language,
                          onChanged: (value) {
                            if (value != null) {
                              preferencesProvider.setLanguage(value);
                              Navigator.pop(context);
                            }
                          },
                        ))
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showCurrencyDialog(BuildContext context) {
    final theme = Theme.of(context);
    final currencies = ['USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Currency', style: theme.textTheme.titleLarge),
        content: Consumer<PreferencesProvider>(
          builder: (context, preferencesProvider, _) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: currencies
                    .map((curr) => RadioListTile<String>(
                          title: Text(curr),
                          value: curr,
                          groupValue: preferencesProvider.currency,
                          onChanged: (value) {
                            if (value != null) {
                              preferencesProvider.setCurrency(value);
                              Navigator.pop(context);
                            }
                          },
                        ))
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Help & Support', style: theme.textTheme.titleLarge),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHelpItem(context, 'How do I place an order?', 'Browse products, add items to cart, and proceed to checkout to complete your order.'),
              _buildHelpItem(context, 'How do I track my order?', 'Go to "My Orders" to view order status and tracking information.'),
              _buildHelpItem(context, 'How do I return an item?', 'Contact support within 30 days of purchase with your order number and reason.'),
              _buildHelpItem(context, 'What is the shipping time?', 'Standard shipping takes 5-7 business days. Express shipping takes 2-3 business days.'),
              Divider(color: theme.dividerColor),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Icon(Icons.email_outlined, color: theme.colorScheme.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Contact Us', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                          Text('support@shoppingapp.com', style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(BuildContext context, String question, String answer) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(answer, style: theme.textTheme.bodySmall, maxLines: 3, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('About', style: theme.textTheme.titleLarge),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(Icons.shopping_bag, size: 64, color: theme.colorScheme.primary),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text('Shopping App', style: theme.textTheme.titleLarge),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text('Version 1.0.0', style: theme.textTheme.bodySmall),
              ),
              const SizedBox(height: 24),
              Text('About Us', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(
                'Your one-stop shop for amazing products at great prices. We offer a wide selection of items with fast delivery and excellent customer service.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              Text('Built with', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text('Flutter • Provider • Material Design 3', style: theme.textTheme.bodySmall),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Privacy Policy', style: theme.textTheme.titleLarge),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPolicySection(context, '1. Information Collection', 'We collect information you provide directly, such as when you create an account or place an order.'),
              _buildPolicySection(context, '2. Data Usage', 'Your data is used to process orders, improve our service, and send you relevant information.'),
              _buildPolicySection(context, '3. Data Protection', 'We implement industry-standard security measures to protect your personal information.'),
              _buildPolicySection(context, '4. Third Parties', 'We do not share your personal information with third parties without your consent.'),
              _buildPolicySection(context, '5. Your Rights', 'You have the right to access, modify, or delete your personal data at any time.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicySection(BuildContext context, String title, String content) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(content, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout', style: theme.textTheme.titleLarge),
        content: Text('Are you sure you want to logout?', style: theme.textTheme.bodyLarge),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.error),
            onPressed: () {
              // Reset user data
              context.read<UserProvider>().resetUser();
              // Pop the settings screen and return to auth
              Navigator.of(context).pop();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
