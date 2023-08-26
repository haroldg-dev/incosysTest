import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incosys/src/apis/seguridad/entities/seguridad.user.entity.dart';
import 'package:incosys/src/apis/inventario/controller/inventario.controller.dart';
import 'package:incosys/src/apis/inventario/entities/inventario.entity.dart';
import 'package:incosys/src/login/providers/seguridaduser.provider.dart';

class InventarioNotifier extends StateNotifier<Inventario> {
  final InvenvarioController _setInventarioController = InvenvarioController();
  final Ref ref;

  InventarioNotifier(this.ref)
      : super(Inventario(
          nomArticulo: '',
          cantidad: '',
          usuario: '',
          numInventario: 0,
          fechaGraba: '',
          codArticulo: '',
          codUbicacion: 0,
          codAlmacen: 0,
          resultado: '',
        ));

  Future<void> setInventario(
      {String numInventario = '0',
      String codAlmacen = '',
      String codUbicacion = '',
      String codArticulo = '',
      String nomArticulo = '',
      String cantidad = '',
      required Function afterSetData}) async {
    SeguridadUser userData = ref.read(seguridadUserProvider);

    final Inventario inventario = await _setInventarioController.setInventario(
      ruc: userData.ruc,
      uid: userData.email,
      pwd: userData.pwd,
      token: userData.token,
      numInventario: numInventario,
      codAlmacen: codAlmacen,
      codUbicacion: codUbicacion,
      codArticulo: codArticulo,
      nomArticulo: nomArticulo,
      cantidad: cantidad,
    );

    state = inventario;
    afterSetData();
  }
}

final inventarioProvider =
    StateNotifierProvider<InventarioNotifier, Inventario>((ref) {
  return InventarioNotifier(ref);
});
