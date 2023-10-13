class Article {
  final String centroCosto;
  final String nomArticulo;
  final double cantidad;
  final String usuario;
  final String fechaGraba;
  final int codAlmacen;
  final double costo;
  final String umb;
  final int id;
  final String codArticulo;

  Article({
    required this.centroCosto,
    required this.nomArticulo,
    required this.cantidad,
    required this.usuario,
    required this.fechaGraba,
    required this.codAlmacen,
    required this.costo,
    required this.umb,
    required this.id,
    required this.codArticulo,
  });

  factory Article.fromJsonDB(Map<dynamic, dynamic> json) => Article(
        centroCosto: json["CentroCosto"],
        nomArticulo: json["Nom_Articulo"],
        cantidad: json["Cantidad"],
        usuario: json["Usuario"],
        fechaGraba: json["FechaGraba"],
        codAlmacen: json["Cod_Almacen"],
        costo: json["Costo"],
        umb: json["Umb"],
        id: json["id"],
        codArticulo: json["Cod_Articulo"].toString(),
      );
}
