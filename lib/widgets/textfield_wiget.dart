import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {required this.label,
      required this.controller,
      required this.hintText,
      required this.icons,
      required this.hintPassword,
      Key? key})
      : super(key: key);
  late String label, hintText;
  late TextEditingController controller;
  late IconData icons;
  late bool hintPassword;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: hintPassword,
        decoration: InputDecoration(
            label: Text(label),
            hintText: hintText,
            border: const OutlineInputBorder(),
            prefixIcon: Icon(icons)),
      ),
    );
  }
}
