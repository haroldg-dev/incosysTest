import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/inventory/pages/inventory.page.dart';
import 'package:incosys/src/listinventory/pages/listinventory.page.dart';
import 'package:incosys/src/login/pages/login.page.dart';
import 'package:incosys/src/home/pages/home.page.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator = GlobalKey(debugLabel: 'shell');

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
    GoRoute(path: '/', builder: (context, state) => const HomePage(), routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        path: 'listinventario',
        builder: (context, state) => const ListInventoryPage(),
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
