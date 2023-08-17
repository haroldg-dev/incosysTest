import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/inventory/pages/scanner.page.dart';
import 'package:incosys/src/inventory/widgets/codigo_textfield.dart';
import 'package:image_picker/image_picker.dart';

class InventoryPage extends ConsumerStatefulWidget {
  static const String name = 'inventory_page';

  const InventoryPage({super.key});

  @override
  InventoryPageState createState() => InventoryPageState();
}

class InventoryPageState extends ConsumerState<InventoryPage> {
  List<XFile>? fotoArticulos;
  XFile? etiqueta;

  final ImagePicker imgpicker = ImagePicker();

  @override
  void initState() {
    super.initState();
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
            title: Text('Please choose media to select'),
            content: Container(
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
    final cantidadController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: PageView(
        children: [
          SafeArea(
              child: SingleChildScrollView(
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
              //Foto Etiqueta
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: ElevatedButton(
                    onPressed: () {
                      myAlert();
                    },
                    child: const Text("Etiqueta")),
              ),
              etiqueta != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          //to show image, you type like this.
                          File(etiqueta!.path),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                      ),
                    )
                  : const Text(
                      "No Image",
                      style: TextStyle(fontSize: 20),
                    ),
              //Foto Etiqueta
              //Fotos Articulo
              fotoArticulos != null
                  ? Wrap(
                      children: fotoArticulos!.map((articulo) {
                        return Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.file(File(articulo.path)),
                          ),
                        );
                      }).toList(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      child: ElevatedButton(
                          onPressed: () {
                            openImages();
                          },
                          child: const Text("Articulos")),
                    ),

              //Fotos Articulo

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
                          context.go('/');
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
                          context.go('/');
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
          )))
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
