import 'package:incosys/src/apis/almacen/entities/almacen.entity.dart';

class AlmacenesResponse {
  AlmacenesResponse({
    required this.resultado,
    required this.data,
  });

  final String resultado;
  final List<Almacen>? data;

  factory AlmacenesResponse.fromJson(Map<String, dynamic> json) =>
      AlmacenesResponse(
        resultado: json["resultado"],
        data: json["data"] != null
            ? List<Almacen>.from(json["data"].map((x) => Almacen.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "resultado": resultado,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
