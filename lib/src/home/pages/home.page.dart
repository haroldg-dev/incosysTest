import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/home/pages/scanner.page.dart';

import '../../shared/helpers/epartnet.icons.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String name = 'home_page';

  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  final almacenes = ['1', '2', '3'];

  @override
  Widget build(BuildContext context) {
    String? almacenController;
    final ubicacionController = TextEditingController();
    final conteoController = TextEditingController();

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
                height: 100,
              ),
              //Almacen
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                child: ButtonTheme(
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
                        value: almacenController,
                        onChanged: (String? newValue) {
                          setState(() {
                            almacenController = newValue;
                          });
                        },
                        items: almacenes
                            .map((op) => DropdownMenuItem(
                                  value: op,
                                  child: Text(op),
                                ))
                            .toList())),
              ),
              const SizedBox(
                height: 30,
              ),
              //Ubicacion
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: ubicacionController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0,
                                color: Color.fromRGBO(255, 255, 255, 1)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFFDADADA)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF2F2F2),
                          hintText: 'Ubicación',
                          prefixIcon: Icon(Icons.location_on_outlined),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.qr_code_scanner),
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog.fullscreen(
                            child:
                                ScannerPage(controller: ubicacionController)),
                      ),
                    ),
                  ],
                ),
              ),
              //Ubicacion
              const SizedBox(
                height: 30,
              ),
              //Conteo
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                child: TextField(
                  controller: conteoController,
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
                    hintText: 'Conteo',
                    prefixIcon: Icon(EPartnerIcons.layer_group,
                        color: Color.fromARGB(255, 0, 0, 0), size: 25),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              //Conteo
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 90),
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: double.infinity,
                  height: 55,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0)),
                    onPressed: () {
                      if (almacenController != '' &&
                          ubicacionController.text != '' &&
                          conteoController.text != '') {
                        context.go('/inventario');
                        /* ref.read(seguridadUserProvider.notifier).postLogin(
                        ruc: ruc.text, uid: user.text, pwd: password.text);
                    if (ref.watch(seguridadUserProvider).log != 'OK') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(ref.watch(seguridadUserProvider).log),
                      ));
                    } else {
                      context.go('/inventario');
                    } */
                      } else {
                        context.go('/inventario');
                        /* ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Ventana  los campos son obligatorios"),
                        )); */
                      }
                    },
                    child: const Text(
                      'Aceptar',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

//TITULO HOME
class TituloHome extends StatelessWidget {
  const TituloHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Home Page',
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
