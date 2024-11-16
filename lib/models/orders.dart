import "dart:convert";
import "package:flutter/foundation.dart";
import "package:shop/models/cart_item.dart";
import "package:shop/models/order.dart";
import "package:http/http.dart" as http;
import "package:shop/services/mongo.dart";

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder({
    required List<CartItem> products,
    required double total,
  }) async {
    try {
      await MongoDB.add("orders", {
        "amount": total,
        "products": products
            .map((product) => {
                  "product_id": product.id,
                  "title": product.title,
                  "quantity": product.quantity,
                  "price": product.price,
                  "image_url": product.image_url,
                })
            .toList(),
        "created_at": DateTime.now().toIso8601String(),
      });

      // final order = Order(
      //   id: json.decode(res.body)["name"],
      //   amount: total,
      //   products: products,
      //   createdAt: DateTime.now(),
      // );
      // _orders.insert(0, order);

      // clear cart
      notifyListeners();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<void> fetchOrders() async {
    final orderData = await MongoDB.find("orders");
    List<Order> orders = [];
    for (var order in orderData) {
      List<CartItem> products = (order["products"] as List<dynamic>)
          .map((item) => CartItem(
                id: "",
                product_id: item["product_id"],
                title: item["title"],
                quantity: item["quantity"],
                price: item["price"],
                image_url: item["image_url"],
              ))
          .toList();
      orders.add(Order(
        id: order["_id"],
        amount: order["amount"],
        products: products,
        created_at: DateTime.parse(order["created_at"]),
      ));
    }
    _orders = orders;
    notifyListeners();
  }
}
