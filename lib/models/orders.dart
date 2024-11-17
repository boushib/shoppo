import "package:flutter/foundation.dart";
import "dart:convert";
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:shop/models/cart_item.dart";
import "package:shop/models/order.dart";

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder({
    required List<CartItem> products,
    required double amount,
  }) async {
    try {
      final baseURI = dotenv.env["BASE_URL"];
      final res = await http.post(
        Uri.parse("$baseURI/orders"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "amount": amount,
          "products": products
              .map((product) => {
                    "id": product.id,
                    "title": product.title,
                    "quantity": product.quantity,
                    "price": product.price,
                    "image_url": product.image_url,
                  })
              .toList(),
        }),
      );
      _orders.add(Order.fromMap(jsonDecode(res.body)));
      notifyListeners();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<void> getOrders() async {
    try {
      final baseURI = dotenv.env["BASE_URL"];
      final res = await http.get(Uri.parse("$baseURI/orders"));
      _orders = List<Order>.from(
        (jsonDecode(res.body)["orders"] as List).map(
          (order) => Order.fromMap(order),
        ),
      );
      notifyListeners();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }
}
