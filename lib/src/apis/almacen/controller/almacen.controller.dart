import 'package:dio/dio.dart';
import 'package:incosys/src/apis/almacen/entities/almacen.entity.dart';
import 'package:incosys/src/apis/almacen/model/almacen.mapper.dart';
import 'package:incosys/src/apis/almacen/model/almacen.response.dart';
import 'package:incosys/src/shared/config/constanst.dart';

class AlmacenController {
  final dio = Dio(BaseOptions(baseUrl: Constants.apiUrl, method: 'POST'));

  Future<List<Almacen>> getAlmacenes(
      {String ruc = '',
      String uid = '',
      String pwd = '',
      String token = ''}) async {
    final authenticatedUser = {
      "ruc": ruc,
      "uid": uid,
      "pwd": pwd,
      "token": token
    };

    final response =
        await dio.post('/Inventario/getAlmacenes/', data: authenticatedUser);
    final almacenesResponse = AlmacenesResponse.fromJson(response.data[0]);

    final List<Almacen> almacenes = almacenesResponse.data!
        .map((apiAlmacen) => AlmacenMapper.articleToEntity(apiAlmacen))
        .toList();

    return almacenes;
  }
}
