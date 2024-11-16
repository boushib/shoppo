import 'package:flutter/material.dart';
import 'package:shop/models/products.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const route = 'product-details';

  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String product_id = ModalRoute.of(
      context,
    )?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: Provider.of<ProductsProvider>(
          context,
          listen: false,
        ).getProductById(product_id),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Product not found.'));
          } else {
            var product = snapshot.data;

            if (product == null) {
              return const Text("Product not found!");
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    product.image_url,
                    fit: BoxFit.cover,
                    height: 300.0,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text('Price: \$${product.price}'),
                        TextButton(
                          child: const Text(
                            'Order Now',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            //
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
