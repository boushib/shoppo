import 'package:flutter/cupertino.dart';
import 'package:shop/models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Hohner 6 String Acoustic Guitar, Right Handed, Natural (HAG250P)',
      description: 'This is product 1 description..',
      price: 59.99,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/71VvXiIDQwL._AC_SL1500_.jpg',
    ),
    Product(
      id: 'p2',
      title:
          '30" Natural Wood Guitar With Case and Accessories for Kids/Boys/Beginners',
      description: 'This is product 2 description..',
      price: 49.99,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/71YR8JFj-5L._AC_SL1500_.jpg',
    ),
    Product(
      id: 'p3',
      title:
          'Music Alley 6 String Junior Guitar, Right Handed, Natural (MA34-N)',
      description: 'This is product 1 description..',
      price: 46.99,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/81tQhEEtiEL._AC_SL1500_.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Music Alley MA-34-BL Acoustic Beginner Guitar Pack, Blue',
      description: 'This is product 1 description..',
      price: 79.99,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/8141isfCxJL._AC_SL1500_.jpg',
    ),
  ];

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favoriteProducts {
    return _products.where((p) => p.isFavorite).toList();
  }

  void addProduct(Product p) {
    // _products.add(product);
    Product product = Product(
      id: DateTime.now().toString(),
      title: p.title,
      description: p.description,
      price: p.price,
      imageUrl: p.imageUrl,
    );
    _products.insert(0, product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final productIndex = _products.indexWhere((p) => p.id == product.id);
    if (productIndex >= 0) {
      _products[productIndex] = product;
      notifyListeners();
    }
  }

  Product getProductById(id) {
    return _products.firstWhere((p) => p.id == id);
  }
}
