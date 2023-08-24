import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incosys/src/apis/almacen/controller/almacen.controller.dart';
import 'package:incosys/src/apis/almacen/entities/almacen.entity.dart';
import 'package:incosys/src/apis/seguridad/entities/seguridad.user.entity.dart';
import 'package:incosys/src/login/providers/seguridaduser.provider.dart';

class AlmacenNotifier extends StateNotifier<List<Almacen>> {
  final AlmacenController _getAlmacenController = AlmacenController();
  final Ref ref;

  AlmacenNotifier(this.ref) : super([]);

  Future<void> getAlmacenes() async {
    SeguridadUser userData = ref.read(seguridadUserProvider);

    final List<Almacen> almacenes = await _getAlmacenController.getAlmacenes(
        ruc: userData.ruc,
        uid: userData.email,
        pwd: userData.pwd,
        token: userData.token);

    state = almacenes;
  }
}

final almacenProvider =
    StateNotifierProvider<AlmacenNotifier, List<Almacen>>((ref) {
  return AlmacenNotifier(ref);
});
