import 'package:flutter/material.dart';
import 'package:shop/models/products.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const route = 'product-details';

  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final String productId = ModalRoute.of(context).settings.arguments;
    const String productId = "123";
    final product = Provider.of<ProductsProvider>(context, listen: false)
        .getProductById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              product.imageUrl,
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
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text('Price: \$${product.price}'),
                  TextButton(
                    child: const Text(
                      'Order Now',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      //
                    },
                    //color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
