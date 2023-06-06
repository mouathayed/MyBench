import 'package:mybench/Screens/BenchMarkingScreen.dart';
import 'package:mybench/Screens/EmployeesScreen.dart';
import 'package:mybench/Screens/InventairePix.dart';
import 'package:mybench/Screens/InventaireProduit.dart';
import 'package:mybench/Screens/MagasinierScreen.dart';
import 'package:mybench/constants.dart';
import 'package:flutter/material.dart';
import 'package:mybench/Widget/RoundedButton.dart';
import '../Apis/auth.dart';
import 'package:mybench/Widget/NavigationDrawer.dart';
import 'produitsScreen.dart';
import 'InventairesScreen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String nomMagasin = '';
  String lieuMagasin = '';
  @override
  void initState() {
    super.initState();
    //updateUI(Auth.role != 'admin' ? Auth.magasin : magId);
    updateUI(magId);
  }

  Future<void> updateUI(int magasinID) async {
    await Auth().getMagasin(magasinID);
    setState(() {
      Auth().getMagasin(magasinID);
      nomMagasin = Auth.nomMagasin;
      lieuMagasin = Auth.lieuMagasin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyBench',
        ),
        //centerTitle: true,
      ),
      drawer: NavigationDrawerWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.store,
                    size: 27,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    nomMagasin.toUpperCase(),
                    style: const TextStyle(fontSize: 27),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 22,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    lieuMagasin.toUpperCase(),
                    style: const TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (Auth.role == 'admin')
                RoundedButton(
                    icon: (Icons.face),
                    title: 'Mes Magasiniers',
                    onPressed: () {
                      Navigator.pushNamed(context, MagasinierScreen.routeName);
                    }),
              if (Auth.role != 'employee')
                RoundedButton(
                    icon: (Icons.people),
                    title: 'Mes Employées',
                    onPressed: () {
                      Navigator.pushNamed(context, EmployeesScreen.routeName);
                    }),
              if (Auth.role != 'employee')
                RoundedButton(
                    icon: (Icons.shop_2_rounded),
                    title: 'liste des produits',
                    onPressed: () {
                      Navigator.pushNamed(context, ProduitsScreen.routeName);
                    }),
              if (Auth.role != 'employee')
                RoundedButton(
                    icon: (Icons.warehouse),
                    title: 'liste des inventaires',
                    onPressed: () {
                      Navigator.pushNamed(context, InventaireScreen.routeName);
                    }),
              RoundedButton(
                  icon: (Icons.inventory_rounded),
                  title: 'Inventaire Produit',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, InventaireProduitScreen.routeName);
                  }),
              RoundedButton(
                  icon: (Icons.sell),
                  title: 'Inventaire Prix',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, InventairePrixScreen.routeName);
                  }),
              RoundedButton(
                  icon: (BM.icon),
                  title: 'Bench Marking',
                  onPressed: () {
                    if (Auth.role != 'employee') {
                      Navigator.pushNamed(
                          context, BenchMarkingScreen.routeName);
                    } else {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
