import 'package:dio/dio.dart';
import 'package:incosys/src/apis/articles/entities/article.entity.dart';
import 'package:incosys/src/apis/articles/model/article.mapper.dart';
import 'package:incosys/src/apis/articles/model/article.response.dart';
import 'package:incosys/src/localdb/articulosdb.controller.dart';
import 'package:incosys/src/shared/config/constanst.dart';

class ArticleController {
  final dio = Dio(BaseOptions(baseUrl: Constants.apiUrl, method: 'POST'));

  Future<List<Article>> loadArticulosAlmacen({
    String ruc = '',
    String uid = '',
    String pwd = '',
    String token = '',
    String codAlmacen = '',
    required database,
  }) async {
    final authenticatedUser = {
      "ruc": ruc,
      "uid": uid,
      "pwd": pwd,
      "token": token,
      "cod_almacen": codAlmacen,
    };

    final response = await dio.post('/Inventario/getArticulosAlmacen',
        data: authenticatedUser);
    final articleResponse = ArticleResponse.fromJson(response.data[0]);

    final List<Article> articles = articleResponse.data!
        .map((apiArticle) => ArticleMapper.dataToEntity(apiArticle))
        .toList();

    List<int> listInsert = [];

    for (var element in articles) {
      listInsert.add(await ArticulosDB()
          .insertData(articulos: element, database: database));
    }

    return articles;
  }
}
