import 'package:flutter/material.dart';
import 'package:shop/models/products.dart';
import 'package:shop/screens/edit_product.dart';
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
      color: Colors.white.withOpacity(0.05),
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.white.withOpacity(0.05),
            child: Image.network(
              image,
              height: 280,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "\$$price",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      label: const Text(
                        'Edit',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          EditProductScreen.route,
                          arguments: id,
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.delete),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      label: const Text(
                        'Delete',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Provider.of<ProductsProvider>(
                          context,
                          listen: false,
                        ).deleteProduct(id);
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
