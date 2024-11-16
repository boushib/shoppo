import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';
import 'package:shop/screens/product_details.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.route,
          arguments: product.id,
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Card(
        color: Colors.white.withOpacity(0.05),
        elevation: 0,
        clipBehavior:
            Clip.hardEdge, // Ensures content outside the border is clipped
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white.withOpacity(0.05),
              child: Image.network(
                product.image_url,
                height: 212,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "\$${product.price}",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.favorite),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        label: const Text(
                          'Like',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          // TODO - Toggle favorites
                        },
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_bag),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        label: const Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          cart.addToCart(
                            product_id: product.id,
                            title: product.title,
                            price: product.price,
                            quantity: 1,
                            image_url: product.image_url,
                          );
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Product added to the cart!',
                                style: TextStyle(fontSize: 16),
                              ),
                              backgroundColor: Colors.green.withOpacity(0.95),
                              action: SnackBarAction(
                                label: 'Undo',
                                textColor: Colors.white,
                                onPressed: () {
                                  cart.removeSingleItemFromCart(product.id);
                                },
                              ),
                              duration: const Duration(seconds: 4),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
