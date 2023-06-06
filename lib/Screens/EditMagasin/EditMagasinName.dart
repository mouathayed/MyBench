import 'package:flutter/material.dart';
import 'package:mybench/Apis/EditApi.dart';
import 'package:mybench/Screens/EditMagasin/EditMagasin.dart';
import 'package:mybench/Widget/NavigationDrawer.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class EditMagasinName extends StatefulWidget {
  static const routeName = '/edit_magasin_name';

  @override
  State<EditMagasinName> createState() => _EditMagasinNameState();
}

class _EditMagasinNameState extends State<EditMagasinName> {
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String newName = '';
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
              child: const Text(
                'Ok',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, EditMagasin.routeName);
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
                'Saisir le nouveau nom de votre magasin',
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
                        labelText: 'Saisir le nouveau nom'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Saisir le nouveau nom';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      newName = value!;
                      print(newName);
                      print(magId);
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
                    await Provider.of<EditApi>(context, listen: false)
                        .EditMagasinName(newName);
                    if (EditApi.valid1 == true) {
                      _showDialog('✅',
                          'le nom de votre magasin a été changer avec succés.');
                    } else {
                      _showDialog('🤌', 'oops! une erreur est survenue!');
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
