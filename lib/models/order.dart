import 'package:shop/models/cart_item.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.amount,
    required this.products,
    required this.createdAt,
  });
}
