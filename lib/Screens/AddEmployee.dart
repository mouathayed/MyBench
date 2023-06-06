import 'package:mybench/Apis/EmployeesApi.dart';
import 'package:mybench/Widget/NavigationDrawer.dart';
import 'package:mybench/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mybench/Components/sendEmail.dart';

class AddEmployee extends StatefulWidget {
  static const routeName = '/add_employe';

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  bool _isObscure = true;
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  Map<String, String> _EmployeData = {
    'nomComplet': '',
    'email': '',
    'phoneNumber': '',
    'password': ''
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
          'Ajouter un Employé',
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
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: 'Nom Complet'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Saisie le nom complet de votre employé';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _EmployeData['nomComplet'] = value!;
                      print(_EmployeData['nomComplet']);
                      //print(value);
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Numero Portable', prefixText: '+216 '),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty && value.length != 8) {
                      return 'le numero doit etre composé de 8 chiffres';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _EmployeData['phoneNumber'] = value!;
                      print(_EmployeData['phoneNumber']);
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'adresse email invalide ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _EmployeData['email'] = value!;
                      print(_EmployeData['email']);
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'mot de passe',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: _isObscure
                              ? const Icon(
                                  Icons.visibility_off,
                                )
                              : const Icon(
                                  Icons.visibility,
                                ))),
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  obscureText: _isObscure,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'cette  mot de passe est tres courte';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _EmployeData['password'] = value!;
                      print(_EmployeData['password']);
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Confirme Mot de passe',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: _isObscure
                              ? const Icon(
                                  Icons.visibility_off,
                                )
                              : const Icon(
                                  Icons.visibility,
                                ))),
                  obscureText: _isObscure,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'verifier le mot de passe';
                    }
                    return null;
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
                          //print(_EmployeData['email']);
                          final isValid = _formKey.currentState?.validate();
                          if (isValid!) {
                            _formKey.currentState?.save();
                            setState(() {
                              _isLoading = true;
                            });
                          }
                          await Provider.of<EmployeesApi>(context,
                                  listen: false)
                              .addEmployee(
                            _EmployeData['email']!,
                            _EmployeData['phoneNumber']!,
                            _EmployeData['password']!,
                            _EmployeData['nomComplet']!,
                          );
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          bool? validation = prefs.getBool('validation');
                          if (EmployeesApi.allGood == true) {
                            sendEmail(
                                email: _EmployeData['email']!,
                                password: _EmployeData['password']!,
                                replayTo: userEmail);
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                title: const Text(
                                  '✅Compte creer avec succès',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                                content: const Text(
                                  'Un email sera envoyer a votre employé avec sont email et sa mot de passe',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: const Text(
                                      'Okay',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, AddEmployee.routeName);
                                    },
                                  )
                                ],
                              ),
                            );
                          } else {
                            _showErrorDialog(
                              'Oops! Se email est deja utiliser😱!',
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
                            Text('Créer Compte',
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
