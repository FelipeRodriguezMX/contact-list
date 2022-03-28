import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.label,
    this.keyboardType,
    // this.onChange,
    this.onSubmitted,
    required this.controller,
  }) : super(key: key);
  final String label;
  final TextInputType? keyboardType;
  final Function(String?)? onSubmitted;
  // final Function(String?)? onChange;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        child: input());
  }

  Widget input() {
    return TextField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      onSubmitted: onSubmitted,
      obscureText: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        isDense: true,
      ),
    );
  }
}
