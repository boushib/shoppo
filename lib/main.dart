import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/orders.dart';
import 'package:shop/models/products.dart';
import 'package:shop/screens/add_product_screen.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/dashboard_products.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/product_details_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.amber,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Open Sans'),
        home: ProductsOverviewScreen(),
        routes: {
          ProductsOverviewScreen.route: (_) => ProductsOverviewScreen(),
          ProductDetailsScreen.route: (_) => ProductDetailsScreen(),
          CartScreen.route: (_) => CartScreen(),
          OrdersScreen.route: (_) => OrdersScreen(),
          DashboardProductsScreen.route: (_) => DashboardProductsScreen(),
          AddProductScreen.route: (_) => AddProductScreen(),
          EditProductScreen.route: (_) => EditProductScreen(),
        },
      ),
    );
  }
}
