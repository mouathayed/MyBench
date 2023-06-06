import 'dart:async';
import 'package:mybench/widget/search_widget.dart';
import 'package:flutter/material.dart';
import '../Apis/inventaireApi.dart';
import '../Models/Inventaire.dart';
import 'InventaireProduit.dart';

class ProduitsScreen extends StatefulWidget {
  static const routeName = '/produits';
  @override
  ProduitsScreenState createState() => ProduitsScreenState();
}

class ProduitsScreenState extends State<ProduitsScreen> {
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
          title:
              const Text('Liste des produits', style: TextStyle(fontSize: 18)),
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: inventaires.length,
                itemBuilder: (context, index) {
                  final employee = inventaires[index];
                  return buildProduct(employee);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'libellé, Code a barre ou prix',
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

  Widget buildProduct(Inventaire inventaire) => ListTile(
        title: Row(
          children: <Widget>[
            Column(
              children: const [
                Icon(
                  Icons.local_offer,
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
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Libellé: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
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
                        'Prix: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 85),
                      Text(
                        '${inventaire.prix} dt',
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
                      const SizedBox(width: 40),
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
                    height: 65,
                  )
                ]),
          ],
        ),
      );
}
