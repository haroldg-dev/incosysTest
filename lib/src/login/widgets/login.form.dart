import 'package:get_storage/get_storage.dart';
import 'package:incosys/src/localdb/providers/localdb.provider.dart';
import 'package:incosys/src/shared/helpers/epartnet.icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/login/providers/seguridaduser.provider.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  GetStorage box = GetStorage();
  bool saveSession = false;
  var ruc = TextEditingController();
  var user = TextEditingController();
  var password = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(localdbProvider.notifier).getLocalDB("LIMPIAR");
    ref.read(seguridadUserProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context) {
    ruc.text = '22222222222';
    user.text = 'esau.hernandez@gmail.com';
    password.text = '88552233';

    return Column(
      children: [
        //RUC
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38, blurRadius: 3.0, spreadRadius: 0.6)
                ]),
            child: TextField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: ruc,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0, color: Color.fromRGBO(26, 47, 76, 0)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white60),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Ruc',
                hintStyle: TextStyle(color: Color.fromRGBO(128, 128, 128, 1)),
                prefixIcon: Icon(EPartnerIcons.layer_group,
                    color: Color.fromRGBO(128, 128, 128, 1), size: 25),
              ),
              style: const TextStyle(color: Color.fromRGBO(100, 100, 100, 1)),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        //RUC

        //EMAIL
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38, blurRadius: 3.0, spreadRadius: 0.6)
                ]),
            child: TextField(
              controller: user,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0, color: Color.fromRGBO(26, 47, 76, 0)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white60),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Usuario',
                hintStyle: TextStyle(color: Color.fromRGBO(128, 128, 128, 1)),
                prefixIcon: Icon(EPartnerIcons.user,
                    color: Color.fromRGBO(128, 128, 128, 1), size: 25),
              ),
              style: const TextStyle(color: Color.fromRGBO(100, 100, 100, 1)),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
        //EMAIL

        //CONTRASEÑA
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38, blurRadius: 3.0, spreadRadius: 0.6)
                ]),
            child: TextField(
              obscureText: true,
              controller: password,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0, color: Color.fromRGBO(26, 47, 76, 0)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white60),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Contraseña',
                hintStyle: TextStyle(color: Color.fromRGBO(128, 128, 128, 1)),
                prefixIcon: Icon(EPartnerIcons.lock,
                    color: Color.fromRGBO(128, 128, 128, 1), size: 25),
              ),
              style: const TextStyle(color: Color.fromRGBO(100, 100, 100, 1)),
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
        ),
        //CONTRASEÑA
        //GUARDAR SESION
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Checkbox(
                value: saveSession,
                onChanged: (value) {
                  setState(() {
                    saveSession = !saveSession;
                    ruc.text = ruc.text;
                    user.text = user.text;
                    password.text = password.text;
                  });
                  /* if (saveSession == true) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("SaveSession True"),
                    ));
                  }
                  if (saveSession == false) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("SaveSession False"),
                    ));
                  } */
                },
              ),
              const Text(
                'Guardar Sesión',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(128, 128, 128, 1),
                ),
              ),
            ],
          ),
        ),

        //GUARDAR SESION
        //BOTON
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          // ignore: sized_box_for_whitespace
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38, blurRadius: 3.0, spreadRadius: 0.6)
                ]),
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(51, 102, 102, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {
                if (ruc.text != '' && user.text != '' && password.text != '') {
                  ref.read(seguridadUserProvider.notifier).postLogin(
                      ruc: ruc.text,
                      uid: user.text,
                      pwd: password.text,
                      saveSession: saveSession,
                      afterLogged: () {
                        if (ref.watch(seguridadUserProvider).log != 'OK') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              ref.watch(seguridadUserProvider).log,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ));
                        } else {
                          context.go('/');
                        }
                      });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Todos los campos son obligatorios"),
                  ));
                }
              },
              child: const Text(
                'Iniciar Sesión',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        //BOTON
      ],
    );
  }
}
