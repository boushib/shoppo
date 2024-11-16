import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final bool? isPrimary;
  final VoidCallback onPressed;
  const Button({
    super.key,
    required this.text,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.isPrimary = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final content = Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
    final style = ElevatedButton.styleFrom(
      backgroundColor:
          isPrimary! ? Theme.of(context).primaryColor : Colors.white,
      foregroundColor:
          isPrimary! ? Colors.white : Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36),
      ),
      padding: padding,
    );

    if (icon != null) {
      return ElevatedButton.icon(
        icon: Icon(icon),
        style: style,
        label: content,
        onPressed: onPressed,
      );
    }
    return ElevatedButton(
      style: style,
      onPressed: onPressed,
      child: content,
    );
  }
}
