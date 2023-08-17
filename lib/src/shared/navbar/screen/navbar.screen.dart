import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incosys/src/shared/navbar/widgets/navbar_drawer.dart';
import 'package:incosys/src/shared/widgets/bottom_nav_bar.dart';

class NavbarScreen extends ConsumerStatefulWidget {
  // static const name = 'home-screen';
  // final int pageIndex;
  final Widget childView;

  const NavbarScreen({super.key, required this.childView});

  @override
  NavbarScreenState createState() => NavbarScreenState();
}

class NavbarScreenState extends ConsumerState<NavbarScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void toggleDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: const NavbarDrawer(),
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: widget.childView,
        bottomNavigationBar: BottomNavBar(
          drawerAction: toggleDrawer,
        ));
  }
}
