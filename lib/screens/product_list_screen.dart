import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_grid.dart';

class ProductListScreen extends StatelessWidget {
  final String title;
  final List<Product> products;

  const ProductListScreen({super.key, required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ProductGrid(products: products),
      ),
    );
  }
}
