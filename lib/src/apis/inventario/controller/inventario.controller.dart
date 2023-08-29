import 'package:dio/dio.dart';
import 'package:incosys/src/apis/inventario/entities/inventario.entity.dart';
import 'package:incosys/src/apis/inventario/model/inventario.mapper.dart';
import 'package:incosys/src/apis/inventario/model/inventario.response.dart';
import 'package:incosys/src/shared/config/constanst.dart';

class InvenvarioController {
  final dio = Dio(BaseOptions(baseUrl: Constants.apiUrl, method: 'POST'));

  Future<Inventario> setInventario({
    String ruc = '',
    String uid = '',
    String pwd = '',
    String token = '',
    String numInventario = '',
    String codAlmacen = '',
    String codUbicacion = '',
    String codArticulo = '',
    String nomArticulo = '',
    String cantidad = '',
    String observacion = '',
    String etiqueta = '',
    required List<Object> imagenes,
  }) async {
    final authenticatedUser = {
      "ruc": ruc,
      "uid": uid,
      "pwd": pwd,
      "token": token,
      "num_inventario": numInventario,
      "cod_almacen": codAlmacen,
      "cod_ubicacion": codUbicacion,
      "cod_articulo": codArticulo,
      "nom_articulo": nomArticulo,
      "cantidad": cantidad,
      "observacion": observacion,
      "etiqueta": etiqueta,
      "imagenes": imagenes,
    };

    final response =
        await dio.post('/Inventario/setInventario', data: authenticatedUser);
    final inventarioResponse = InventarioResponse.fromJson(response.data[0]);

    final Inventario inventario = InventarioMapper.dataToEntity(
        inventarioResponse.data![0], response.data[0]["resultado"]);

    return inventario;
  }
}
