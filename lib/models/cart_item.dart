// ignore_for_file: non_constant_identifier_names

class CartItem {
  final String id;
  final String product_id;
  final String title;
  final int quantity;
  final double price;
  final String image_url;

  CartItem({
    required this.id,
    required this.product_id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.image_url,
  });
}
