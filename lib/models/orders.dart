import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder({List<CartItem> products, double total}) async {
    final url = 'https://flutter-shop-a416a.firebaseio.com/orders.json';
    final createdAt = DateTime.now();

    try {
      final res = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'products': products
              .map((ci) => {
                    'productId': ci.productId,
                    'title': ci.title,
                    'quantity': ci.quantity,
                    'price': ci.price,
                    'imageUrl': ci.imageUrl,
                  })
              .toList(),
          'createdAt': createdAt.toIso8601String(),
        }),
      );

      final order = Order(
        id: json.decode(res.body)['name'],
        amount: total,
        products: products,
        createdAt: DateTime.now(),
      );
      _orders.insert(0, order);

      // clear cart
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  Future<void> fetchOrders() async {
    final url = 'https://flutter-shop-a416a.firebaseio.com/orders.json';
    final res = await http.get(url);
    final Map<String, dynamic> ordersData = json.decode(res.body);
    List<Order> orders = [];
    if (ordersData != null) {
      ordersData.forEach((orderId, orderData) {
        List<CartItem> products = (orderData['products'] as List<dynamic>)
            .map((item) => CartItem(
                  id: null,
                  productId: item['productId'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price'],
                  imageUrl: item['imageUrl'],
                ))
            .toList();
        orders.add(Order(
          id: orderId,
          amount: orderData['amount'],
          products: products,
          createdAt: DateTime.parse(orderData['createdAt']),
        ));
      });
    }
    _orders = orders;
    notifyListeners();
  }
}
