import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/products.dart';
import 'package:shop/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductsOverviewGrid extends StatelessWidget {
  final bool showFavoritesOnly;
  const ProductsOverviewGrid({super.key, this.showFavoritesOnly = false});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final List<Product> products = showFavoritesOnly
        ? productsProvider.favoriteProducts
        : productsProvider.products;
    return GridView.builder(
      padding: const EdgeInsets.all(20.0),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0),
      // use the .value approach
      // if you're not instantiating a new object
      // but instead using an existing one
      itemBuilder: (_, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: const ProductCard(),
      ),
    );
  }
}
