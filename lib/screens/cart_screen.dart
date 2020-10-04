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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
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
            SizedBox(
              height: 20.0,
            ),
            OrderButton(cart: cart, orders: orders),
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
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    @required this.cart,
    @required this.orders,
  });

  final Cart cart;
  final Orders orders;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.cart.cart.length == 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  products: widget.cart.cart.values.toList(),
                  total: widget.cart.total);
              setState(() {
                _isLoading = false;
              });
              Provider.of<Cart>(context, listen: false).clearCart();
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
    );
  }
}
