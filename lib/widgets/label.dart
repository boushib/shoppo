import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String label;
  const Label({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16.0,
        color: Theme.of(context).textTheme.bodySmall!.color?.withOpacity(0.6),
      ),
    );
  }
}
