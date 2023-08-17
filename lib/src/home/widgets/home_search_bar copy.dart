import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incosys/src/shared/helpers/epartnet.icons.dart';

class HomeSearchBar extends ConsumerStatefulWidget {
  final TextEditingController controller;

  const HomeSearchBar({super.key, required this.controller});

  @override
  HomeSearchBarState createState() => HomeSearchBarState();
}

class HomeSearchBarState extends ConsumerState<HomeSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(242, 242, 242, 1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          prefixIcon: const Icon(EPartnerIcons.search, size: 28),
          prefixIconColor: const Color.fromRGBO(0, 0, 0, 1),
        ),
        style: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.normal));
  }
}
