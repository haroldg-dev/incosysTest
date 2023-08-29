import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/apis/ubicacion/entities/ubicacion.entity.dart';
import 'package:incosys/src/home/providers/ubicacion.provider.dart';
import 'package:incosys/src/inventory/pages/scanner.page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incosys/src/inventory/providers/inventario.provider.dart';
import 'package:incosys/src/shared/widgets/textfield_v1.dart';

class InventoryPage extends ConsumerStatefulWidget {
  static const String name = 'inventory_page';

  const InventoryPage({super.key});

  @override
  InventoryPageState createState() => InventoryPageState();
}

class InventoryPageState extends ConsumerState<InventoryPage> {
  List<String> fotoArticulos = [];
  String etiqueta = '';
  late Ubicacion ubiSelected;
  final ImagePicker imgpicker = ImagePicker();
  final codigoController = TextEditingController();
  final descripcionController = TextEditingController();
  final cantidadController = TextEditingController();
  final observacionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    ubiSelected = ref.read(ubicacionProvider);
  }

  Future getImage(
    ImageSource media,
  ) async {
    var img = await imgpicker.pickImage(
        source: media, imageQuality: 50, maxHeight: 720);
    etiqueta = img!.path;
    setState(() {});
  }

  Future getListImages(ImageSource media) async {
    if (fotoArticulos.length < 4) {
      var img = await imgpicker.pickImage(
          source: media, imageQuality: 50, maxHeight: 720);
      fotoArticulos.add(img!.path);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Fotos de Articulos full"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromRGBO(26, 47, 76, 1),
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
                child: SingleChildScrollView(
                    child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                AlmacenInventory(nomAlmacen: ubiSelected.nomAlmacen),

                UbicacionInventory(nomUbicacion: ubiSelected.nomUbicacion),
                //Codigo
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: VersionOneTextField(
                          controller: codigoController,
                          name: "Codigo",
                          type: TextInputType.text,
                          onChanged: null,
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
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
                //Descripcion
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: VersionOneTextField(
                    controller: descripcionController,
                    name: "Descripcion",
                    type: TextInputType.multiline,
                    onChanged: (value) {
                      descripcionController.value = TextEditingValue(
                        text: value.toUpperCase(),
                        selection: descripcionController.selection,
                      );
                    },
                  ),
                ),
                //Descripcion
                //Cantidad
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: VersionOneTextField(
                    controller: cantidadController,
                    name: "Cantidad",
                    type: TextInputType.number,
                    onChanged: null,
                  ),
                ),
                //Cantidad
                //Observacion
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
                    child: TextField(
                      controller: observacionController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0, color: Color.fromRGBO(26, 47, 76, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.white60),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(26, 47, 76, 1),
                        hintText: "Observación",
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: 4,
                      onChanged: (value) {
                        observacionController.value = TextEditingValue(
                          text: value.toUpperCase(),
                          selection: observacionController.selection,
                        );
                      },
                    ),
                  ),
                ),
                //Observacion
                //Fotos
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Foto Etiqueta
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: SizedBox(
                        width: 130,
                        height: 130,
                        child: etiqueta != ''
                            ? Stack(fit: StackFit.expand, children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.white70,
                                            blurRadius: 5.0,
                                            spreadRadius: 0.9)
                                      ]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      //to show image, you type like this.
                                      File(etiqueta),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(26, 47, 76, 0.1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onPressed: () {
                                    getImage(ImageSource.camera);
                                  },
                                  child: const Text(
                                    'Etiqueta',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                              ])
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.white70,
                                          blurRadius: 5.0,
                                          spreadRadius: 0.9)
                                    ]),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(26, 47, 76, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onPressed: () {
                                    getImage(ImageSource.camera);
                                  },
                                  child: const Text(
                                    'Etiqueta',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    //Foto Etiqueta
                    //Fotos Articulo
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: SizedBox(
                          width: 130,
                          height: 130,
                          child: fotoArticulos.isNotEmpty
                              ? Stack(fit: StackFit.expand, children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            26, 47, 76, 0.7),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.white70,
                                              blurRadius: 5.0,
                                              spreadRadius: 0.9)
                                        ]),
                                    child: Wrap(
                                      spacing: 5,
                                      runSpacing: 5,
                                      alignment: WrapAlignment.center,
                                      runAlignment: WrapAlignment.center,
                                      children: fotoArticulos.map((articulo) {
                                        return SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              //to show image, you type like this.
                                              File(articulo),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            26, 47, 76, 0.1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    onPressed: () {
                                      getListImages(ImageSource.camera);
                                    },
                                    child: const Text(
                                      'Articulos',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ])
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.white70,
                                            blurRadius: 5.0,
                                            spreadRadius: 0.9)
                                      ]),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color.fromRGBO(26, 47, 76, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    onPressed: () {
                                      getListImages(ImageSource.camera);
                                    },
                                    child: const Text(
                                      'Articulos',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                        )),
                    //Fotos Articulo
                  ],
                ),
                //Fotos
                const SizedBox(
                  height: 5,
                ),
                //Buttons
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: SizedBox(
                          width: 130,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onPressed: () {
                              context.go('/');
                            },
                            child: const Text(
                              'Salir',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromRGBO(19, 39, 66, 1)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: SizedBox(
                          width: 130,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(255, 180, 184, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onPressed: () {
                              if (codigoController.text != '' &&
                                  descripcionController.text != '' &&
                                  cantidadController.text != '' &&
                                  etiqueta != '') {
                                ref
                                    .read(inventarioProvider.notifier)
                                    .setInventario(
                                        codAlmacen:
                                            ubiSelected.codAlmacen.toString(),
                                        codUbicacion:
                                            ubiSelected.codUbicacion.toString(),
                                        codArticulo: codigoController.text,
                                        nomArticulo: descripcionController.text,
                                        cantidad: cantidadController.text,
                                        observacion: observacionController.text,
                                        etiqueta: etiqueta,
                                        imagenes: fotoArticulos,
                                        afterSetData: () {
                                          if (ref
                                                  .watch(ubicacionProvider)
                                                  .resultado !=
                                              'OK') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(ref
                                                  .watch(ubicacionProvider)
                                                  .resultado),
                                            ));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Grabación Exitosa"),
                                            ));
                                            setState(() {
                                              codigoController.text = '';
                                              descripcionController.text = '';
                                              cantidadController.text = '';
                                              observacionController.text = '';
                                              etiqueta = '';
                                              fotoArticulos = [];
                                            });
                                          }
                                        });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "Ventana  los campos son obligatorios"),
                                ));
                              }
                            },
                            child: const Text(
                              'Grabar',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromRGBO(19, 39, 66, 1)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )))
          ],
        ),
      ),
    );
  }
}

//ALMACEN NAME
class AlmacenInventory extends StatelessWidget {
  String? nomAlmacen;
  AlmacenInventory({super.key, this.nomAlmacen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          nomAlmacen!,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

//Ubicacion NAME
class UbicacionInventory extends StatelessWidget {
  String? nomUbicacion;
  UbicacionInventory({super.key, this.nomUbicacion});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Ubicacion ${nomUbicacion!}",
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ));
  }
}
