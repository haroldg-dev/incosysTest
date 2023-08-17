import 'package:flutter/material.dart';
import 'package:incosys/src/shared/helpers/epartnet.icons.dart';

class CustomDropdown extends StatefulWidget {
  final List<String>? list;
  final String dropdownValue;

  const CustomDropdown({super.key, this.list, required this.dropdownValue});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String dropdownValue = widget.list!.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(EPartnerIcons.angle_down_small),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: const SizedBox(),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: widget.list!.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
