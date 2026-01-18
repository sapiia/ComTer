import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart'; // Import the order provider

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _paymentMethod = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shipping Address', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address Line 1', border: OutlineInputBorder()),
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter your address' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'City', border: OutlineInputBorder()),
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter your city' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Postal Code', border: OutlineInputBorder()),
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter your postal code' : null,
              ),
              const SizedBox(height: 30),

              Text('Payment Method', style: Theme.of(context).textTheme.titleLarge),
              RadioListTile<String>(
                title: const Text('Credit Card'),
                value: 'Credit Card',
                groupValue: _paymentMethod,
                onChanged: (value) => setState(() => _paymentMethod = value!),
              ),
              RadioListTile<String>(
                title: const Text('PayPal'),
                value: 'PayPal',
                groupValue: _paymentMethod,
                onChanged: (value) => setState(() => _paymentMethod = value!),
              ),
              const SizedBox(height: 30),

              Text('Order Summary', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Add the order
                Provider.of<OrderProvider>(context, listen: false).addOrder(
                  cart.items.values.toList(),
                  cart.totalAmount,
                );
                // Clear the cart
                cart.clearCart();

                // Show confirmation and navigate home
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Order Placed!'),
                    content: const Text('Thank you for your purchase.'),
                    actions: [
                      TextButton(
                        child: const Text('Okay'),
                        onPressed: () {
                          Navigator.of(ctx).pop(); // Close the dialog
                          Navigator.of(context).pop(); // Go back from checkout
                        },
                      ),
                    ],
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            child: const Text('Place Order', style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
