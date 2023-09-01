import 'package:dio/dio.dart';
import 'package:incosys/src/apis/ubicacion/entities/ubicacion.entity.dart';
import 'package:incosys/src/apis/ubicacion/model/ubicacion.mapper.dart';
import 'package:incosys/src/apis/ubicacion/model/ubicacion.response.dart';
import 'package:incosys/src/shared/config/constanst.dart';

class UbicacionController {
  final dio = Dio(BaseOptions(baseUrl: Constants.apiUrl, method: 'POST'));

  Future<Ubicacion> getUbicacion({
    String ruc = '',
    String uid = '',
    String pwd = '',
    String token = '',
    String codAlmacen = '',
    String nomUbicacion = '',
    String nomAlmacen = '',
    String conteo = '',
  }) async {
    final authenticatedUser = {
      "ruc": ruc,
      "uid": uid,
      "pwd": pwd,
      "token": token,
      "cod_almacen": codAlmacen,
      "nom_ubicacion": nomUbicacion,
    };

    final response =
        await dio.post('/Inventario/getUbicacion', data: authenticatedUser);
    final ubicacionResponse = UbicacionResponse.fromJson(response.data[0]);

    final Ubicacion ubicacion = UbicacionMapper.dataToEntity(
        ubicacionResponse.data![0],
        response.data[0]["resultado"],
        nomAlmacen,
        conteo);

    return ubicacion;
  }
}
