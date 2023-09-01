import 'package:incosys/src/apis/seguridad/entities/seguridad.user.entity.dart';
import 'package:incosys/src/apis/seguridad/controller/seguridad.controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeguridadUserNotifier extends StateNotifier<SeguridadUser> {
  final SeguridadController _seguridadUserController = SeguridadController();

  SeguridadUserNotifier()
      : super(SeguridadUser(
            nomEmpresa: '',
            token: '',
            lastName: '',
            uid: 0,
            firstName: '',
            log: '',
            email: '',
            pwd: '',
            ruc: ''));

  Future<void> postLogin(
      {String ruc = '',
      String uid = '',
      String pwd = '',
      bool saveSession = false,
      required Function afterLogged}) async {
    final SeguridadUser seguridadUser = await _seguridadUserController.login(
      ruc: ruc,
      uid: uid,
      pwd: pwd,
    );
    if (saveSession == true) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("user", uid);
      pref.setString('ruc', ruc);
      pref.setString('pass', pwd);
    }

    state = seguridadUser;
    afterLogged();
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString('user');
    user != null
        ? {
            pref.remove("user"),
            pref.remove('ruc'),
            pref.remove('pass'),
          }
        : {};
  }
}

final seguridadUserProvider =
    StateNotifierProvider<SeguridadUserNotifier, SeguridadUser>((ref) {
  return SeguridadUserNotifier();
});
