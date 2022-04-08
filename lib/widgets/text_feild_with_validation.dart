import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  const InputForm({
    Key? key,
    this.validator,
    this.maxLines,
    this.hintText,
    this.fieldName,
    required this.keyboardType,
    required this.controller,
    this.obscure,
  }) : super(key: key);
  final Function? validator;
  final int? maxLines;
  final String? hintText;
  final String? fieldName;
  final TextInputType keyboardType;
  final bool? obscure;
  final TextEditingController controller;

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: input(),
    );
  }

  Widget input() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(10),
      ),
      validator: (String? value) {
        if (value!.trim().isEmpty) return 'Campo vacio';

        return null;
      },
      controller: widget.controller,
      obscureText: widget.obscure ?? false,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
    );
  }
}
