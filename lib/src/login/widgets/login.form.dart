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
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: TextField(
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            controller: ruc,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 0, color: Color.fromRGBO(255, 255, 255, 1)),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Color(0xFFDADADA)),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255),
              hintText: 'RUC',
              prefixIcon: Icon(EPartnerIcons.layer_group,
                  color: Color.fromARGB(255, 0, 0, 0), size: 25),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        //RUC

        //EMAIL
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: TextField(
            controller: user,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 0, color: Color.fromRGBO(255, 255, 255, 1)),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Color(0xFFDADADA)),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255),
              hintText: 'Usuario',
              prefixIcon: Icon(EPartnerIcons.user,
                  color: Color.fromARGB(255, 0, 0, 0), size: 25),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        //EMAIL

        //CONTRASEÑA
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: TextField(
            obscureText: true,
            controller: password,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 0, color: Color.fromRGBO(255, 255, 255, 1)),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Color(0xFFDADADA)),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255),
              hintText: 'Contraseña',
              prefixIcon: Icon(EPartnerIcons.lock,
                  color: Color.fromARGB(255, 0, 0, 0), size: 25),
            ),
            keyboardType: TextInputType.visiblePassword,
          ),
        ),
        //CONTRASEÑA

        //BOTON
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          // ignore: sized_box_for_whitespace
          child: Container(
            width: double.infinity,
            height: 55,
            child: FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0)),
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
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ),
        ),
        //BOTON
      ],
    );
  }
}
