import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const route = 'add-product';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Text('Add a new product'),
        ),
      ),
    );
  }
}
