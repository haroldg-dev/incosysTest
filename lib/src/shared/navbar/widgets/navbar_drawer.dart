import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/shared/helpers/epartnet.icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

var user;
var ruc;

Future getdatos() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  user = pref.getString('user').toString();
  ruc = pref.getString('ruc').toString();
  await initialization(null);
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 10));
}

class NavbarDrawer extends StatelessWidget {
  const NavbarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    /*
    Future<void> obtenerUsuario() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      try {
        user = pref.getString('user').toString();
      } on Exception catch (_) {
        user = '';
        //rethrow;
      }
      //return user;
    }

    Future<void> obtenerRuc() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      try {
        ruc = pref.getString('ruc').toString();
      } on Exception catch (_) {
        ruc = '';
      }

      //return ruc;
    }

    obtenerUsuario();
    obtenerRuc();
    */
    getdatos();

    return Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
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
                      overlayColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(0.5)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(EPartnerIcons.times, color: Color.fromRGBO(0, 0, 0, 1), size: 30)),
              ),
              TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(0.5))),
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: const Row(
                      children: [
                        Icon(
                          EPartnerIcons.home,
                          color: Colors.black,
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Text("Almacén y ubicación",
                              style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal)),
                        )
                      ],
                    ),
                  )),
              TextButton(
                  //style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => const Color.fromRGBO(255, 0, 0, 1))),
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(0.5)),

                    /*
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) return Colors.white.withOpacity(1);
                        if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed))
                          return Colors.white.withOpacity(1);
                        return Colors.white.withOpacity(1); // Defer to the widget's default.
                      },
                    ),
                    
                      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered) ||
                              states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed)) return Colors.white.withOpacity(1);
                          return Colors.black.withOpacity(1); // Defer to the widget's default.
                        },
                      )
                      */
                    foregroundColor: MaterialStateProperty.resolveWith(getColor),
                    /*
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) return Colors.black.withOpacity(0.5);
                        if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed))
                          return Colors.white.withOpacity(1);
                        return Colors.red.withOpacity(1); // Defer to the widget's default.
                      },
                    ),
                    */
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/listinventory');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: const Row(
                      children: [
                        Icon(
                          EPartnerIcons.papers,
                          color: Colors.black,
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Text("Lista de Inventario",
                              style: TextStyle(
                                  color: Colors.black,
                                  //backgroundColor: Colors.white,
                                  /*
                                  color: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.hovered)) return Colors.black.withOpacity(0.5);
                                      if (states.contains(MaterialState.focused) ||
                                          states.contains(MaterialState.pressed)) return Colors.white.withOpacity(1);
                                      return Colors.red.withOpacity(1); // Defer to the widget's default.
                                    },
                                  ),
                                  */
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal)),
                        ),
                        SizedBox(height: 22),
                      ],
                    ),
                  )),
              SizedBox(
                height: 100,
              ),
              Text('Usuario',
                  style: TextStyle(color: Color.fromARGB(255, 66, 59, 59), fontSize: 13, fontWeight: FontWeight.bold)),
              Text(user.toString(), style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text('Ruc',
                  style: TextStyle(color: Color.fromARGB(255, 66, 59, 59), fontSize: 13, fontWeight: FontWeight.bold)),
              Expanded(
                child: Text(
                  ruc.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith((states) => Colors.white.withOpacity(0.3)),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(1)),
                        //foregroundColor: MaterialStateColor.resolveWith((states) => Colors.blue.withOpacity(0.3)),
                        //surfaceTintColor: MaterialStateColor.resolveWith((states) => Colors.blue.withOpacity(0.3)),
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
                              child: Text("Cerrar sesión",
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
