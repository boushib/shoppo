import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const route = 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
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
