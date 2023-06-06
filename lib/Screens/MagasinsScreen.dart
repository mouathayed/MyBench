import 'dart:async';
import 'package:mybench/Models/Magasin.dart';
import 'package:mybench/Screens/AddMagasin.dart';
import 'package:mybench/Screens/HomeScreen.dart';
import 'package:mybench/Widget/AddMagasinButton.dart';
import 'package:mybench/constants.dart';
import 'package:mybench/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:mybench/Apis/MagasinAPI.dart';
import 'package:mybench/Widget/MagasinButton.dart';

class MagasinsScreen extends StatefulWidget {
  static const routeName = '/magasins';
  @override
  MagasinsScreenState createState() => MagasinsScreenState();
}

class MagasinsScreenState extends State<MagasinsScreen> {
  List<Magasin> magasins = [];
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
    final magasins = await MagasinApi.getMagasins(query);

    setState(() => this.magasins = magasins);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Votre magasins', style: TextStyle(fontSize: 19)),
        ),
        body: Column(
          children: <Widget>[
            AddMagasinButton(onPressed: () {
              Navigator.pushNamed(context, AddMagasin.routeName);
            }),
            Expanded(
              child: ListView.builder(
                itemCount: magasins.length,
                itemBuilder: (context, index) {
                  final magasin = magasins[index];
                  return buildMagasin(magasin);
                },
              ),
            ),
            buildSearch(),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Rechercher avec nom ou lieu du magasin',
        onChanged: searchMagasin,
      );

  Future searchMagasin(String query) async => debounce(() async {
        final magasins = await MagasinApi.getMagasins(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.magasins = magasins;
        });
      });

  Widget buildMagasin(Magasin magasin) => ListTile(
          title: MagasinButton(
        name: magasin.name,
        place: magasin.place,
        onPressed: () {
          setState(() {
            magId = magasin.id;
            print('magasin Id= $magId');
          });
          Navigator.pushNamed(context, HomeScreen.routeName);
        },
      ));
}
