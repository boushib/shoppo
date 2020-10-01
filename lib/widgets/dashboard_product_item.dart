import 'package:flutter/material.dart';

class DashboardProductItem extends StatelessWidget {
  final String title;
  final double price;
  final String image;

  DashboardProductItem({
    @required this.title,
    @required this.price,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            subtitle: Text('Price: \$$price'),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              backgroundImage: NetworkImage(image),
              radius: 24.0,
            ),
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.edit), color: Colors.blue, onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }
}
