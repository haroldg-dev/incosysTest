import 'package:flutter/material.dart';

class RedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback action;

  const RedButton({super.key, required this.text, required this.textColor, required this.action});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 0, 0, 0)),
            backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 0, 0, 0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)))),
        onPressed: () {
          action();
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 17,
                    )),
              )
            ],
          ),
        ));
  }
}
