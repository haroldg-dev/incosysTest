import 'package:incosys/src/apis/seguridad/entities/seguridad.user.entity.dart';
import 'package:incosys/src/apis/seguridad/model/seguridad.data.model.dart';

class SeguridadUserMapper {
  static SeguridadUser seguridadToEntity(
          SeguridadData apiAuth, String log, Map credentials) =>
      SeguridadUser(
          nomEmpresa: apiAuth.nomEmpresa,
          token: apiAuth.token,
          lastName: apiAuth.lastName,
          uid: apiAuth.uid,
          firstName: apiAuth.firstName,
          log: log,
          email: credentials['uid'],
          pwd: credentials['pwd'],
          ruc: credentials['ruc']);
}
