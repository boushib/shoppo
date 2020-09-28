import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder({List<CartItem> products, double total}) {
    print('adding order - total: $total  - products $products');
    final order = Order(
      id: DateTime.now().toString(),
      amount: total,
      products: products,
      createdAt: DateTime.now(),
    );
    _orders.insert(0, order);
    // clear cart
    notifyListeners();
  }
}
