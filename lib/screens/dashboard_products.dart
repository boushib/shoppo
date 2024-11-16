import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/products.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:shop/widgets/dashboard_product_item.dart';

class DashboardProductsScreen extends StatelessWidget {
  static const route = 'dashboard-products';

  const DashboardProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigator.pushNamed(context, AddProductScreen.route);
              Navigator.pushNamed(context, EditProductScreen.route);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, i) => DashboardProductItem(
              id: products[i].id,
              title: products[i].title,
              price: products[i].price,
              image: products[i].image_url,
            ),
          ),
        ),
      ),
    );
  }
}
