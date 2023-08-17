import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  final String text;
  final VoidCallback action;

  const BlackButton({super.key, required this.text, required this.action});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 64, 64, 64)),
        backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 2, 0, 0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
          )
        )
      ),
      onPressed: () {
        action();
      }, 
      child: Container(
        padding: const EdgeInsets.symmetric( vertical: 12 ),
        child: Row(
          children: [
            const SizedBox( width: 10 ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle( 
                  color: Colors.white,
                  fontSize: 17,
                )
              ),
            )
          ],
        ),
      )
    );
  }
}