import 'package:flutter/material.dart';
import 'package:mybench/Widget/NavigationDrawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Apis/EditApi.dart';
import '../../Apis/auth.dart';
import '../../constants.dart';
import '../Edit.dart';

class EditNumber extends StatefulWidget {
  static const routeName = '/edit_number';

  @override
  State<EditNumber> createState() => _EditNumberState();
}

class _EditNumberState extends State<EditNumber> {
  String newNumber = '';
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        actions: <Widget>[
          Center(
            child: FlatButton(
              child: const Text('Ok', style: TextStyle(fontSize: 25)),
              onPressed: () {
                Navigator.pushNamed(context, Edit.routeName);
              },
            ),
          )
        ],
      ),
    );
  }

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 30, left: 20),
              child: Text(
                'Saisir le nouveau numero',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 55),
                  child: TextFormField(
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Saisir le nouveau numero'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Saisir le nouveau numero';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      newNumber = value!;
                    },
                  ),
                ),
              )),
          const SizedBox(
            height: 60,
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(left: 162, right: 162),
              child: CircularProgressIndicator(),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 90,
              ),
              child: Material(
                elevation: 5.0,
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(60.0),
                child: MaterialButton(
                  onPressed: (() async {
                    final isValid = _formKey.currentState?.validate();
                    if (isValid!) {
                      _formKey.currentState?.save();
                      setState(() {
                        _isLoading = true;
                      });
                    }
                    if (Auth.role == 'employee') {
                      await Provider.of<EditApi>(context, listen: false)
                          .EditEmployeNumber(Auth.emaill, newNumber);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      bool? valid1 = prefs.getBool('valid1');
                      if (valid1 == true) {
                        _showDialog(
                            '✅', 'votre nom a été changer avec succés.');
                      } else {
                        _showDialog('🤌', 'oops! une erreur est survenue!');
                      }
                    } else if (Auth.role == 'magasinier') {
                      await Provider.of<EditApi>(context, listen: false)
                          .EditMagasinierNumber(Auth.emaill, newNumber);

                      if (EditApi.valid1 == true) {
                        _showDialog('✅', 'votre nom a éte changer avec succés');
                      } else {
                        _showDialog('🤌', 'oops! une erreur est survenue!');
                      }
                    } else {
                      await Provider.of<EditApi>(context, listen: false)
                          .EditAdminNumber(Auth.emaill, newNumber);
                      if (EditApi.valid1 == true) {
                        _showDialog('✅', 'votre nom a éte changer avec succés');
                      } else {
                        _showDialog('🤌', 'oops! une erreur est survenue!');
                      }
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  }),
                  minWidth: 40,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.edit,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Modifer',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
