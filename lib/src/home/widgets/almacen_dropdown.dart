// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incosys/src/apis/almacen/entities/almacen.entity.dart';

class AlmacenDropdown extends ConsumerStatefulWidget {
  String? controller;
  List<Almacen> list;
  AlmacenDropdown({super.key, required this.controller, required this.list});

  @override
  AlmacenDropdownState createState() => AlmacenDropdownState();
}

class AlmacenDropdownState extends ConsumerState<AlmacenDropdown> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<String>(
            isExpanded: true,
            icon: const Icon(Icons.menu),
            hint: const Text("Seleccione almacen"),
            decoration: InputDecoration(
              label: const Text('Almacen'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            value: widget.controller,
            onChanged: (String? newValue) {
              setState(() {
                widget.controller = newValue;
              });
            },
            items: widget.list
                .map((op) => DropdownMenuItem(
                      value: op.codAlmacen.toString(),
                      child: Text(op.nomAlmacen),
                    ))
                .toList()));
  }
}
