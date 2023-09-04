import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/home/pages/scanner.page.dart';
import 'package:incosys/src/home/providers/almacen.provider.dart';
import 'package:incosys/src/home/providers/ubicacion.provider.dart';
import 'package:incosys/src/login/providers/seguridaduser.provider.dart';
import 'package:incosys/src/shared/navbar/widgets/navbar_drawer.dart';
import 'package:incosys/src/shared/widgets/textfield_v1.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String name = 'home_page';
  final String? user;
  final String? ruc;
  final String? pwd;
  const HomePage({
    super.key,
    this.user,
    this.ruc,
    this.pwd,
  });

  @override
  // ignore: no_logic_in_create_state
  HomePageState createState() => HomePageState(user, ruc, pwd);
}

class HomePageState extends ConsumerState<HomePage> {
  late String codAlmacen;
  late String nomAlmacen;
  final String? user;
  final String? ruc;
  final String? pwd;
  HomePageState(this.user, this.ruc, this.pwd);

  @override
  void initState() {
    super.initState();
    if (user != null) {
      ref.read(seguridadUserProvider.notifier).postLogin(
            ruc: ruc!,
            uid: user!,
            pwd: pwd!,
            afterLogged: () {
              codAlmacen = '';
              nomAlmacen = '';
              ref.read(almacenProvider.notifier).getAlmacenes();
            },
          );
    } else {
      codAlmacen = '';
      nomAlmacen = '';
      ref.read(almacenProvider.notifier).getAlmacenes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ubicacionController = TextEditingController();
    final conteoController = TextEditingController();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: const NavbarDrawer(),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/src/asset/images/fondopag3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView(
          children: [
            SafeArea(
                child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.menu),
                    onPressed: () => scaffoldKey.currentState?.openDrawer(),
                  ),
                ]),
                const SizedBox(
                  height: 80,
                ), //Almacen
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
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              hint: const Text(
                                "Seleccione almacen",
                                style: TextStyle(
                                    color: Color.fromRGBO(100, 100, 100, 1)),
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
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.white60),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              style: const TextStyle(
                                  color: Color.fromRGBO(100, 100, 100, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                              onChanged: (String? newValue) {
                                List<String> aux = newValue!.split('/');
                                codAlmacen = aux[0];
                                nomAlmacen = aux[1];
                                /* setState(() {
                                  
                                  //codAlmacen = newValue!;
                                }); */
                              },
                              items: ref
                                  .watch(almacenProvider)
                                  .map((op) => DropdownMenuItem(
                                        value:
                                            '${op.codAlmacen}/${op.nomAlmacen}',
                                        child: Text(
                                          op.nomAlmacen,
                                          style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  100, 100, 100, 1)),
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
                          onChanged: null,
                        ),
                      ),
                      IconButton(
                        color: const Color.fromRGBO(102, 102, 102, 1),
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
                    name: "Numero de Conteo",
                    type: TextInputType.number,
                    onChanged: null,
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
                              const Color.fromRGBO(51, 102, 102, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () {
                        if (codAlmacen != '' &&
                            ubicacionController.text != '' &&
                            conteoController.text != '') {
                          ref.read(ubicacionProvider.notifier).getUbicacion(
                              codAlmacen: codAlmacen,
                              nomUbicacion: ubicacionController.text,
                              nomAlmacen: nomAlmacen,
                              conteo: conteoController.text,
                              afterGetData: () {
                                if (ref.watch(ubicacionProvider).resultado !=
                                    'OK') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        ref.watch(ubicacionProvider).resultado),
                                  ));
                                } else {
                                  context.go('/inventario');
                                }
                              });
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
                            color: Colors.white),
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
