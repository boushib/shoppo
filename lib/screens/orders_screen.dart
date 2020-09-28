import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/order_card.dart';

class OrdersScreen extends StatelessWidget {
  static const route = 'orders';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (_, i) => OrderCard(order: orders[i]),
        ),
      ),
    );
  }
}
