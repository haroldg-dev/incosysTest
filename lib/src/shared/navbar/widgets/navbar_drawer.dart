import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/shared/helpers/epartnet.icons.dart';

class NavbarDrawer extends StatelessWidget {
  const NavbarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(EPartnerIcons.times,
                        color: Color.fromRGBO(0, 0, 0, 1), size: 30)),
              ),
              TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => const Color.fromRGBO(255, 0, 0, 0.183))),
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/home');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: const Row(
                      children: [
                        Icon(
                          EPartnerIcons.tool,
                          color: Colors.black,
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Text("Ajustes Generales",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal)),
                        )
                      ],
                    ),
                  )),
              TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => const Color.fromRGBO(255, 0, 0, 0.183))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: const Row(
                      children: [
                        Icon(
                          EPartnerIcons.print,
                          color: Colors.black,
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Text("Impresoras",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal)),
                        )
                      ],
                    ),
                  )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(255, 0, 0, 0)),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      onPressed: () {
                        context.go('/login');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: const Row(
                          children: [
                            SizedBox(width: 10),
                            Expanded(
                              child: Text("Cerrar sesion",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  )),
                            )
                          ],
                        ),
                      )),
                ),
              )),
              const SizedBox(height: 22)
            ],
          ),
        ));
  }
}
