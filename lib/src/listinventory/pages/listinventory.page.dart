import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incosys/src/listinventory/providers/listinventory.provider.dart';
import 'package:incosys/src/listinventory/widgets/listinventory_option.dart';
import 'package:incosys/src/shared/navbar/widgets/navbar_drawer.dart';
import 'package:incosys/src/listinventory/widgets/listfilter.dart';
import 'package:go_router/go_router.dart';

class ListInventoryPage extends ConsumerStatefulWidget {
  static const String name = 'list_inventory_page';

  final String? user;
  final String? ruc;
  final String? pwd;

  const ListInventoryPage({super.key, this.user, this.ruc, this.pwd});

  @override
  ListInventoryPageState createState() => ListInventoryPageState();
}

class ListInventoryPageState extends ConsumerState<ListInventoryPage> {
  ListInventoryPageState();

  @override
  void initState() {
    super.initState();
    ref.read(inventarioListaProvider.notifier).getInventarioLista();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    //final buscadorController = TextEditingController();
    const Color red = Color.fromRGBO(228, 228, 228, 1);
    const Color gray = Color.fromRGBO(245, 245, 245, 1);

    final documents = ref.watch(inventarioListaProvider);

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      drawer: NavbarDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            tooltip: 'Filtro de Documentos',
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => const Dialog(
                    backgroundColor: Colors.white,
                    insetPadding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ListFilterDialog())),
          ),
        ],
        title: const Text(
          "Listado de Registros",
          style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
        toolbarHeight: 50,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        ),
        elevation: 2.00,
        backgroundColor: const Color.fromRGBO(51, 102, 102, 1),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/src/asset/images/fondopag3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView(
          children: [
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                    /*
                    child: TextField(
                        controller: buscadorController,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0, color: Color.fromRGBO(0, 0, 0, 0.5)),
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            prefixIcon: Icon(EPartnerIcons.search, size: 25),
                            prefixIconColor: Color.fromRGBO(0, 0, 0, 1),
                            hintText: 'Buscar Comprobante'),
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1), fontSize: 16, height: 0, fontWeight: FontWeight.normal)),
                    */
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        // final todo = articles[index];
                        // return GestureDetector(child: Text(todo.nomArticulo));
                        final color = index % 2 == 0 ? gray : red;
                        return GestureDetector(
                          child: ListInventoryOption(document: documents[index], color: color),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pop(context);
          context.go('/');
          //context.go('/inventario');
          //setState(() {});
        },
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(10, 10, 10, 0.75),
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
