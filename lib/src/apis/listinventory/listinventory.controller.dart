import 'package:dio/dio.dart';
import 'package:incosys/src/apis/listinventory/listinventory.entity.dart';
import 'package:incosys/src/shared/config/constanst.dart';

class ListInventoryController {
  final DateTime ahora = DateTime.now();
  static Future<List<ListInventory>> getInventarioLista(
      {String ruc = '', String uid = '', String pwd = '', String token = ''}) async {
    final dio = Dio(BaseOptions(baseUrl: Constants.apiUrl, method: 'POST'));
    DateTime dataTime = DateTime.now();
    String fechaString =
        "${dataTime.year.toString().padLeft(4, '0')}-${dataTime.month.toString().padLeft(2, '0')}-${dataTime.day.toString().padLeft(2, '0')}";
    final credentials = {"ruc": ruc, "uid": uid, "pwd": pwd, "token": token, "fecha": fechaString};
    try {
      final response = await dio.post('/Inventario/getInventarioLista', data: credentials);
      final List<ListInventory> listInventory;
      final List<ListInventory> responseJson = response.data[0]['data'] != null
          ? List<ListInventory>.from(response.data[0]['data'].map((x) => ListInventory.fromJson(x)))
          : [];
      listInventory = response.data[0]['resultado'] != 'OK' ? [] : responseJson;
      return listInventory;
    } catch (e) {
      final List<ListInventory> listInventory;
      listInventory = [
        ListInventory(
            nomArticulo: "",
            cantidad: 0,
            conteo: 0,
            numInventario: -1,
            codAlmacen: -1,
            nomAlmacen: "",
            codUbicacion: -1,
            nomUbicacion: "",
            observacion: "",
            codArticulo: "")
      ];
      return listInventory;
    }
  }

  static Future<List<ListInventory>> getInventarioPorFecha(
      {String ruc = '', String uid = '', String pwd = '', String token = '', String fecha = ''}) async {
    final dio = Dio(BaseOptions(baseUrl: Constants.apiUrl, method: 'POST'));
    final credentials = {"ruc": ruc, "uid": uid, "pwd": pwd, "token": token, "fecha": fecha};
    try {
      final response = await dio.post('/Inventario/getInventarioLista', data: credentials);
      final List<ListInventory> listInventory;
      final List<ListInventory> responseJson = response.data[0]['data'] != null
          ? List<ListInventory>.from(response.data[0]['data'].map((x) => ListInventory.fromJson(x)))
          : [];
      listInventory = response.data[0]['resultado'] != 'OK' ? [] : responseJson;
      return listInventory;
    } catch (e) {
      final List<ListInventory> listInventory;
      listInventory = [
        ListInventory(
            nomArticulo: "",
            cantidad: 0,
            conteo: 0,
            numInventario: -1,
            codAlmacen: -1,
            nomAlmacen: "",
            codUbicacion: -1,
            nomUbicacion: "",
            observacion: "",
            codArticulo: "")
      ];
      return listInventory;
    }
  }
}
