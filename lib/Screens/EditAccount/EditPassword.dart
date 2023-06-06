import 'package:flutter/material.dart';
import 'package:mybench/Widget/NavigationDrawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Apis/EditApi.dart';
import '../../Apis/auth.dart';
import '../../constants.dart';
import '../Edit.dart';

class EditPassword extends StatefulWidget {
  static const routeName = '/edit_password';

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  String newPassword = '';

  bool _isObscure = true;
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
              padding: EdgeInsets.only(left: 10, right: 9),
              child: Text(
                'Saisir le nouveau mot de passe',
                style: TextStyle(fontSize: 27),
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
                  child: Column(
                    children: [
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
                        obscureText: _isObscure,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'cette  mot de passe est tres courte';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            newPassword = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                    ],
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
                          .EditEmployePassword(Auth.emaill, newPassword);
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
                          .EditMagasinierPassword(Auth.emaill, newPassword);

                      if (EditApi.valid1 == true) {
                        _showDialog('✅', 'votre nom a éte changer avec succés');
                      } else {
                        _showDialog('🤌', 'oops! une erreur est survenue!');
                      }
                    } else {
                      await Provider.of<EditApi>(context, listen: false)
                          .EditAdminPassword(Auth.emaill, newPassword);
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
