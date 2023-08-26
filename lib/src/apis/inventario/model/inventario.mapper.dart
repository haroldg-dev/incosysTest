import 'package:incosys/src/apis/inventario/entities/inventario.entity.dart';
import 'package:incosys/src/apis/inventario/model/inventario.data.model.dart';

class InventarioMapper {
  static Inventario dataToEntity(
          InventarioData apiInventario, String resultado) =>
      Inventario(
        nomArticulo: apiInventario.nomArticulo,
        cantidad: apiInventario.cantidad,
        usuario: apiInventario.usuario,
        numInventario: apiInventario.numInventario,
        fechaGraba: apiInventario.fechaGraba,
        codArticulo: apiInventario.codArticulo,
        codUbicacion: apiInventario.codUbicacion,
        codAlmacen: apiInventario.codAlmacen,
        resultado: resultado,
      );
}
