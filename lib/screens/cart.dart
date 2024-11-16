import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/orders.dart';
import 'package:shop/screens/orders.dart';
import 'package:shop/widgets/button.dart';
import 'package:shop/widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  static const route = 'cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final orders = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Cart',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  '\$${cart.total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.cart.length,
                itemBuilder: (_, i) {
                  final item = cart.cart.values.toList()[i];
                  return CartItemCard(
                    id: item.id,
                    product_id: item.product_id,
                    title: item.title,
                    quantity: item.quantity,
                    total: item.price * item.quantity,
                    image_url: item.image_url,
                  );
                },
              ),
            ),
            OrderButton(cart: cart, orders: orders),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    super.key,
    required this.cart,
    required this.orders,
  });

  final Cart cart;
  final Orders orders;

  @override
  OrderButtonState createState() => OrderButtonState();
}

class OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: () async {
        if (widget.cart.cart.isEmpty || _isLoading) return;

        setState(() {
          _isLoading = true;
        });

        Provider.of<Orders>(context, listen: false).addOrder(
          products: widget.cart.cart.values.toList(),
          total: widget.cart.total,
        );

        setState(() {
          _isLoading = false;
        });

        Provider.of<Cart>(context, listen: false).clearCart();
        Navigator.pushNamed(context, OrderScreen.route);
      },
      text: "Order Now",
    );
  }
}
