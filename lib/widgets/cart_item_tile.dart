import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';

class CartItemTile extends StatelessWidget {
  final String cartItemId;
  final CartItem cartItem;

  const CartItemTile({
    super.key,
    required this.cartItemId,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Dismissible(
      key: ValueKey(cartItemId),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(Icons.delete, color: Colors.white, size: 40),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeItem(cartItemId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(cartItem.product.images.first), // Use the first image
            ),
            title: Text(cartItem.product.name),
            subtitle: Text('Total: \$${(double.parse(cartItem.product.price.replaceAll("\$", "")) * cartItem.quantity).toStringAsFixed(2)}'),
            trailing: Text('${cartItem.quantity} x'),
          ),
        ),
      ),
    );
  }
}
