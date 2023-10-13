import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:incosys/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incosys/src/home/pages/home.page.dart';
import 'package:incosys/src/inventory/pages/inventory.page.dart';
import 'package:incosys/src/listinventory/pages/listinventory.page.dart';
import 'package:incosys/src/login/pages/login.page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var user = pref.getString('user');
  var ruc = pref.getString('ruc');
  var pass = pref.getString('pass');
  await initialization(null);
  runApp(ProviderScope(
      child: MyApp(
    user: user,
    ruc: ruc,
    pwd: pass,
  )));
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 2));
}

class MyApp extends StatelessWidget {
  final String? user;
  final String? ruc;
  final String? pwd;
  MyApp({super.key, required this.user, required this.ruc, required this.pwd});

  final GlobalKey<NavigatorState> _rootNavigator =
      GlobalKey(debugLabel: 'root');

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        navigatorKey: _rootNavigator,
        initialLocation: user != null ? '/' : '/login',
        routes: [
          GoRoute(
            path: '/login',
            name: LoginPage.name,
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
              path: '/',
              builder: (context, state) => HomePage(
                    user: user,
                    ruc: ruc,
                    pwd: pwd,
                  ),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigator,
                  path: 'inventario',
                  builder: (context, state) => const InventoryPage(),
                ),
              ]),
          GoRoute(
              path: '/listinventory',
              builder: (context, state) => ListInventoryPage(
                    user: user,
                    ruc: ruc,
                    pwd: pwd,
                  ),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigator,
                  path: 'listinventory',
                  builder: (context, state) => const InventoryPage(),
                ),
              ]),
        ],
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }
}
