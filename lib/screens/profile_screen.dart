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
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final user = userProvider.user;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.avatar),
                ),
                const SizedBox(height: 12),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    user.bio,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700], fontStyle: FontStyle.italic),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen())),
                    child: const Text('Edit Profile'),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                _buildProfileMenu(context, title: "My Orders", icon: Icons.receipt_long, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOrdersScreen()));
                }),
                _buildProfileMenu(context, title: "Settings", icon: Icons.settings, onTap: () {}),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap, Color? textColor}) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blue.withOpacity(0.1),
        ),
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
}
