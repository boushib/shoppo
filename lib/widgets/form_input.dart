import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String? initialValue;
  final String hintText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final Function(String?) onSaved;
  final String? Function(String?)? validator;
  final VoidCallback? onFieldSubmitted;
  final TextInputType keyboardType;
  final int maxLines;

  const FormInput({
    this.initialValue,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    required this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 16.0,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.03),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
      ),
      cursorColor: Theme.of(context).primaryColor,
      style: const TextStyle(fontSize: 16),
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
      onFieldSubmitted: (_) => onFieldSubmitted?.call(),
    );
  }
}
