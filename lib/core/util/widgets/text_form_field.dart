import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final Widget suffixIcon;
  final String labelText;
  final bool readOnly;

  const MyTextFormField(
      {required this.controller,
      required this.hintText,
      required this.validator,
      required this.labelText,
      this.readOnly = false,
      this.suffixIcon = const Text(''),
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          cursorColor: Colors.black,
          keyboardType: keyboardType,
          validator: validator,
          readOnly: readOnly,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            suffixIcon: suffixIcon,
            hintText: hintText,
            // label: Text(labelText),
            // labelStyle: const TextStyle(
            //   color: Colors.black45,
            // ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
            hintStyle: const TextStyle(
                color: Colors.black45,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
          )),
    );
  }
}
