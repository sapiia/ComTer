import 'package:flutter/material.dart';
import 'category_products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Laptops', 'icon': Icons.laptop_mac},
      {'name': 'Desktops', 'icon': Icons.desktop_windows},
      {'name': 'Gaming PCs', 'icon': Icons.gamepad},
      {'name': 'Monitors', 'icon': Icons.monitor},
      {'name': 'Accessories', 'icon': Icons.mouse},
      {'name': 'Components', 'icon': Icons.memory},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Icon(category['icon'], size: 30, color: Theme.of(context).colorScheme.secondary),
              title: Text(category['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryProductsScreen(categoryName: category['name']!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
