import 'package:incosys/src/apis/articles/entities/article.entity.dart';
import 'package:incosys/src/apis/articles/model/article.data.model.dart';

class ArticleMapper {
  static Article dataToEntity(ArticleData apiArticle) => Article(
        nomArticulo: apiArticle.nomArticulo,
        cantidad: apiArticle.cantidad,
        usuario: apiArticle.usuario,
        fechaGraba: apiArticle.fechaGraba,
        codArticulo: apiArticle.codArticulo,
        codAlmacen: apiArticle.codAlmacen,
        centroCosto: apiArticle.centroCosto,
        costo: apiArticle.costo,
        umb: apiArticle.umb,
        id: apiArticle.id,
      );
}
