import 'package:go_router/go_router.dart';
import 'package:incosys/src/inventory/pages/inventory.page.dart';
import 'package:incosys/src/login/pages/login.page.dart';
import 'package:incosys/src/home/pages/home.page.dart';
import 'package:incosys/src/shared/navbar/screen/navbar.screen.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: LoginPage.name,
      builder: (context, state) => const LoginPage(),
    ),
    ShellRoute(
        builder: (context, state, child) {
          return NavbarScreen(childView: child);
        },
        routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomePage()),
          GoRoute(
            path: '/inventario',
            builder: (context, state) => const InventoryPage(),
          ),
        ]),
  ],
);
