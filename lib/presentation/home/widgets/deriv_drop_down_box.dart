import 'package:flutter/material.dart';

class DerivDropdownBox extends StatelessWidget {
  const DerivDropdownBox({
    Key? key,
    required this.items,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  final List<DropdownMenuItem> items;
  final String value;
  final ValueChanged<dynamic>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
      value: value,
      isExpanded: true,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(
          fontSize: 12,
          color: Colors.black.withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.33),
          ),
        ),
      ),
    );
  }
}
