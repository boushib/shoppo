import 'package:flutter/material.dart';
import 'package:shop/models/products.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/label.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const route = 'product-details';

  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String product_id =
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProductsProvider>(
          builder: (ctx, productsProvider, _) {
            return FutureBuilder(
              future: productsProvider.getProductById(product_id),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                    'Loading...',
                    style: TextStyle(fontSize: 20),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 20),
                  );
                } else if (!snapshot.hasData) {
                  return const Text(
                    'Product not found',
                    style: TextStyle(fontSize: 20),
                  );
                } else {
                  var product = snapshot.data;
                  return Text(
                    product?.title ?? 'Product Details',
                    style: const TextStyle(fontSize: 20),
                  );
                }
              },
            );
          },
        ),
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
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Label(label: "Title"),
                          const SizedBox(height: 8),
                          Text(
                            product.title,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 20.0),
                          const Label(label: "Price"),
                          const SizedBox(height: 8),
                          Text(
                            '\$${product.price}',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 20.0),
                          const Label(label: "Brand"),
                          const SizedBox(height: 8),
                          Text(
                            product.brand,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 20.0),
                          const Label(label: "Description"),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 16,
                              ),
                            ),
                            onPressed: () {
                              //
                            },
                            child: const Text(
                              'Order Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
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
