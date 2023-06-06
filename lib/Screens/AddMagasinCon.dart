import 'package:mybench/Widget/NavigationDrawer.dart';
import 'package:mybench/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Apis/BenchMarkingApi.dart';
import 'concurrentScreen.dart';

class AddMagasinCon extends StatefulWidget {
  static const routeName = '/create_magasin_concurrent';

  @override
  State<AddMagasinCon> createState() => _AddMagasinConState();
}

class _AddMagasinConState extends State<AddMagasinCon> {
  bool _isObscure = true;
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  Map<String, String> _MagasinConData = {
    'magasinName': '',
    'magasinPlace': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: const Color(0xFF0097A7),
        title: const Text(
          '',
        ),
        content: Text(
          message,
          style:
              const TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'Créer une Magasin concurrent',
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 55),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Nom de Magasin'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Saisie le nom de votre Magasin';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _MagasinConData['magasinName'] = value!;
                      print(
                          'le nom de magasin= ${_MagasinConData['magasinName']}');
                      //print(value);
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Lieu de Magasin'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Saisie le lieu  de votre Magasin';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _MagasinConData['magasinPlace'] = value!;
                      print(
                          'lieu de magasin= ${_MagasinConData['magasinPlace']}');
                      //print(value);
                    });
                  },
                ),
                const SizedBox(
                  height: 35.0,
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
                          await Provider.of<BenchMarkingApi>(context,
                                  listen: false)
                              .createMagasinConcurrent(
                            _MagasinConData['magasinName']!,
                            _MagasinConData['magasinPlace']!,
                          );
                          if (BenchMarkingApi.allRight == true) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                title: const Center(
                                  child: Text(
                                    '✅',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25),
                                  ),
                                ),
                                content: const Text(
                                  'Magasin Concurrent créer avec succés',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: const Text(
                                      'Okay',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      setState(() {});
                                      Navigator.pushNamed(context,
                                          InventaireConcurrent.routeName);
                                    },
                                  )
                                ],
                              ),
                            );
                          } else {
                            _showErrorDialog(
                              'Oops! une erreur est survenue😱!',
                            );
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
                              Icons.person_add,
                              size: 17,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Créer Magasin',
                                style: TextStyle(
                                  fontSize: 17,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
