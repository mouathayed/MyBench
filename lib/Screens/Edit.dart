import 'package:flutter/material.dart';
import 'package:mybench/Screens/EditAccount/EditName.dart';
import 'package:mybench/Screens/EditAccount/EditNumber.dart';
import 'package:mybench/Screens/EditAccount/EditPassword.dart';
import 'package:mybench/Widget/RoundedButton.dart';
import 'package:mybench/Widget/NavigationDrawer.dart';

class Edit extends StatefulWidget {
  static const routeName = '/edit';

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
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
          const Icon(
            Icons.manage_accounts,
            size: 90,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: RoundedButton(
                icon: (Icons.person),
                title: 'Modifier le \nnom du compte',
                onPressed: () {
                  Navigator.pushNamed(context, EditName.routeName);
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: RoundedButton(
                icon: (Icons.phone),
                title: 'Modifier \nmon numero ',
                onPressed: () {
                  Navigator.pushNamed(context, EditNumber.routeName);
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: RoundedButton(
                icon: (Icons.password),
                title: 'Modifier mon \nmot de passe',
                onPressed: () {
                  Navigator.pushNamed(context, EditPassword.routeName);
                }),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
