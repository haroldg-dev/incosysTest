class Almacen {
  final String nomAlmacen;
  final String activo;
  final int codAlmacen;
  final String conArticulos;

  Almacen({
    required this.nomAlmacen,
    required this.activo,
    required this.codAlmacen,
    required this.conArticulos,
  });

  factory Almacen.fromJson(Map<String, dynamic> json) => Almacen(
      nomAlmacen: json["Nom_Almacen"],
      activo: json["Activo"],
      codAlmacen: json["Cod_Almacen"],
      conArticulos: json["ConArticulos"]);

  Map<String, dynamic> toJson() => {
        "Nom_Almacen": nomAlmacen,
        "Activo": activo,
        "Cod_Almacen": codAlmacen,
        "ConArticulos": conArticulos,
      };
}
