import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incosys/src/apis/seguridad/entities/seguridad.user.entity.dart';
import 'package:incosys/src/apis/ubicacion/controller/ubicacion.controller.dart';
import 'package:incosys/src/apis/ubicacion/entities/ubicacion.entity.dart';
import 'package:incosys/src/login/providers/seguridaduser.provider.dart';

class UbicacionNotifier extends StateNotifier<Ubicacion> {
  final UbicacionController _getUbicacionController = UbicacionController();
  final Ref ref;

  UbicacionNotifier(this.ref)
      : super(Ubicacion(
            activo: '',
            nomUbicacion: '',
            resultado: '',
            codAlmacen: 0,
            codUbicacion: 0,
            nomAlmacen: '',
            conteo: ''));

  Future<void> getUbicacion(
      {String codAlmacen = '',
      String nomUbicacion = '',
      String nomAlmacen = '',
      String conteo = '',
      required Function afterGetData}) async {
    SeguridadUser userData = ref.read(seguridadUserProvider);

    final Ubicacion ubicacion = await _getUbicacionController.getUbicacion(
        ruc: userData.ruc,
        uid: userData.email,
        pwd: userData.pwd,
        token: userData.token,
        codAlmacen: codAlmacen,
        nomUbicacion: nomUbicacion,
        nomAlmacen: nomAlmacen,
        conteo: conteo);

    state = ubicacion;
    afterGetData();
  }
}

final ubicacionProvider =
    StateNotifierProvider<UbicacionNotifier, Ubicacion>((ref) {
  return UbicacionNotifier(ref);
});
