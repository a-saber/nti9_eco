import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.readOnly,
    this.controller,
    this.onChanged,
    this.onTap,
  });

  final bool readOnly;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search any Product..',
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
      ),
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
