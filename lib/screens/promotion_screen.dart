import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';
import '../widgets/sale_product_card.dart';

class PromotionScreen extends StatelessWidget {
  final Map<String, dynamic> promotionData;

  const PromotionScreen({super.key, required this.promotionData});

  @override
  Widget build(BuildContext context) {
    // Get only the products that are on sale
    final List<Product> saleProducts = allProducts.where((p) => p.oldPrice != null).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(promotionData['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              background: Image.network(
                promotionData['promo_image'],
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promotionData['subtitle'],
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      promotionData['description'],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[700], height: 1.5),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          // Use SliverList for the sale products
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SaleProductCard(product: saleProducts[index]),
                );
              },
              childCount: saleProducts.length,
            ),
          ),
        ],
      ),
    );
  }
}
