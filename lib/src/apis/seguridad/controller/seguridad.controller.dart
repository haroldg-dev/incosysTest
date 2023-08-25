import 'package:dio/dio.dart';
import 'package:incosys/src/apis/seguridad/entities/seguridad.user.entity.dart';
import 'package:incosys/src/apis/seguridad/model/seguridad.response.dart';
import 'package:incosys/src/apis/seguridad/model/seguridad.mapper.dart';
import 'package:incosys/src/shared/config/constanst.dart';

class SeguridadController {
  final dio = Dio(BaseOptions(baseUrl: Constants.apiUrl, method: 'POST'));

  final Map errorCases = {
    "RUC": "la Instancia no existe",
    "UID": "El usuario no existe",
    "PWD": "La clave es invalida"
  };

  String validateLogin(String message) {
    if (message == errorCases["RUC"]) {
      return 'El RUC es invalido';
    } else if (message == errorCases["UID"]) {
      return 'El usuario es invalido';
    } else if (message == errorCases["PWD"]) {
      return 'La contraseña es invalida';
    } else {
      return "OK";
    }
  }

  Future<SeguridadUser> login(
      {String ruc = '', String uid = '', String pwd = ''}) async {
    final credentials = {
      "ruc": ruc,
      "uid": uid,
      "pwd": pwd,
    };

    final response = await dio.post('/default/seguridad', data: credentials);

    final seguridadResponse = SeguridadResponse.fromJson(response.data);

    final result = validateLogin(response.data["resultado"]);

    final SeguridadUser seguridadUser;

    seguridadUser = result != 'OK'
        ? SeguridadUser(
            nomEmpresa: '',
            token: '',
            lastName: '',
            uid: 0,
            firstName: '',
            log: result,
            email: '',
            pwd: '',
            ruc: '')
        : SeguridadUserMapper.seguridadToEntity(
            seguridadResponse.data!, result, credentials);

    return seguridadUser;
  }
}
