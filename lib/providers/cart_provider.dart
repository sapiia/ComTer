import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += double.parse(cartItem.product.price.replaceAll('\$', '')) * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product, {String? ram, String? storage}) {
    String itemId = product.name + (ram ?? '') + (storage ?? '');

    if (_items.containsKey(itemId)) {
      _items.update(
        itemId,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity + 1,
          selectedRam: existingCartItem.selectedRam,
          selectedStorage: existingCartItem.selectedStorage,
        ),
      );
    } else {
      _items.putIfAbsent(
        itemId,
        () => CartItem(
          product: product,
          selectedRam: ram,
          selectedStorage: storage,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity) {
    if (_items.containsKey(productId)) {
      if (newQuantity > 0) {
        _items.update(
          productId,
          (existingItem) => CartItem(
            product: existingItem.product,
            quantity: newQuantity,
            selectedRam: existingItem.selectedRam,
            selectedStorage: existingItem.selectedStorage,
          ),
        );
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
