import 'package:flutter/material.dart';
import 'package:shop/screens/dashboard_products.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          // Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.pushNamed(context, ProductsOverviewScreen.route);
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.pushNamed(context, OrdersScreen.route);
            },
          ),
          ListTile(
            leading: Icon(Icons.shop_two),
            title: Text('My products'),
            onTap: () {
              Navigator.pushNamed(context, DashboardProductsScreen.route);
            },
          ),
        ],
      ),
    );
  }
}
