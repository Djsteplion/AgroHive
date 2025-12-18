import 'package:flutter/material.dart';

class SizeDropdownStyled extends StatefulWidget {
  const SizeDropdownStyled({super.key});
  @override
  _SizeDropdownStyledState createState() => _SizeDropdownStyledState();
}

class _SizeDropdownStyledState extends State<SizeDropdownStyled> {
  // 👇 Default value is "Medium"
  String selectedSize = "Medium";

  // 👇 List of options
  final List<String> sizes = ["Small", "Medium", "Large"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButtonFormField<String>(
            value: selectedSize,
            decoration: InputDecoration(
              focusColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.grey),
  ),// default border
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
    )
  ), 
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
            items: sizes.map((String size) {
              return DropdownMenuItem<String>(
                value: size,
                child: Text(size),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedSize = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }
}
