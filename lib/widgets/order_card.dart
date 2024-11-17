import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';
import 'package:shop/widgets/label.dart';

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  OrderCardState createState() => OrderCardState();
}

class OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    final amount = widget.order.amount.toStringAsFixed(2);
    final items = widget.order.products;
    final orderedAt = DateFormat("MMM dd, yyyy 'at' hh:mm").format(
      widget.order.created_at,
    );
    return Card(
      elevation: 0,
      color: Colors.white.withOpacity(.04),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Label(label: "Total"),
            const SizedBox(height: 8),
            Text(
              '\$$amount',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            const Label(label: "Ordered at"),
            const SizedBox(height: 8),
            Text(
              orderedAt,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            const Label(label: "Items"),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "* ${item.title}",
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
