import "dart:convert";
import "package:flutter/foundation.dart";
import "package:shop/models/cart_item.dart";
import "package:shop/models/order.dart";
import "package:http/http.dart" as http;

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(
      {required List<CartItem> products, required double total}) async {
    const url = "https://flutter-shop-a416a.firebaseio.com/orders.json";
    final createdAt = DateTime.now();

    try {
      final res = await http.post(
        url as Uri,
        body: json.encode({
          "amount": total,
          "products": products
              .map((ci) => {
                    "productId": ci.productId,
                    "title": ci.title,
                    "quantity": ci.quantity,
                    "price": ci.price,
                    "imageUrl": ci.imageUrl,
                  })
              .toList(),
          "createdAt": createdAt.toIso8601String(),
        }),
      );

      final order = Order(
        id: json.decode(res.body)["name"],
        amount: total,
        products: products,
        createdAt: DateTime.now(),
      );
      _orders.insert(0, order);

      // clear cart
      notifyListeners();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<void> fetchOrders() async {
    const url = "https://flutter-shop-a416a.firebaseio.com/orders.json";
    final res = await http.get(url as Uri);
    final Map<String, dynamic> ordersData = json.decode(res.body);
    List<Order> orders = [];
    ordersData.forEach((orderId, orderData) {
      List<CartItem> products = (orderData["products"] as List<dynamic>)
          .map((item) => CartItem(
                id: "",
                productId: item["productId"],
                title: item["title"],
                quantity: item["quantity"],
                price: item["price"],
                imageUrl: item["imageUrl"],
              ))
          .toList();
      orders.add(Order(
        id: orderId,
        amount: orderData["amount"],
        products: products,
        createdAt: DateTime.parse(orderData["createdAt"]),
      ));
    });
    _orders = orders;
    notifyListeners();
  }
}
