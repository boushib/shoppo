// ignore_for_file: non_constant_identifier_names

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String image_url;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.image_url,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map["id"] ?? "",
      title: map["title"] ?? "",
      quantity: map["quantity"] ?? 0,
      price: (map["price"] ?? 0).toDouble(),
      image_url: map["image_url"] ?? "",
    );
  }
}
