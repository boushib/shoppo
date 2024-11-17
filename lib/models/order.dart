import 'package:shop/models/cart_item.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime created_at;

  Order({
    required this.id,
    required this.amount,
    required this.products,
    required this.created_at,
  });

  factory Order.fromMap(Map<String, dynamic> data) {
    return Order(
      id: data["id"] ?? "",
      amount: data["amount"] ?? 0.0,
      products: List<CartItem>.from(
        (data["products"] as List).map((product) => CartItem.fromMap(product)),
      ),
      created_at:
          DateTime.parse(data["created_at"] ?? DateTime.now().toString()),
    );
  }
}
