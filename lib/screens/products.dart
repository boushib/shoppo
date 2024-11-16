import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/products.dart';
import 'package:shop/screens/cart.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/products_overview_grid.dart';
import 'package:provider/provider.dart';

enum Filter { all, favorites }

class ProductsOverviewScreen extends StatefulWidget {
  static const route = 'products';

  const ProductsOverviewScreen({super.key});
  @override
  ProductsOverviewScreenState createState() => ProductsOverviewScreenState();
}

class ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoritesOnly = false;
  bool _isInit = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchProducts().then((_) {
        _isLoading = false;
      });
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          Consumer<Cart>(
            builder: (_, cart, __) => Badge(
              label: Text(
                cart.cartItemCount.toString(),
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).primaryColor),
              ),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(4),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.route);
              },
            ),
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: Filter.favorites,
                child: Text('Favorites'),
              ),
              const PopupMenuItem(
                value: Filter.all,
                child: Text('All Products'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
            onSelected: (val) {
              setState(() {
                _showFavoritesOnly = val == Filter.favorites;
              });
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductsOverviewGrid(showFavoritesOnly: _showFavoritesOnly),
    );
  }
}
