import 'dart:async';
import 'package:mybench/Apis/BenchMarkingApi.dart';
import 'package:mybench/Models/MagasinConcurrent.dart';
import 'package:mybench/Screens/AddMagasin.dart';
import 'package:mybench/Screens/AddMagasinCon.dart';
import 'package:mybench/Screens/HomeScreen.dart';
import 'package:mybench/Screens/concurrentScreen.dart';
import 'package:mybench/Widget/AddMagasinButton.dart';
import 'package:mybench/constants.dart';
import 'package:mybench/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:mybench/Widget/MagasinButton.dart';

class MagasinsConScreen extends StatefulWidget {
  static const routeName = '/magasins_concurrent';
  @override
  MagasinsConScreenState createState() => MagasinsConScreenState();
}

class MagasinsConScreenState extends State<MagasinsConScreen> {
  List<MagasinConcurrent> magasins = [];
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
    final magasins = await BenchMarkingApi.getMagasinsconcurrent(query);

    setState(() => this.magasins = magasins);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('liste de concurrence',
              style: TextStyle(fontSize: 19)),
        ),
        body: Column(
          children: <Widget>[
            AddMagasinButton(onPressed: () {
              Navigator.pushNamed(context, AddMagasinCon.routeName);
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
        final magasins = await BenchMarkingApi.getMagasinsconcurrent(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.magasins = magasins;
        });
      });

  Widget buildMagasin(MagasinConcurrent magasin) => ListTile(
          title: MagasinButton(
        name: magasin.name,
        place: magasin.place,
        onPressed: () {
          setState(() {
            concurrentId = magasin.id;
            print('magasin Id= $concurrentId');
          });
          Navigator.pushNamed(context, InventaireConcurrent.routeName);
        },
      ));
}
