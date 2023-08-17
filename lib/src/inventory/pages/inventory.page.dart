import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/inventory/pages/scanner.page.dart';
import 'package:incosys/src/inventory/widgets/codigo_textfield.dart';

class InventoryPage extends ConsumerStatefulWidget {
  static const String name = 'inventory_page';

  const InventoryPage({super.key});

  @override
  InventoryPageState createState() => InventoryPageState();
}

class InventoryPageState extends ConsumerState<InventoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final codigoController = TextEditingController();
    final cantidadController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: PageView(
        children: [
          SafeArea(
              child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const AlmacenInventory(),
              const SizedBox(
                height: 5,
              ),
              const UbicacionInventory(),
              const SizedBox(
                height: 5,
              ),
              //Codigo
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                        child: CodigoTextField(
                      controller: codigoController,
                      name: "Codigo",
                    )),
                    IconButton(
                      icon: const Icon(Icons.qr_code_scanner),
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog.fullscreen(
                            child: ScannerPage(controller: codigoController)),
                      ),
                    ),
                  ],
                ),
              ),
              //Codigo
              const SizedBox(
                height: 5,
              ),
              //Descripcion
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0, color: Color.fromRGBO(255, 255, 255, 1)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFFDADADA)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF2F2F2),
                    hintText: 'Descripción',
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ),
              //Descripcion
              const SizedBox(
                height: 5,
              ),
              //Cantidad
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: TextField(
                  controller: cantidadController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0, color: Color.fromRGBO(255, 255, 255, 1)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFFDADADA)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF2F2F2),
                    hintText: 'Cantidad',
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ),
              //Cantidad
              const SizedBox(
                height: 5,
              ),
              //Observacion
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0, color: Color.fromRGBO(255, 255, 255, 1)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFFDADADA)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF2F2F2),
                    hintText: 'Observación',
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ),
              //Observacion
              const SizedBox(
                height: 5,
              ),
              //FOTOS

              const SizedBox(
                height: 5,
              ),
              //Buttons
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () {
                          context.go('/home');
                        },
                        child: const Text(
                          'Salir',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () {
                          context.go('/home');
                        },
                        child: const Text(
                          'Grabar',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

//ALMACEN NAME
class AlmacenInventory extends StatelessWidget {
  const AlmacenInventory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'AlmacenInventory Name',
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

//Ubicacion NAME
class UbicacionInventory extends StatelessWidget {
  const UbicacionInventory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'UbicacionInventory Name',
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
