import './product.dart';

class CartItem {
  final Product product;
  int quantity;
  final String? selectedRam;
  final String? selectedStorage;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedRam,
    this.selectedStorage,
  });
}
