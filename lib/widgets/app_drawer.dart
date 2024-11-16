import 'package:flutter/material.dart';
import 'package:shop/screens/dashboard.dart';
import 'package:shop/screens/orders.dart';
import 'package:shop/screens/products.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            AppBar(
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Shoppo',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(
                Icons.shop,
                size: 20,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
              title: Text(
                'Shop',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, ProductsOverviewScreen.route);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.payment,
                size: 20,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
              title: Text(
                'Orders',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, OrdersScreen.route);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shop_two,
                size: 20,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
              title: Text(
                'My products',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, DashboardScreen.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
