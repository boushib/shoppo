import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/order_card.dart';

class OrdersScreen extends StatefulWidget {
  static const route = 'orders';

  const OrdersScreen({super.key});

  @override
  OrdersScreenState createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<Orders>(context, listen: false)
        .fetchOrders()
        .then((_) => setState(() => _isLoading = false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: orders.isEmpty
                  ? const Center(
                      child: Text(
                        'No orders yet!',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (_, i) => OrderCard(order: orders[i]),
                    ),
            ),
    );
  }
}
