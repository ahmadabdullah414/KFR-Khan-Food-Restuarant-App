import 'package:flutter/material.dart';
import 'package:kfr/menu.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addItem(CartItem item) {
    // Check if the item is already in the cart
    int index = _cartItems.indexWhere((cartItem) => cartItem.name == item.name);
    if (index >= 0) {
      _cartItems[index].quantity += 1; // Increase quantity if item exists
    } else {
      _cartItems.add(item); // Add item if it does not exist
    }
    notifyListeners(); // Notify listeners to update the UI
  }

  void removeItem(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(0, (total, item) => total + (item.price * item.quantity));
  }
}
