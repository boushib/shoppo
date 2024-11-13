import 'package:flutter/material.dart';
import 'package:shop/screens/dashboard_products.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          // Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.pushNamed(context, ProductsOverviewScreen.route);
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.pushNamed(context, OrdersScreen.route);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shop_two),
            title: const Text('My products'),
            onTap: () {
              Navigator.pushNamed(context, DashboardProductsScreen.route);
            },
          ),
        ],
      ),
    );
  }
}
