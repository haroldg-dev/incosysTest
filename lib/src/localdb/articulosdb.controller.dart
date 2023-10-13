import 'package:incosys/src/apis/articles/entities/article.entity.dart';
import 'package:sqflite/sqflite.dart';

class ArticulosDB {
  final tableName = 'articulos';
  static const columnId0 = 'id_sql';
  static const columnName1 = 'CentroCosto';
  static const columnName2 = 'Nom_Articulo';
  static const columnName3 = 'Cantidad';
  static const columnName4 = 'Usuario';
  static const columnName5 = 'FechaGraba';
  static const columnName6 = 'Cod_Almacen';
  static const columnName7 = 'Costo';
  static const columnName8 = 'Umb';
  static const columnName9 = 'id';
  static const columnName10 = 'Cod_Articulo';

  Future createTable(Database db) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $tableName (
            $columnId0 INTEGER PRIMARY KEY,
            $columnName1 STRING NOT NULL,
            $columnName2 STRING NOT NULL,
            $columnName3 DOUBLE NOT NULL,
            $columnName4 STRING NOT NULL,
            $columnName5 STRING NOT NULL,
            $columnName6 INT NOT NULL,
            $columnName7 DOUBLE NOT NULL,
            $columnName8 STRING NOT NULL,
            $columnName9 INT NOT NULL,
            $columnName10 STRING NOT NULL
          )
          ''');
  }

  Future<int> insertData(
      {required Article articulos, required Database database}) async {
    //final database = await CreateDB().database;
    return await database.rawInsert('''
            INSERT INTO $tableName (
              $columnName1,
              $columnName2,
              $columnName3,
              $columnName4,
              $columnName5,
              $columnName6,
              $columnName7,
              $columnName8,
              $columnName9,
              $columnName10)
              VALUES (?,?,?,?,?,?,?,?,?,?)''', [
      articulos.centroCosto,
      articulos.nomArticulo,
      articulos.cantidad,
      articulos.usuario,
      articulos.fechaGraba,
      articulos.codAlmacen,
      articulos.costo,
      articulos.umb,
      articulos.id,
      articulos.codArticulo
    ]);
  }

  Future<void> truncateTable({required Database database}) async {
    await database.execute('DELETE FROM $tableName');
  }

  Future<List<Article>> findByBarCode(
      {required String data, required Database database}) async {
    List<Map> response = await database
        .rawQuery("SELECT * FROM $tableName WHERE Cod_Articulo='$data'");
    List<Article> listArticles = [];
    for (var element in response) {
      listArticles.add(Article.fromJsonDB(element));
    }

    return listArticles;
  }
}
