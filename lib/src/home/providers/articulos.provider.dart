import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incosys/src/apis/articles/controller/article.controller.dart';
import 'package:incosys/src/apis/articles/entities/article.entity.dart';
import 'package:incosys/src/apis/seguridad/entities/seguridad.user.entity.dart';
import 'package:incosys/src/localdb/articulosdb.controller.dart';
import 'package:incosys/src/localdb/providers/localdb.provider.dart';
import 'package:incosys/src/login/providers/seguridaduser.provider.dart';
import 'package:sqflite/sqflite.dart';

class ArticulosNotifier extends StateNotifier<List<Article>> {
  final ArticleController _getArticulosController = ArticleController();
  final ArticulosDB _getArticulosDBController = ArticulosDB();
  final Ref ref;

  ArticulosNotifier(this.ref) : super([]);

  Future<void> loadArticulos(String codAlmacen) async {
    SeguridadUser userData = ref.read(seguridadUserProvider);
    Database? database = ref.read(localdbProvider);

    await _getArticulosController.loadArticulosAlmacen(
        ruc: userData.ruc,
        uid: userData.email,
        pwd: userData.pwd,
        token: userData.token,
        codAlmacen: codAlmacen,
        database: database!);

    //state = almacenes;
  }

  Future<void> searchByBarCode(
      {required String data, required Function after}) async {
    Database? database = ref.read(localdbProvider);
    final listArticles = await _getArticulosDBController.findByBarCode(
        data: data, database: database!);
    state = listArticles;
    after();
  }

  void resetArticulos() {
    state = [];
  }
}

final articuloProvider =
    StateNotifierProvider<ArticulosNotifier, List<Article>>((ref) {
  return ArticulosNotifier(ref);
});
