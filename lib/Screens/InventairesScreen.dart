import 'dart:async';
import 'package:mybench/Models/Inventaire.dart';
import 'package:mybench/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'InventaireProduit.dart';
import '../Apis/inventaireApi.dart';

class InventaireScreen extends StatefulWidget {
  static const routeName = '/inventaires';
  @override
  InventaireScreenState createState() => InventaireScreenState();
}

class InventaireScreenState extends State<InventaireScreen> {
  List<Inventaire> inventaires = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final inventaires = await InventaireApi.getInventaire(query);

    setState(() => this.inventaires = inventaires);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Liste des inventaires',
              style: TextStyle(fontSize: 18)),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5,
              ),
              child: Material(
                elevation: 5.0,
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(60.0),
                child: MaterialButton(
                  onPressed: (() {
                    Navigator.pushNamed(
                        context, InventaireProduitScreen.routeName);
                  }),
                  minWidth: 20,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        size: 17,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text('Ajouter',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: inventaires.length,
                itemBuilder: (context, index) {
                  final employee = inventaires[index];
                  return buildInventaire(employee);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'libellé, Code a barre ou quantite ajoute',
        onChanged: searchEmployee,
      );

  Future searchEmployee(String query) async => debounce(() async {
        final inventaires = await InventaireApi.getInventaire(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.inventaires = inventaires;
        });
      });

  Widget buildInventaire(Inventaire inventaire) => ListTile(
        title: Row(
          children: <Widget>[
            Column(
              children: const [
                Icon(
                  Icons.inventory_sharp,
                  size: 70,
                  color: Colors.cyan,
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      const Text(
                        'Libellé: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 65),
                      Text(
                        inventaire.libelle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Quantite ajouter: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        inventaire.quantite,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Code a barre: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 37),
                      Text(
                        inventaire.codeEAN,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 54,
                  )
                ]),
          ],
        ),
      );
}
