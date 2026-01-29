import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_tile.dart';
import 'checkout_screen.dart'; // Import the checkout screen

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart', style: TextStyle(fontWeight: FontWeight.w700)),
        elevation: 0,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  Text('Your cart is empty', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text('Add items to get started', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color)),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Cart Items List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) {
                    String cartItemId = cart.items.keys.elementAt(i);
                    final cartItem = cart.items.values.elementAt(i);
                    return CartItemTile(
                      cartItemId: cartItemId,
                      cartItem: cartItem,
                    );
                  },
                ),
              ),

              // Order Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Theme.of(context).dividerColor, width: 1)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal:', style: Theme.of(context).textTheme.bodyLarge),
                        Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Shipping:', style: Theme.of(context).textTheme.bodyMedium),
                        Text('Free', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Divider(color: Theme.of(context).dividerColor),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total:', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                        Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CheckoutScreen(),
                            ),
                          );
                        },
                        child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
