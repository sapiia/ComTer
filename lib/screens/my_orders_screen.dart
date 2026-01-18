// Applying a definitive fix for the RenderFlex overflow error.
// This version uses a ListView.builder for robust scrolling.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: orderData.orders.isEmpty
          ? const Center(
              child: Text(
                'You have no orders yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: orderData.orders.length,
              itemBuilder: (ctx, i) {
                final order = orderData.orders[i];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  elevation: 4,
                  color: const Color(0xFF1E1E1E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundColor: Colors.white24,
                      backgroundImage: order.products.isNotEmpty
                          ? NetworkImage(order.products.first.product.images.first)
                          : null,
                      child: order.products.isEmpty
                          ? const Icon(Icons.receipt, color: Colors.white)
                          : null,
                    ),
                    title: Text('\$${order.amount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      order.dateTime.toIso8601String().substring(0, 16).replaceAll('T', ' '),
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    children: order.products.map((prod) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(prod.product.images.first),
                        ),
                        title: Text(prod.product.name, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(
                          '${prod.selectedRam ?? ''} ${prod.selectedStorage ?? ''}'.trim(),
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        trailing: Text(
                          '${prod.quantity} x \$${prod.product.price.replaceAll("\$", "")}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
    );
  }
}
