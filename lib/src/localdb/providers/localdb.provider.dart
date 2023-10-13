import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incosys/src/localdb/articulosdb.controller.dart';
import 'package:incosys/src/localdb/createdb.controller.dart';
import 'package:sqflite/sqflite.dart';

class LocalDBNotifier extends StateNotifier<Database?> {
  final ArticulosDB _getArticulosDBController = ArticulosDB();
  final Ref ref;

  LocalDBNotifier(this.ref) : super(null);

  Future<void> getLocalDB(String modo) async {
    final database = await CreateDB().database;
    if (modo == "LIMPIAR") {
      _getArticulosDBController.truncateTable(database: database);
    }
    state = database;
  }
}

final localdbProvider =
    StateNotifierProvider<LocalDBNotifier, Database?>((ref) {
  return LocalDBNotifier(ref);
});
