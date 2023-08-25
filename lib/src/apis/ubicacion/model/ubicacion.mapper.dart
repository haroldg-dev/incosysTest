import 'package:incosys/src/apis/ubicacion/entities/ubicacion.entity.dart';
import 'package:incosys/src/apis/ubicacion/model/ubicacion.data.model.dart';

class UbicacionMapper {
  static Ubicacion articleToEntity(
          UbicacionData apiUbicacion, String resultado) =>
      Ubicacion(
        activo: apiUbicacion.activo,
        codUbicacion: apiUbicacion.codUbicacion,
        codAlmacen: apiUbicacion.codAlmacen,
        nomUbicacion: apiUbicacion.nomUbicacion,
        resultado: resultado,
      );
}
