import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';

class CartItemCard extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double total;
  final String image_url;

  const CartItemCard({
    super.key,
    required this.id,
    required this.title,
    required this.quantity,
    required this.total,
    required this.image_url,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeFromCart(id);
      },
      background: Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
        alignment: Alignment.centerRight,
        child: const Icon(
          color: Colors.white,
          Icons.delete,
        ),
      ),
      child: Consumer<Cart>(
        builder: (ctx, cart, child) {
          return cart.cart.containsKey(id)
              ? Card(
                  color: Colors.white.withOpacity(.04),
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 0,
                  ),
                  elevation: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    child: ListTile(
                      leading: Image.network(image_url),
                      title: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Text(
                        'x$quantity',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                )
              : Container();
        },
      ),
    );
  }
}
