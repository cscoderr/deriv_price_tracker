import 'package:flutter/material.dart';

class DerivDropdownBox extends StatelessWidget {
  const DerivDropdownBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: '',
      isExpanded: true,
      items: const [
        DropdownMenuItem(
          value: '',
          child: Text('ETH'),
        ),
        DropdownMenuItem(
          value: 'eth',
          child: Text('ETH'),
        ),
        DropdownMenuItem(
          value: 'btc',
          child: Text('BTC'),
        ),
      ],
      onChanged: (value) {},
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
