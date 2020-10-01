import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/products.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:shop/widgets/dashboard_product_item.dart';

class DashboardProductsScreen extends StatelessWidget {
  static const route = 'dashboard-products';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, i) => DashboardProductItem(
            id: products[i].id,
            title: products[i].title,
            price: products[i].price,
            image: products[i].imageUrl,
          ),
        ),
      ),
    );
  }
}
