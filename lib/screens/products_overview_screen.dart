import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/products.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/badge.dart';
import 'package:shop/widgets/products_overview_grid.dart';
import 'package:provider/provider.dart';

enum Filter { All, Favorites }

class ProductsOverviewScreen extends StatefulWidget {
  static const route = 'products';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoritesOnly = false;
  bool _isInit = false;
  bool _isLoading = false;

  @override
  void initState() {
    // this won't work
    // generally all '.of(context)'
    // set listen to false will work
    // Provider.of<ProductsProvider>(context).fetchProducts();

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
        title: Text('Products'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, __) => Badge(
              child: __,
              value: cart.cartItemsCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.route);
              },
            ),
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favorites'),
                value: Filter.Favorites,
              ),
              PopupMenuItem(
                child: Text('All Products'),
                value: Filter.All,
              ),
            ],
            icon: Icon(Icons.more_vert),
            onSelected: (val) {
              setState(() {
                _showFavoritesOnly = val == Filter.Favorites;
              });
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsOverviewGrid(showFavoritesOnly: _showFavoritesOnly),
    );
  }
}
