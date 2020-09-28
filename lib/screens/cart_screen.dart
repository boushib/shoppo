import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/orders.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  static const route = 'cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final orders = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(20.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Chip(
                    label: Text(
                      '\$${cart.total.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              print('Ordering..');
              orders.addOrder(
                  products: cart.cart.values.toList(), total: cart.total);
              cart.clearCart();
              Navigator.pushNamed(context, OrdersScreen.route);
            },
            child: Text(
              'Order Now'.toUpperCase(),
              style: TextStyle(
                color: Colors.white.withOpacity(.8),
                fontSize: 12.0,
                letterSpacing: .5,
              ),
            ),
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.cart.length,
              itemBuilder: (_, i) {
                final item = cart.cart.values.toList()[i];
                return CartItemCard(
                  id: item.id,
                  productId: item.productId,
                  title: item.title,
                  quantity: item.quantity,
                  total: item.price * item.quantity,
                  imageUrl: item.imageUrl,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
