import 'package:flutter/material.dart';

class CollectionEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CollectionEditor(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some information';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      maxLines: null,
    );
  }
}
