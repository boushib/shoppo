import "dart:convert";
import "package:flutter/foundation.dart";
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:shop/models/product.dart";

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products {
    return [..._products];
  }

  List<Product> get favoriteProducts {
    return [];
  }

  Future<void> addProduct(Product product) async {
    final baseURI = dotenv.env["BASE_URL"];
    final res = await http.post(
      Uri.parse("$baseURI/products"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product.toMap()),
    );
    _products.add(Product.fromMap(jsonDecode(res.body)));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    try {
      final baseURI = dotenv.env["BASE_URL"];
      await http.patch(
        Uri.parse("$baseURI/products/${product.id}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(product.toMap()),
      );
      final index = _products.indexWhere((product) => product.id == product.id);
      _products[index] = product;
      notifyListeners();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      final baseURI = dotenv.env["BASE_URL"];
      await http.delete(Uri.parse("$baseURI/products/$productId"));
      final index = _products.indexWhere((product) => product.id == productId);
      _products.removeAt(index);
      notifyListeners();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<Product?> getProductById(String productId) async {
    try {
      final baseURI = dotenv.env["BASE_URL"];
      final res = await http.get(Uri.parse("$baseURI/products/$productId"));
      return Product.fromMap(jsonDecode(res.body));
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return null;
    }
  }

  Future<void> getProducts() async {
    try {
      final baseURI = dotenv.env["BASE_URL"];
      final res = await http.get(Uri.parse("$baseURI/products"));
      _products = List<Product>.from(
        jsonDecode(res.body)["products"].map(
          (product) => Product.fromMap(product),
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
