class UbicacionData {
  final String activo;
  final int codUbicacion;
  final int codAlmacen;
  final String nomUbicacion;

  UbicacionData({
    required this.activo,
    required this.codUbicacion,
    required this.codAlmacen,
    required this.nomUbicacion,
  });

  factory UbicacionData.fromJson(Map<String, dynamic> json) => UbicacionData(
        activo: json["Activo"],
        codUbicacion: json["Cod_Ubicacion"],
        codAlmacen: json["Cod_Almacen"],
        nomUbicacion: json["Nom_Ubicacion"],
      );

  Map<String, dynamic> toJson() => {
        "Activo": activo,
        "Cod_Ubicacion": codUbicacion,
        "Cod_Almacen": codAlmacen,
        "Nom_Ubicacion": nomUbicacion,
      };
}
