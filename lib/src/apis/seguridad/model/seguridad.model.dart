import 'package:incosys/src/apis/seguridad/model/seguridad.data.model.dart';

class SeguridadResponse {
  SeguridadResponse({
    required this.resultado,
    required this.data,
  });

  final String resultado;
  final SeguridadData? data;

  factory SeguridadResponse.fromJson(Map<String, dynamic> json) =>
      SeguridadResponse(
        resultado: json["resultado"],
        data:
            json["data"] != null ? SeguridadData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "resultado": resultado,
        "data": data == null ? null : data!.toJson(),
      };
}
