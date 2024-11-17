// ignore_for_file: non_constant_identifier_names
import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image_url;
  final String category;
  final String brand;
  final int quantity;
  final DateTime created_at;
  final DateTime updated_at;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image_url,
    required this.category,
    required this.brand,
    required this.quantity,
    required this.created_at,
    required this.updated_at,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data["id"] ?? "",
      title: data["title"] ?? "",
      description: data["description"] ?? "",
      price: (data["price"] ?? 0).toDouble(),
      image_url: data["image_url"] ?? "",
      category: data["category"] ?? "",
      brand: data["brand"] ?? "",
      quantity: data["quantity"] ?? 0,
      created_at:
          DateTime.parse(data["created_at"] ?? DateTime.now().toString()),
      updated_at:
          DateTime.parse(data["updated_at"] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "price": price,
      "image_url": image_url,
      "category": category,
      "brand": brand,
      "quantity": quantity,
      "created_at": created_at,
      "updated_at": updated_at,
    };
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? image_url,
    String? category,
    String? brand,
    int? quantity,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image_url: image_url ?? this.image_url,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }
}
