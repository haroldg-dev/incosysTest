class InventarioData {
  final String nomArticulo;
  final String cantidad;
  final String usuario;
  final int numInventario;
  final String fechaGraba;
  final String codArticulo;
  final int codUbicacion;
  final int codAlmacen;

  InventarioData({
    required this.nomArticulo,
    required this.cantidad,
    required this.usuario,
    required this.numInventario,
    required this.fechaGraba,
    required this.codArticulo,
    required this.codUbicacion,
    required this.codAlmacen,
  });

  factory InventarioData.fromJson(Map<String, dynamic> json) => InventarioData(
        nomArticulo: json["Nom_Articulo"],
        cantidad: json["Cantidad"].toString(),
        usuario: json["Usuario"],
        numInventario: json["Num_Inventario"],
        fechaGraba: json["FechaGraba"],
        codArticulo: json["Cod_Articulo"],
        codUbicacion: json["Cod_Ubicacion"],
        codAlmacen: json["Cod_Almacen"],
      );

  Map<String, dynamic> toJson() => {
        "Nom_Articulo": nomArticulo,
        "Cantidad": cantidad,
        "Usuario": usuario,
        "Num_Inventario": numInventario,
        "FechaGraba": fechaGraba,
        "Cod_Articulo": codArticulo,
        "Cod_Ubicacion": codUbicacion,
        "Cod_Almacen": codAlmacen,
      };
}
