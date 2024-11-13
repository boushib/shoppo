import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _cart = {};

  Map<String, CartItem> get cart {
    return {..._cart};
  }

  int get cartItemsCount {
    var count = 0;
    _cart.forEach((key, item) => count += item.quantity);
    return count;
  }

  double get total {
    var total = 0.0;
    _cart.forEach((key, item) => total += item.price * item.quantity);
    return total;
  }

  void addToCart(
      {required String productId,
      required String title,
      required double price,
      required int quantity,
      required String imageUrl}) {
    if (_cart.containsKey(productId)) {
      _cart.update(
        productId,
        (oldItem) => CartItem(
          id: oldItem.id,
          productId: oldItem.productId,
          title: oldItem.title,
          quantity: oldItem.quantity + quantity,
          price: oldItem.price,
          imageUrl: oldItem.imageUrl,
        ),
      );
    } else {
      _cart.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          productId: productId,
          title: title,
          quantity: quantity,
          price: price,
          imageUrl: imageUrl,
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
            productId: oldItem.productId,
            title: oldItem.productId,
            quantity: oldItem.quantity - 1,
            price: oldItem.price,
            imageUrl: oldItem.imageUrl,
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
