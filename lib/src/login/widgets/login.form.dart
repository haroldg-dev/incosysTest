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
  @override
  Widget build(BuildContext context) {
    final ruc = TextEditingController();
    final user = TextEditingController();
    final password = TextEditingController();

    ruc.text = '20603280157';
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
                      width: 0, color: Color.fromRGBO(26, 47, 76, 1)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white60),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                filled: true,
                fillColor: Color.fromRGBO(26, 47, 76, 1),
                hintText: 'RUC',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(EPartnerIcons.layer_group,
                    color: Colors.white, size: 25),
              ),
              style: const TextStyle(color: Colors.white),
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
                      width: 0, color: Color.fromRGBO(26, 47, 76, 1)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white60),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                filled: true,
                fillColor: Color.fromRGBO(26, 47, 76, 1),
                hintText: 'Usuario',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon:
                    Icon(EPartnerIcons.user, color: Colors.white, size: 25),
              ),
              style: const TextStyle(color: Colors.white),
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
                      width: 0, color: Color.fromRGBO(26, 47, 76, 1)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white60),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                filled: true,
                fillColor: Color.fromRGBO(26, 47, 76, 1),
                hintText: 'Contraseña',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon:
                    Icon(EPartnerIcons.lock, color: Colors.white, size: 25),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
        ),
        //CONTRASEÑA

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
                  backgroundColor: const Color.fromRGBO(255, 180, 184, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {
                if (ruc.text != '' && user.text != '' && password.text != '') {
                  ref.read(seguridadUserProvider.notifier).postLogin(
                      ruc: ruc.text, uid: user.text, pwd: password.text);
                  if (ref.watch(seguridadUserProvider).log != 'OK') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(ref.watch(seguridadUserProvider).log),
                    ));
                  } else {
                    context.go('/');
                  }
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
                    color: Color.fromRGBO(19, 39, 66, 1)),
              ),
            ),
          ),
        ),
        //BOTON
      ],
    );
  }
}
