import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:incosys/src/apis/listinventory/listinventory.controller.dart';
import 'package:incosys/src/apis/listinventory/listinventory.entity.dart';
import 'package:incosys/src/login/providers/seguridaduser.provider.dart';

part 'listinventory.provider.g.dart';

@Riverpod(keepAlive: true)
class InventarioLista extends _$InventarioLista {
  @override
  List<ListInventory> build() => [];

  Future<void> getInventarioLista() async {
    final userData = ref.watch(seguridadUserProvider);
    state = await ListInventoryController.getInventarioLista(
        ruc: userData.ruc, uid: userData.email, pwd: userData.pwd, token: userData.token);
  }

  Future<List<ListInventory>> getInventarioPorFecha(String fecha) async {
    final userData = ref.read(seguridadUserProvider);
    try {
      state = await ListInventoryController.getInventarioPorFecha(
          ruc: userData.ruc, uid: userData.email, pwd: userData.pwd, token: userData.token, fecha: fecha);
    } on Exception catch (_) {
      state = []; // make it explicit that this function can throw exceptions
    }
    return state;
  }
}
