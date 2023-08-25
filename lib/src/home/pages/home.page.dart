import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/home/pages/scanner.page.dart';
import 'package:incosys/src/home/providers/almacen.provider.dart';
import 'package:incosys/src/home/providers/ubicacion.provider.dart';
import 'package:incosys/src/shared/widgets/textfield_v1.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String name = 'home_page';

  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  late String codAlmacen;
  late String nomAlmacen;
  @override
  void initState() {
    super.initState();
    codAlmacen = '';
    nomAlmacen = '';
    ref.read(almacenProvider.notifier).getAlmacenes();
  }

  @override
  Widget build(BuildContext context) {
    final ubicacionController = TextEditingController();
    final conteoController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/src/asset/images/fondopag2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView(
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
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black38,
                                blurRadius: 3.0,
                                spreadRadius: 0.6)
                          ]),
                      child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField<String>(
                              dropdownColor:
                                  const Color.fromRGBO(26, 47, 76, 1),
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              hint: const Text(
                                "Seleccione almacen",
                                style: TextStyle(color: Colors.white70),
                              ),
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0,
                                      color: Color.fromRGBO(26, 47, 76, 1)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                filled: true,
                                fillColor: Color.fromRGBO(26, 47, 76, 1),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.white60),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                              //value: codAlmacen != '' ? codAlmacen : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  List<String> aux = newValue!.split('/');
                                  codAlmacen = aux[0];
                                  nomAlmacen = aux[1];
                                  //codAlmacen = newValue!;
                                });
                              },
                              items: ref
                                  .watch(almacenProvider)
                                  .map((op) => DropdownMenuItem(
                                        value:
                                            '${op.codAlmacen}/${op.nomAlmacen}',
                                        child: Text(
                                          op.nomAlmacen,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ))
                                  .toList()))),
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
                        child: VersionOneTextField(
                          controller: ubicacionController,
                          name: "Ubicacion",
                          type: TextInputType.text,
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
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
                  child: VersionOneTextField(
                    controller: conteoController,
                    name: "Conteo",
                    type: TextInputType.number,
                  ),
                ),
                //Conteo
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(255, 180, 184, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () {
                        if (codAlmacen != '' &&
                            ubicacionController.text != '' &&
                            conteoController.text != '') {
                          ref
                              .read(ubicacionProvider.notifier)
                              .getUbicacion(
                                  codAlmacen, ubicacionController.text)
                              .then((value) => ());
                          if (ref.watch(ubicacionProvider).resultado != 'OK') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(ref.watch(ubicacionProvider).resultado),
                            ));
                          } else {
                            context.goNamed('inventario',
                                pathParameters: {'nomAlmacen': nomAlmacen});
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("Ventana  los campos son obligatorios"),
                          ));
                        }
                      },
                      child: const Text(
                        'Aceptar',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(19, 39, 66, 1)),
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
