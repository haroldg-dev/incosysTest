import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/inventory/pages/inventory.page.dart';
import 'package:incosys/src/login/pages/login.page.dart';
import 'package:incosys/src/home/pages/home.page.dart';
import 'package:incosys/src/shared/navbar/screen/navbar.screen.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

// GoRouter configuration
final appRouter = GoRouter(
  navigatorKey: _rootNavigator,
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: LoginPage.name,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(path: '/', builder: (context, state) => const HomePage(), routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: 'inventario',
        builder: (context, state) => const InventoryPage(),
      ),
    ]),
    /* ShellRoute(
        navigatorKey: _shellNavigator,
        builder: (context, state, child) {
          return NavbarScreen(childView: child);
        },
        routes: [
          GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigator,
                  path: 'inventario/:nomAlmacen',
                  name: 'inventario',
                  builder: (context, state) => InventoryPage(
                      nomAlmacen: state.pathParameters['nomAlmacen']),
                ),
              ]),
        ]), */
  ],
);
