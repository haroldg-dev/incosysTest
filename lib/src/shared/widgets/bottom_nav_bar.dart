import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incosys/src/shared/helpers/epartnet.icons.dart';

class BottomNavBar extends ConsumerWidget {
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color red = Color.fromRGBO(0, 0, 0, 1);

  // final int currentIndex;
  final VoidCallback drawerAction;
  // final bool inHome;

  const BottomNavBar({super.key, required this.drawerAction});

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/home');
        break;
      case 2:
        context.go('/home');
        break;
      case 3:
        drawerAction();
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 95,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(60, 158, 158, 158),
                spreadRadius: 7,
                blurRadius: 5,
                offset: Offset(0, 1))
          ]),
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: BottomNavigationBar(
            onTap: (value) => onItemTapped(context, value),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(EPartnerIcons.home, color: Colors.black, size: 25),
                activeIcon:
                    Icon(EPartnerIcons.home, color: Colors.black, size: 25),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(EPartnerIcons.papers, color: Colors.black, size: 25),
                activeIcon:
                    Icon(EPartnerIcons.papers, color: Colors.black, size: 25),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(EPartnerIcons.user_search,
                    color: Colors.black, size: 25),
                activeIcon: Icon(EPartnerIcons.user_search,
                    color: Colors.black, size: 25),
                label: '',
              ),
              BottomNavigationBarItem(
                icon:
                    Icon(EPartnerIcons.settings, color: Colors.black, size: 25),
                activeIcon:
                    Icon(EPartnerIcons.settings, color: Colors.black, size: 25),
                label: '',
              ),
            ],
          )),
    );
  }
}
