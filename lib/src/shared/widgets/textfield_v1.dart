import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VersionOneTextField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String name;

  const VersionOneTextField(
      {super.key,
      required this.controller,
      required this.name,
      required this.type});

  @override
  VersionOneTextFieldState createState() => VersionOneTextFieldState();
}

class VersionOneTextFieldState extends ConsumerState<VersionOneTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 3.0, spreadRadius: 0.6)
          ]),
      child: TextField(
        controller: widget.controller,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 0, color: Color.fromRGBO(26, 47, 76, 1)),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.white60),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          filled: true,
          fillColor: const Color.fromRGBO(26, 47, 76, 1),
          hintText: widget.name,
          hintStyle: const TextStyle(color: Colors.white70),
        ),
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
        keyboardType: widget.type,
      ),
    );
  }
}
