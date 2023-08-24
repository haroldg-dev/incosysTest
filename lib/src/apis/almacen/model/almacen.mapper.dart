import 'package:incosys/src/apis/almacen/entities/almacen.entity.dart';

class AlmacenMapper {
  static Almacen articleToEntity(Almacen apiAlmacen) => Almacen(
        nomAlmacen: apiAlmacen.nomAlmacen,
        activo: apiAlmacen.activo,
        codAlmacen: apiAlmacen.codAlmacen,
      );
}
