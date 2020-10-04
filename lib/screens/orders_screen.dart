import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/order_card.dart';

class OrdersScreen extends StatefulWidget {
  static const route = 'orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(20.0),
              child: orders.length == 0
                  ? Text('No orders!')
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (_, i) => OrderCard(order: orders[i]),
                    ),
            ),
    );
  }
}
