import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/home/pages/scanner.page.dart';
import 'package:incosys/src/home/providers/almacen.provider.dart';
import 'package:incosys/src/home/widgets/almacen_dropdown.dart';
import 'package:incosys/src/shared/widgets/textfield_v1.dart';

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
    ref.read(almacenProvider.notifier).getAlmacenes();
  }

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
                child: AlmacenDropdown(
                  controller: almacenController,
                  list: ref.watch(almacenProvider),
                ),
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
