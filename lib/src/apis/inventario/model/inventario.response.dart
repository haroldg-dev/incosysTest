import 'package:incosys/src/apis/inventario/model/inventario.data.model.dart';

class InventarioResponse {
  InventarioResponse({
    required this.resultado,
    required this.data,
  });

  final String resultado;
  final List<InventarioData>? data;

  factory InventarioResponse.fromJson(Map<String, dynamic> json) =>
      InventarioResponse(
        resultado: json["resultado"],
        data: json["data"] != null
            ? List<InventarioData>.from(
                json["data"].map((x) => InventarioData.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "resultado": resultado,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
