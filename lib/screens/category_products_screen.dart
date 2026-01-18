import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';
import '../widgets/product_grid.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryProductsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts;

    if (categoryName == "All") {
      categoryProducts = allProducts;
    } else {
      categoryProducts = allProducts
          .where((product) => product.category == categoryName)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: categoryProducts.isEmpty
          ? const Center(
              child: Text('No products found in this category yet.'),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ProductGrid(products: categoryProducts),
            ),
    );
  }
}
