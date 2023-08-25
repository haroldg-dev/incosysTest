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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/src/asset/images/fondopag1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
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
                    height: 5,
                  ),
                  const TituloLogin(),
                  const SizedBox(
                    height: 30,
                  ),
                  const FormularioLogin(),
                  Expanded(child: Container()),
                  const Autor(),
                  const SizedBox(
                    height: 40,
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
          'lib/src/asset/images/logoincosys.png',
          width: 45,
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
      'INCOSYS',
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: Colors.white),
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
        Text('INCOSYS ',
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(255, 180, 184, 1))),
        Text(
          'Version ',
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
        Text('1.0',
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w900,
                color: Colors.white)),
      ],
    );
  }
}
