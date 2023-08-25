import 'package:incosys/src/apis/ubicacion/model/ubicacion.data.model.dart';

class UbicacionResponse {
  UbicacionResponse({
    required this.resultado,
    required this.data,
  });

  final String resultado;
  final List<UbicacionData>? data;

  factory UbicacionResponse.fromJson(Map<String, dynamic> json) =>
      UbicacionResponse(
        resultado: json["resultado"],
        data: json["data"] != null
            ? List<UbicacionData>.from(
                json["data"].map((x) => UbicacionData.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "resultado": resultado,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
