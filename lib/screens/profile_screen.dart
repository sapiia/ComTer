import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'my_orders_screen.dart'; 
import 'edit_profile_screen.dart'; 

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.w700)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final user = userProvider.user;
          final theme = Theme.of(context);
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                // Profile Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user.avatar),
                        backgroundColor: theme.cardColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.name,
                        style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          user.bio,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Edit Profile Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen())),
                    child: const Text('Edit Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Menu Items
                _buildProfileMenu(
                  context,
                  title: "My Orders",
                  icon: Icons.receipt_long_outlined,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOrdersScreen())),
                ),
                _buildProfileMenu(
                  context,
                  title: "Settings",
                  icon: Icons.settings_outlined,
                  onTap: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.colorScheme.primary.withOpacity(0.1),
          ),
          child: Icon(icon, color: theme.colorScheme.primary, size: 20),
        ),
        title: Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: theme.textTheme.bodySmall?.color),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: theme.cardColor,
      ),
    );
  }
}
