class Almacen {
  final String nomAlmacen;
  final String activo;
  final int codAlmacen;

  Almacen({
    required this.nomAlmacen,
    required this.activo,
    required this.codAlmacen,
  });

  factory Almacen.fromJson(Map<String, dynamic> json) => Almacen(
      nomAlmacen: json["Nom_Almacen"],
      activo: json["Activo"],
      codAlmacen: json["Cod_Almacen"]);

  Map<String, dynamic> toJson() => {
        "Nom_Almacen": nomAlmacen,
        "Activo": activo,
        "Cod_Almacen": codAlmacen,
      };
}
