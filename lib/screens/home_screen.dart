import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const route = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Welcome'),
          FlatButton(
            child: Text('Products'),
            onPressed: () {
              //
            },
          )
        ],
      ),
    );
  }
}
