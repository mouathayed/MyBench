import 'package:flutter/material.dart';
import 'package:mybench/Apis/auth.dart';
import 'package:mybench/Screens/Edit.dart';
import 'package:mybench/Screens/EditMagasin/EditMagasin.dart';
import 'package:mybench/Screens/EmployeesScreen.dart';
import 'package:mybench/Screens/HomeScreen.dart';
import 'package:mybench/Screens/InventaireProduit.dart';
import 'package:mybench/Screens/InventairePix.dart';
import 'package:mybench/Screens/InventairesScreen.dart';
import 'package:mybench/constants.dart';
import 'package:mybench/Widget/themeButton.dart';
import 'package:provider/provider.dart';
import 'package:mybench/Components/dark_theme_provider.dart';

import '../Screens/BenchMarkingScreen.dart';
import '../Screens/MagasinierScreen.dart';
import '../Screens/MagasinsScreen.dart';
import '../Screens/produitsScreen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  Color dark = Colors.black;
  double space = 4;
  double space2 = 6;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    dark = themeChange.darkTheme ? Colors.white : Colors.black;
    return Drawer(
      child: Material(
        color: themeChange.darkTheme ? Color(0xFF001B35) : Colors.cyan,
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 20),
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    iconColor: dark,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  SizedBox(height: space),
                  if (Auth.role == 'admin')
                    buildMenuItem(
                      text: 'Mes Magasins',
                      icon: Icons.store,
                      iconColor: dark,
                      onClicked: () => selectedItem(context, 1),
                    ),
                  SizedBox(height: space),
                  if (Auth.role == 'admin')
                    buildMenuItem(
                      text: 'Mes Magasiniers',
                      icon: Icons.face,
                      iconColor: dark,
                      onClicked: () => selectedItem(context, 2),
                    ),
                  SizedBox(height: space),
                  if (Auth.role != 'employee')
                    buildMenuItem(
                      text: 'Mes Employées',
                      icon: Icons.people,
                      iconColor: dark,
                      onClicked: () => selectedItem(context, 3),
                    ),
                  SizedBox(height: space),
                  buildMenuItem(
                    text: 'Inventaire Produit',
                    icon: (Icons.inventory_rounded),
                    iconColor: dark,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  SizedBox(height: space),
                  buildMenuItem(
                    text: 'Inventaire Prix',
                    icon: (Icons.sell),
                    iconColor: dark,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  SizedBox(height: space),
                  if (Auth.role != 'employee')
                    buildMenuItem(
                      text: 'Bench Marking',
                      icon: (BM.icon),
                      onClicked: () => selectedItem(context, 6),
                      iconColor: dark,
                    ),
                  SizedBox(height: space),
                  if (Auth.role != 'employee')
                    buildMenuItem(
                      text: 'liste des inventaires',
                      icon: Icons.warehouse,
                      iconColor: dark,
                      onClicked: () => selectedItem(context, 7),
                    ),
                  SizedBox(height: space),
                  if (Auth.role != 'employee')
                    buildMenuItem(
                      text: 'liste des produits',
                      icon: Icons.shop_2_rounded,
                      iconColor: dark,
                      onClicked: () => selectedItem(context, 8),
                    ),
                  SizedBox(height: space),
                  const Divider(color: Colors.white70),
                  buildMenuItem(
                    text: 'Modifier mon compte',
                    icon: Icons.manage_accounts,
                    iconColor: dark,
                    onClicked: () => selectedItem(context, 9),
                  ),
                  SizedBox(height: space),
                  if (Auth.role == 'admin')
                    buildMenuItem(
                      text: 'Modifier mon Magasin',
                      icon: Icons.settings,
                      iconColor: dark,
                      onClicked: () => selectedItem(context, 10),
                    ),
                  SizedBox(height: space),
                  ChangeThemeButtonWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required Color iconColor,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        text,
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.pushNamed(context, HomeScreen.routeName);
        break;
      case 1:
        Navigator.pushNamed(context, MagasinsScreen.routeName);
        break;
      case 2:
        Navigator.pushNamed(context, MagasinierScreen.routeName);
        break;
      case 3:
        Navigator.pushNamed(context, EmployeesScreen.routeName);
        break;
      case 4:
        Navigator.pushNamed(context, InventaireProduitScreen.routeName);
        break;
      case 5:
        Navigator.pushNamed(context, InventairePrixScreen.routeName);
        break;
      case 6:
        Navigator.pushNamed(context, BenchMarkingScreen.routeName);
        break;
      case 7:
        Navigator.pushNamed(context, InventaireScreen.routeName);
        break;
      case 8:
        Navigator.pushNamed(context, ProduitsScreen.routeName);
        break;
      case 9:
        Navigator.pushNamed(context, Edit.routeName);
        break;
      case 10:
        Navigator.pushNamed(context, EditMagasin.routeName);
        break;
    }
  }
}
