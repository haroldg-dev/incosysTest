import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incosys/src/home/providers/articulos.provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:incosys/src/shared/helpers/epartnet.icons.dart';

class ScannerPage extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String modo;
  const ScannerPage({super.key, required this.controller, required this.modo});

  @override
  ScannerPageState createState() => ScannerPageState();
}

class ScannerPageState extends ConsumerState<ScannerPage> {
  MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(EPartnerIcons.angle_left,
              color: Color.fromARGB(255, 255, 255, 255), size: 25),
          // ignore: avoid_print
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Escanea el código'),
        titleTextStyle: const TextStyle(
            color: Color.fromRGBO(245, 245, 245, 1), fontSize: 19),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off,
                        color: Color.fromARGB(255, 170, 170, 170));
                  case TorchState.on:
                    return const Icon(Icons.flash_on,
                        color: Color.fromARGB(255, 255, 255, 255));
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: const Color.fromRGBO(245, 245, 245, 1),
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (capture) {
          if (widget.modo == "T") {
            ref.read(articuloProvider.notifier).searchByBarCode(
                  data: capture.barcodes[0].rawValue!,
                  after: () => {
                    if (ref.watch(articuloProvider).isEmpty)
                      {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return const Dialog(
                              backgroundColor: Colors.white30,
                              shadowColor: Colors.black,
                              child: SizedBox(
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "No exite articulo",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      }
                    else
                      {
                        widget.controller.text =
                            "${capture.barcodes[0].rawValue}",
                        Navigator.of(context).pop(),
                      }
                  },
                );
          } else {
            widget.controller.text = "${capture.barcodes[0].rawValue}";
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
