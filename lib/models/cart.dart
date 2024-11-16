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
    required String product_id,
    required String title,
    required double price,
    required int quantity,
    required String image_url,
  }) {
    if (_cart.containsKey(product_id)) {
      _cart.update(
        product_id,
        (oldItem) => CartItem(
          id: oldItem.id,
          product_id: oldItem.product_id,
          title: oldItem.title,
          quantity: oldItem.quantity + quantity,
          price: oldItem.price,
          image_url: oldItem.image_url,
        ),
      );
    } else {
      _cart.putIfAbsent(
        product_id,
        () => CartItem(
          id: DateTime.now().toString(),
          product_id: product_id,
          title: title,
          quantity: quantity,
          price: price,
          image_url: image_url,
        ),
      );
    }
    notifyListeners();
  }

  void removeFromCart(String product_id) {
    if (_cart.containsKey(product_id)) {
      _cart.remove(product_id);
      notifyListeners();
    }
  }

  void removeSingleItemFromCart(String product_id) {
    if (_cart.containsKey(product_id)) {
      if (_cart[product_id]!.quantity > 1) {
        _cart.update(
          product_id,
          (oldItem) => CartItem(
            id: oldItem.id,
            product_id: oldItem.product_id,
            title: oldItem.product_id,
            quantity: oldItem.quantity - 1,
            price: oldItem.price,
            image_url: oldItem.image_url,
          ),
        );
      } else {
        _cart.remove(product_id);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cart = {};
    notifyListeners();
  }
}
