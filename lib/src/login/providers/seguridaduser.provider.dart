import 'package:incosys/src/apis/seguridad/entities/seguridad.user.entity.dart';
import 'package:incosys/src/apis/seguridad/controller/seguridad.controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      required Function afterLogged}) async {
    final SeguridadUser seguridadUser = await _seguridadUserController.login(
      ruc: ruc,
      uid: uid,
      pwd: pwd,
    );

    state = seguridadUser;
    afterLogged();
  }

  Future<void> logout() async {}
}

final seguridadUserProvider =
    StateNotifierProvider<SeguridadUserNotifier, SeguridadUser>((ref) {
  return SeguridadUserNotifier();
});
