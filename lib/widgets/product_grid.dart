import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/products.dart';
import 'package:shop/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final List<Product> products = productsProvider.products;

    if (products.isEmpty) {
      return const Center(
        child: Text(
          "No Products found!",
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(20.0),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemBuilder: (_, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: const ProductCard(),
      ),
    );
  }
}
