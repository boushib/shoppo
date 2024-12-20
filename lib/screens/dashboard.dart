import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/products.dart';
import 'package:shop/screens/add_product.dart';
import 'package:shop/widgets/dashboard_product_item.dart';

class DashboardScreen extends StatelessWidget {
  static const route = 'dashboard-products';

  const DashboardScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).products;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddProductScreen.route);
            },
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(
              child: Text(
                "No Products found!",
                style: TextStyle(fontSize: 18),
              ),
            )
          : RefreshIndicator(
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
