import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mybench/Apis/MagasinierApi.dart';
import 'package:mybench/Models/Magasinier.dart';
import 'package:mybench/Screens/AddMagasinier.dart';
import 'package:mybench/Widget/DeleteButton.dart';
import 'package:mybench/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widget/NavigationDrawer.dart';

class MagasinierScreen extends StatefulWidget {
  static const routeName = '/Magasiniers';
  @override
  MagasinierScreenState createState() => MagasinierScreenState();
}

class MagasinierScreenState extends State<MagasinierScreen> {
  List<Magasinier> magasiniers = [];
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
    final employees = await MagasinierApi.getMagasinier(query);

    setState(() => this.magasiniers = employees);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('les Magasiniers', style: TextStyle(fontSize: 18)),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10,
              ),
              child: Material(
                elevation: 5.0,
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(60.0),
                child: MaterialButton(
                  onPressed: (() {
                    Navigator.pushNamed(context, AddMagasinier.routeName);
                  }),
                  minWidth: 40,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.person_add,
                        size: 17,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Ajouter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          )),
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
                itemCount: magasiniers.length,
                itemBuilder: (context, index) {
                  final magasinier = magasiniers[index];
                  return buildMagasinier(magasinier);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Numéro portable ou Email',
        onChanged: searchMagasinier,
      );

  Future searchMagasinier(String query) async => debounce(() async {
        final magasiniers = await MagasinierApi.getMagasinier(query);
        if (!mounted) return;

        setState(() {
          this.query = query;
          this.magasiniers = magasiniers;
        });
      });

  Widget buildMagasinier(Magasinier magasinier) => ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                const SizedBox(
                  child: Icon(
                    Icons.account_circle,
                    size: 60,
                    color: Colors.cyan,
                  ),
                  width: 60,
                  height: 60,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        magasinier.fullName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (magasinier.phoneNumber != null)
                        Text(
                          magasinier.phoneNumber,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      else
                        const Text(
                          'no number',
                          style: TextStyle(color: Colors.black),
                        )
                    ]),
              ],
            ),
            DeleteButton(onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => CupertinoAlertDialog(
                        title: const Text('Confirmer',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20)),
                        content: const Text(
                          'Supprimer se magasinier?',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Non')),
                          FlatButton(
                              onPressed: () async {
                                await Provider.of<MagasinierApi>(context,
                                        listen: false)
                                    .DeleteMagasinier(magasinier.id);
                                Navigator.pushNamed(
                                    context, MagasinierScreen.routeName);
                              },
                              child: const Text('Oui')),
                        ],
                      ));
            })
          ],
        ),
      );
}
