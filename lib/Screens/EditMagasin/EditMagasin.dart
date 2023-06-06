import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybench/Screens/EditMagasin/EditMagasinName.dart';
import 'package:mybench/Screens/EditMagasin/EditMagasinPlace.dart';
import 'package:mybench/Screens/EmployeesScreen.dart';
import 'package:mybench/Widget/RoundedButton.dart';
import 'package:mybench/Widget/NavigationDrawer.dart';
import 'package:provider/provider.dart';
import '../../Apis/EditApi.dart';
import '../../Apis/MagasinAPI.dart';
import '../../constants.dart';
import '../MagasinierScreen.dart';
import '../MagasinsScreen.dart';

class EditMagasin extends StatefulWidget {
  static const routeName = '/edit_magasin';

  @override
  State<EditMagasin> createState() => _EditMagasinState();
}

class _EditMagasinState extends State<EditMagasin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyBench',
        ),
        centerTitle: true,
      ),
      drawer: NavigationDrawerWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.settings,
                size: 90,
              ),
              Icon(
                Icons.store,
                size: 90,
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: RoundedButton(
                icon: (Icons.storefront),
                title: 'Modifier le \nnom du magasin',
                onPressed: () {
                  Navigator.pushNamed(context, EditMagasinName.routeName);
                }),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: RoundedButton(
                icon: (Icons.location_on),
                title: 'Modifier le \nlieu du magasin',
                onPressed: () {
                  Navigator.pushNamed(context, EditMagasinPlace.routeName);
                }),
          ),
          const SizedBox(
            height: 60,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 7,
                horizontal: 35,
              ),
              child: Material(
                elevation: 5.0,
                color: Colors.red,
                borderRadius: BorderRadius.circular(60.0),
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => CupertinoAlertDialog(
                              title: const Text('Confirmer',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20)),
                              content: const Text(
                                'Supprimer cette magasin?',
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
                                      await Provider.of<MagasinApi>(context,
                                              listen: false)
                                          .DeleteMagasin(magId);
                                      Navigator.pushNamed(
                                          context, MagasinsScreen.routeName);
                                    },
                                    child: const Text('Oui')),
                              ],
                            ));
                  },
                  minWidth: 320.0,
                  height: 70.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.remove_circle,
                        size: 35,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text('Supprimer \ncette Magasin!',
                          style: khomeButtonTextStyle),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
