import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CodigoTextField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String name;

  const CodigoTextField(
      {super.key, required this.controller, required this.name});

  @override
  CodigoTextFieldState createState() => CodigoTextFieldState();
}

class CodigoTextFieldState extends ConsumerState<CodigoTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 0, color: Color.fromRGBO(255, 255, 255, 1)),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFFDADADA)),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          filled: true,
          fillColor: const Color(0xFFF2F2F2),
          hintText: widget.name,
        ),
        style: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.normal));
  }
}
