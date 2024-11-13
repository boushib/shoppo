import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';

class CartItemCard extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double total;
  final String imageUrl;

  const CartItemCard({
    super.key,
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.total,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeFromCart(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Remove Product from Cart'),
            content:
                const Text('Are you sure you want to remove this product?'),
            insetPadding: const EdgeInsets.all(20.0),
            actions: [
              TextButton(
                child: const Text(
                  'Dismiss',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: const Text('Confirm'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      background: Container(
        //color: Theme.of(context).red,
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
        alignment: Alignment.centerRight,
        child: const Icon(
          color: Colors.white,
          Icons.delete,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: Image.network(imageUrl),
            title: Text(
              title,
              style: const TextStyle(fontSize: 14.0),
            ),
            subtitle: Text('Total: \$${total.toStringAsFixed(2)}'),
            trailing: Text('x$quantity'),
          ),
        ),
      ),
    );
  }
}
