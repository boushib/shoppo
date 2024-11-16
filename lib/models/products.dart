import "package:flutter/foundation.dart";
import "package:shop/models/product.dart";
import "package:shop/services/mongo.dart";

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products {
    return [..._products];
  }

  List<Product> get favoriteProducts {
    return [];
  }

  Future<String> addProduct(Product p) async {
    // var res = await http.post(
    //   url as Uri,
    //   body: json.encode({
    //     "title": p.title,
    //     "description": p.description,
    //     "price": p.price,
    //     "imageUrl": p.image_url,
    //     "isFavorite": false,
    //   }),
    // );

    // Product product = Product(
    //   id: json.decode(res.body)["name"],
    //   title: p.title,
    //   description: p.description,
    //   price: p.price,
    //   image_url: p.image_url,
    //   category: p.category,
    //   brand: p.brand,
    //   quantity: p.quantity,
    //   created_at: p.created_at,
    //   updated_at: p.updated_at,
    // );
    // _products.insert(0, product);
    notifyListeners();
    //return product.id;
    return "";
  }

  Future<void> updateProduct(Product product) async {
    final productIndex = _products.indexWhere((p) => p.id == product.id);
    if (productIndex >= 0) {
      try {
        await MongoDB.update("products", product.id, {
          "title": product.title,
          "description": product.description,
          "price": product.price,
        });
        _products[productIndex] = product;
        notifyListeners();
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
  }

  void deleteProduct(String product_id) async {
    await MongoDB.deleteById("products", product_id);
    notifyListeners();
  }

  Future<Product?> getProductById(String product_id) async {
    final productRes = await MongoDB.findById("products", product_id);
    if (productRes == null) return null;
    return Product.fromMap({...productRes});
  }

  Future<void> fetchProducts() async {
    try {
      final productRes = await MongoDB.find("products");
      List<Product> products = [];

      for (var product in productRes) {
        products.add(Product.fromMap({...product}));
      }
      _products = products;
      notifyListeners();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }
}
