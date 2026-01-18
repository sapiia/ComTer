import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../screens/checkout_screen.dart';
import '../screens/product_details_screen.dart';

class SaleProductCard extends StatelessWidget {
  final Product product;

  const SaleProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final heroTag = 'sale-product-${product.name}';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product, heroTag: heroTag),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(product.images.first, height: 150, width: double.infinity, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 10),
              Text(product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(product.price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                  const SizedBox(width: 8),
                  if (product.oldPrice != null)
                    Text(product.oldPrice!, style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 5),
              if (product.promotionDeadline != null)
                Chip(
                  label: Text('Sale ends in ${product.promotionDeadline!.difference(DateTime.now()).inDays} days'),
                  backgroundColor: Colors.red.withOpacity(0.1),
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(onPressed: () {
                    cart.addItem(product);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart!'), duration: Duration(seconds: 2)));
                  }, child: const Text("Add to Cart")),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: () {
                    cart.addItem(product);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CheckoutScreen()));
                  }, child: const Text("Buy Now")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
