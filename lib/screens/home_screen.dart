import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const route = 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Welcome'),
          TextButton(
            child: const Text('Products'),
            onPressed: () {
              //
            },
          )
        ],
      ),
    );
  }
}
