import 'package:flutter/material.dart';
import 'package:mybench/Screens/MagasinsConScreen.dart';
import 'package:mybench/Widget/CardButton.dart';
import 'package:mybench/Widget/RoundedButton.dart';
import '../Widget/NavigationDrawer.dart';

class BenchMarkingScreen extends StatefulWidget {
  static const routeName = '/BenchMarking';

  @override
  State<BenchMarkingScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<BenchMarkingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BenchMarking',
        ),
        //centerTitle: true,
      ),
      drawer: NavigationDrawerWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: CardButton(
                couleur: Colors.blue,
                title: 'Inspection',
                line:
                    'Compare les prix de tes produits avec les prix de votre concuurants',
                onPressed: () {},
                icon: Icons.troubleshoot),
          ),
          Expanded(
            child: CardButton(
                couleur: Colors.deepOrange,
                title: 'Scanner',
                line:
                    'scanner code a barre et inserer prix d\'un produit concuurant',
                onPressed: () {
                  Navigator.pushNamed(context, MagasinsConScreen.routeName);
                },
                icon: Icons.flip),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
