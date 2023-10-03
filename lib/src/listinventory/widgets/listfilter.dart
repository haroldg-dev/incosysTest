import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incosys/src/listinventory/widgets/red_button.dart';
import 'package:incosys/src/shared/helpers/epartnet.icons.dart';
import 'package:incosys/src/listinventory/providers/listinventory.provider.dart';

class ListFilterDialog extends ConsumerStatefulWidget {
  const ListFilterDialog({super.key});

  @override
  ListFilterDialogState createState() => ListFilterDialogState();
}

class ListFilterDialogState extends ConsumerState<ListFilterDialog> {
  DateTime _dataTime = DateTime.now();
  //String fechaFiltro = "${_dataTime.year.toString().padLeft(4, '0')}-${_dataTime.month.toString().padLeft(2, '0')}-${_dataTime.day.toString().padLeft(2, '0')}"

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2077),
    ).then((value) {
      setState(() {
        _dataTime = value ?? DateTime.utc(2022, 10, 12);
      });
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    String fechaFiltro =
        "${_dataTime.year.toString().padLeft(4, '0')}-${_dataTime.month.toString().padLeft(2, '0')}-${_dataTime.day.toString().padLeft(2, '0')}";
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(EPartnerIcons.times, color: Color.fromRGBO(0, 0, 0, 1), size: 30)),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Por fecha',
                style: TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(242, 242, 242, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                onPressed: () {
                  _datePicker();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(242, 242, 242, 1)),
                    padding: MaterialStateProperty.resolveWith(
                        (states) => const EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    )),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      fechaFiltro,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )),
                    const Icon(EPartnerIcons.calendar_edit, size: 20, color: Colors.black),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            RedButton(
                text: "Filtrar",
                textColor: Colors.white,
                action: () {
                  print(_dataTime);
                  print(fechaFiltro);
                  ref.watch(inventarioListaProvider.notifier).getInventarioPorFecha(fechaFiltro);
                  /*
                  ref.watch(documentsProvider.notifier).getDocuments(DocumentFilter(
                      type: type,
                      date: "${_dataTime.year}-${_dataTime.month}-${_dataTime.day}",
                      state: secondType,
                      search: ""));
                      */
                })
          ],
        ),
      ),
    );
  }
}
