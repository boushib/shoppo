import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';
import 'package:shop/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black.withOpacity(.8),
          title: Text(product.title),
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: product.isFavorite
                  ? Colors.red
                  : Colors.white.withOpacity(.6),
            ),
            onPressed: () {
              product.toggleIsFavorite();
            },
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              cart.addToCart(
                productId: product.id,
                title: product.title,
                price: product.price,
                quantity: 1,
                imageUrl: product.imageUrl,
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Product added to the cart!'),
                backgroundColor: Colors.green,
                action: SnackBarAction(
                  label: 'Undo',
                  textColor: Colors.white,
                  onPressed: () {
                    cart.removeSingleItemFromCart(product.id);
                  },
                ),
              ));
            },
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetailsScreen.route,
              arguments: product.id,
            );
          },
        ),
      ),
    );
  }
}
