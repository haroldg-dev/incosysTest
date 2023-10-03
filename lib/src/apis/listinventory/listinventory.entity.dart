class ListInventory {
  final String nomArticulo;
  final double cantidad;
  final int conteo;
  final int numInventario;
  final int codAlmacen;
  final String nomAlmacen;
  final int codUbicacion;
  final String nomUbicacion;
  final String codArticulo;
  final String observacion;

  ListInventory(
      {required this.nomArticulo,
      required this.cantidad,
      required this.conteo,
      required this.numInventario,
      required this.codAlmacen,
      required this.nomAlmacen,
      required this.codUbicacion,
      required this.nomUbicacion,
      required this.codArticulo,
      required this.observacion});

  factory ListInventory.fromJson(Map<String, dynamic> json) => ListInventory(
        nomArticulo: json["Nom_Articulo"],
        cantidad: json["Cantidad"].toDouble(),
        conteo: json["conteo"],
        numInventario: json["Num_Inventario"],
        codAlmacen: json["Cod_Almacen"],
        nomAlmacen: json["Nom_Almacen"],
        codUbicacion: json["Cod_Ubicacion"],
        nomUbicacion: json["Nom_Ubicacion"],
        codArticulo: json["Cod_Articulo"],
        observacion: json["Observacion"],
      );

  Map<String, dynamic> toJson() => {
        "Nom_Articulo": nomArticulo,
        "Cantidad": cantidad,
        "conteo": conteo,
        "Num_Inventario": numInventario,
        "Cod_Almacen": codAlmacen,
        "Nom_Almacen": nomAlmacen,
        "Cod_Ubicacion": codUbicacion,
        "Nom_Ubicacion": nomUbicacion,
        "Cod_Articulo": codArticulo,
        "Observacion": observacion,
      };
}
