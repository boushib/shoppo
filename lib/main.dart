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
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

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
            //accentColor: Colors.amber,,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Open Sans'),
        home: const ProductsOverviewScreen(),
        routes: {
          ProductsOverviewScreen.route: (_) => const ProductsOverviewScreen(),
          ProductDetailsScreen.route: (_) => const ProductDetailsScreen(),
          CartScreen.route: (_) => const CartScreen(),
          OrdersScreen.route: (_) => const OrdersScreen(),
          DashboardProductsScreen.route: (_) => const DashboardProductsScreen(),
          AddProductScreen.route: (_) => const AddProductScreen(),
          EditProductScreen.route: (_) => const EditProductScreen(),
        },
      ),
    );
  }
}
