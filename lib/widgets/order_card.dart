import 'package:flutter/material.dart';
import 'package:shop/models/order.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
  final Order order;

  OrderCard({@required this.order});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Total \$${widget.order.amount}'),
            subtitle: Text(
                'Ordered at: ${DateFormat("dd MM yyyy hh:mm").format(widget.order.createdAt)}'),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              child: Text('details...'),
            ),
        ],
      ),
    );
  }
}
