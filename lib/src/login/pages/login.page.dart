import 'package:flutter/material.dart';
import 'package:incosys/src/login/widgets/login.form.dart';

class LoginPage extends StatelessWidget {
  static const String name = 'login_page';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF2F2F2),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: PageView(
          children: [
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Logo(),
                  const SizedBox(
                    height: 80,
                  ),
                  const TituloLogin(),
                  const SizedBox(
                    height: 30,
                  ),
                  const FormularioLogin(),
                  Expanded(child: Container()),
                  const Autor(),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// LOGO DE LOGIN
class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'lib/src/asset/images/logored.png',
          width: 150,
        ),
      ],
    );
  }
}

//TITULO LOGIN
class TituloLogin extends StatelessWidget {
  const TituloLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Iniciar Sesión',
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

//FORMULARIO LOGIN
class FormularioLogin extends StatelessWidget {
  const FormularioLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const LoginForm();
  }
}

//AUTOR
class Autor extends StatelessWidget {
  const Autor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'INCOSYS ',
          style: TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              color: Color(0xFF000000)),
        ),
        Text(
          'Version ',
          style: TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: Color(0xFF000000)),
        ),
        Text(
          '1.0',
          style: TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w900,
              color: Color(0xFF000000)),
        )
      ],
    );
  }
}
