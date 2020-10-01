import 'package:flutter/material.dart';
import 'package:shop/screens/edit_product_screen.dart';

class DashboardProductItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String image;

  DashboardProductItem({
    @required this.id,
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
              SizedBox(
                width: 70.0,
              ),
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    EditProductScreen.route,
                    arguments: id,
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
