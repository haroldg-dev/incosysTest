// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/apis/ubicacion/entities/ubicacion.entity.dart';
import 'package:incosys/src/home/providers/ubicacion.provider.dart';
import 'package:incosys/src/inventory/pages/scanner.page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incosys/src/shared/widgets/textfield_v1.dart';

class InventoryPage extends ConsumerStatefulWidget {
  static const String name = 'inventory_page';

  const InventoryPage({super.key});

  @override
  InventoryPageState createState() => InventoryPageState();
}

class InventoryPageState extends ConsumerState<InventoryPage> {
  List<XFile>? fotoArticulos;
  XFile? etiqueta;
  late Ubicacion ubiSelected;
  final ImagePicker imgpicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    ubiSelected = ref.read(ubicacionProvider);
  }

  Future getImage(ImageSource media) async {
    var img = await imgpicker.pickImage(source: media);

    setState(() {
      etiqueta = img;
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        fotoArticulos = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final codigoController = TextEditingController();
    final descripcionController = TextEditingController();
    final cantidadController = TextEditingController();

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
                    child: const TextField(
                      decoration: InputDecoration(
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: 4,
                    ),
                  ),
                ),
                //Observacion
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Foto Etiqueta
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: SizedBox(
                        width: 130,
                        height: 130,
                        child: etiqueta != null
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
                                      File(etiqueta!.path),
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
                                    myAlert();
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
                                    myAlert();
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
                            vertical: 10, horizontal: 10),
                        child: SizedBox(
                          width: 130,
                          height: 130,
                          child: fotoArticulos != null
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
                                      children: fotoArticulos!.map((articulo) {
                                        return SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              //to show image, you type like this.
                                              File(articulo.path),
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
                                      openImages();
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
                                      openImages();
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
                const SizedBox(
                  height: 5,
                ),
                //Buttons
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
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
                            vertical: 10, horizontal: 10),
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
                              context.go('/');
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
