import 'package:incosys/src/apis/ubicacion/entities/ubicacion.entity.dart';
import 'package:incosys/src/apis/ubicacion/model/ubicacion.data.model.dart';

class UbicacionMapper {
  static Ubicacion dataToEntity(UbicacionData apiUbicacion, String resultado,
          String nomAlmacen, String conteo, String conArticulos) =>
      Ubicacion(
        activo: apiUbicacion.activo,
        codUbicacion: apiUbicacion.codUbicacion,
        codAlmacen: apiUbicacion.codAlmacen,
        nomUbicacion: apiUbicacion.nomUbicacion,
        nomAlmacen: nomAlmacen,
        resultado: resultado,
        conteo: conteo,
        conArticulos: conArticulos,
      );
}
