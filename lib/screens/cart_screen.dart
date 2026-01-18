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
        title: const Text('Your Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Text('Your cart is empty.', style: TextStyle(fontSize: 18)),
            );
          }

          return Column(
            children: [
              // Cart Items List
              Expanded(
                child: ListView.builder(
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
              const SizedBox(height: 10),

              // Order Summary
              Card(
                margin: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Total', style: TextStyle(fontSize: 20)),
                      const Spacer(),
                      Chip(
                        label: Text(
                          '\$${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                          ),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      TextButton(
                        child: const Text('ORDER NOW'),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CheckoutScreen(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
