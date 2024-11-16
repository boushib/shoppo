import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const route = 'add-product';

  const AddProductScreen({super.key});

  @override
  AddProductScreenState createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add a new product',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text('Add a new product'),
      ),
    );
  }
}
