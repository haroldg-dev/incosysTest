import 'package:flutter/material.dart';
import 'package:incosys/src/apis/listinventory/listinventory.entity.dart';

class ListInventoryOption extends StatelessWidget {
  final ListInventory document;
  final Color color;

  const ListInventoryOption({
    super.key,
    required this.document,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(180, 200, 255, 0.2),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.nomAlmacen.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Text(
                    //todo: no se sabe si se va a quedar codBarra ya que hay nulls, en la aplicacion se representan 12345678
                    document.nomArticulo.length > 20 ? document.nomArticulo.substring(0, 20) : document.nomArticulo,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      height: 0,
                    ),
                  ),
                  Text(
                    //todo: no se sabe si se va a quedar codBarra ya que hay nulls, en la aplicacion se representan 12345678
                    document.nomUbicacion,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 0,
                    ),
                  )
                ],
              )),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.greenAccent.shade400,
                  ),
                  child: Text(
                    document.codArticulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 2,
                    ),
                  ),
                ),
                Text(
                  ' ${document.cantidad.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ]),
            ],
          ),
        ));
  }
}
