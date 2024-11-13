import 'package:flutter/foundation.dart';
import 'package:shop/models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  final url = 'https://flutter-shop-a416a.firebaseio.com/products.json';
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favoriteProducts {
    return _products.where((p) => p.isFavorite).toList();
  }

  Future<String> addProduct(Product p) async {
    var res = await http.post(
      url as Uri,
      body: json.encode({
        'title': p.title,
        'description': p.description,
        'price': p.price,
        'imageUrl': p.imageUrl,
        'isFavorite': false,
      }),
    );

    Product product = Product(
      id: json.decode(res.body)['name'],
      title: p.title,
      description: p.description,
      price: p.price,
      imageUrl: p.imageUrl,
    );
    _products.insert(0, product);
    notifyListeners();
    return product.id;
  }

  Future<void> updateProduct(Product product) async {
    final productIndex = _products.indexWhere((p) => p.id == product.id);
    if (productIndex >= 0) {
      final url =
          'https://flutter-shop-a416a.firebaseio.com/products/${product.id}.json';
      try {
        await http.patch(
          url as Uri,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }),
        );
        _products[productIndex] = product;
        notifyListeners();
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
  }

  void deleteProduct(String productId) async {
    final url =
        'https://flutter-shop-a416a.firebaseio.com/products/$productId.json';
    await http.delete(url as Uri);
    // @todo
    // try optimistic delete/update
    _products.removeWhere((p) => p.id == productId);
    notifyListeners();
  }

  Product getProductById(id) {
    return _products.firstWhere((p) => p.id == id);
  }

  Future<void> fetchProducts() async {
    try {
      var res = await http.get(url as Uri);
      final Map<String, dynamic> productsData = json.decode(res.body);
      List<Product> products = [];
      productsData.forEach((productId, productData) {
        products.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite'],
          ),
        );
      });
      _products = products;
      notifyListeners();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }
}
