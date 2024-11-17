// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _cart = {};
  Map<String, CartItem> get cart {
    return {..._cart};
  }

  int get cartItemCount {
    var count = 0;
    _cart.forEach((key, item) => count += item.quantity);
    return count;
  }

  double get total {
    var total = 0.0;
    _cart.forEach((key, item) => total += item.price * item.quantity);
    return total;
  }

  void addToCart({
    required String id,
    required String title,
    required double price,
    required int quantity,
    required String image_url,
  }) {
    if (_cart.containsKey(id)) {
      _cart.update(
        id,
        (oldItem) => CartItem(
          id: oldItem.id,
          title: oldItem.title,
          quantity: oldItem.quantity + quantity,
          price: oldItem.price,
          image_url: oldItem.image_url,
        ),
      );
    } else {
      _cart.putIfAbsent(
        id,
        () => CartItem(
          id: id,
          title: title,
          quantity: quantity,
          price: price,
          image_url: image_url,
        ),
      );
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    if (_cart.containsKey(productId)) {
      _cart.remove(productId);
      notifyListeners();
    }
  }

  void removeSingleItemFromCart(String productId) {
    if (_cart.containsKey(productId)) {
      if (_cart[productId]!.quantity > 1) {
        _cart.update(
          productId,
          (oldItem) => CartItem(
            id: oldItem.id,
            title: oldItem.title,
            quantity: oldItem.quantity - 1,
            price: oldItem.price,
            image_url: oldItem.image_url,
          ),
        );
      } else {
        _cart.remove(productId);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cart = {};
    notifyListeners();
  }
}
