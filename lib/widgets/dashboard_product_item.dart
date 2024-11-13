import 'package:flutter/material.dart';
import 'package:shop/models/products.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class DashboardProductItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String image;

  const DashboardProductItem({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.image,
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
              backgroundColor: Theme.of(context).colorScheme.secondary,
              backgroundImage: NetworkImage(image),
              radius: 24.0,
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 70.0,
              ),
              IconButton(
                icon: const Icon(Icons.edit),
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
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  Provider.of<ProductsProvider>(context, listen: false)
                      .deleteProduct(id);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
