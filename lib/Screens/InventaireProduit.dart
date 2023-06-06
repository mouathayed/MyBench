import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:mybench/Widget/ScanButton.dart';
import 'package:mybench/Widget/NavigationDrawer.dart';
import 'package:mybench/constants.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Apis/inventaireApi.dart';

class InventaireProduitScreen extends StatefulWidget {
  static const routeName = '/inventaire_produit';
  @override
  State<InventaireProduitScreen> createState() =>
      _InventaireProduitScreenState();
}

class _InventaireProduitScreenState extends State<InventaireProduitScreen> {
  String _BarCode = '';
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _BarCodecontroller = TextEditingController();
  TextEditingController _Quantitycontroller = TextEditingController();
  TextEditingController _Pricecontroller = TextEditingController();
  Map<String, String> _InventaireData = {
    'codeEAN': '',
    'prix': '',
    'libelle': '',
    'quantite': '',
  };
  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  void initState() {
    super.initState();
    _BarCodecontroller.text = "";
    _Quantitycontroller.text = "0";
  }

  _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", 'Cancel', true, ScanMode.BARCODE)
        .then((value) => setState(() => _BarCodecontroller.text = value));
    int currentValue = int.parse(_BarCodecontroller.text);
  }

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
          'Inventaire Produit',
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 55),
            child: Column(
              children: [
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Container(
                      height: 80,
                      width: 600,
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 2.0,
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          //int currentValue = int.parse(_controller.text);
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                labelText: 'Code a Barre',
                                contentPadding: const EdgeInsets.all(8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              controller: _BarCodecontroller,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: false,
                                signed: true,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Saisie le Code a Barre du produit ';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _InventaireData['codeEAN'] = value;
                                  print(_InventaireData['codeEAN']);
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _InventaireData['codeEAN'] = value!;
                                  print(_InventaireData['codeEAN']);
                                });
                              },
                            ),
                          ),
                          ScanButton(
                            title: 'scan',
                            onPressed: _scan,
                            icon: Icons.camera,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'libellé du produit'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Saisie le libellé du produit ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _InventaireData['libelle'] = value!;
                      print(_InventaireData['libelle']);
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  child: TextFormField(
                    controller: _Pricecontroller,
                    decoration: kTextFieldDecoration.copyWith(
                        suffixText: 'TND', labelText: 'prix du produit'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Saisie le prix de produit ';
                      }
                      return null;
                    },
                    onSaved: (string) {
                      setState(() {
                        _InventaireData['prix'] = string!;
                        print(_InventaireData['prix']);
                      });
                    },
                    onChanged: (string) {
                      string = '${_formatNumber(string.replaceAll(',', ''))}';
                      _Pricecontroller.value = TextEditingValue(
                        text: string,
                        selection:
                            TextSelection.collapsed(offset: string.length),
                      );
                      print(string);
                    },
                  ),
                ),
                const Text(
                  'Quantite Ajoutée',
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Container(
                      width: 250.0,
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 2.0,
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              child: const Icon(
                                Icons.remove,
                                size: 28.0,
                              ),
                              onTap: () {
                                int currentValue =
                                    int.parse(_Quantitycontroller.text);
                                setState(() {
                                  print("Setting state");
                                  currentValue--;
                                  _Quantitycontroller.text =
                                      (currentValue > 0 ? currentValue : 0)
                                          .toString();
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              controller: _Quantitycontroller,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: false,
                                signed: true,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Saisie la Quantite de produit ';
                                }
                                return null;
                              },
                              onSaved: (_quantitycontroller) {
                                setState(() {
                                  _InventaireData['quantite'] =
                                      _quantitycontroller!;
                                  print(_InventaireData['quantite']);
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              child: const Icon(
                                Icons.add,
                                size: 28.0,
                              ),
                              onTap: () {
                                int currentValue =
                                    int.parse(_Quantitycontroller.text);
                                setState(() {
                                  currentValue++;
                                  _Quantitycontroller.text = (currentValue)
                                      .toString(); // incrementing value
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                          await Provider.of<InventaireApi>(context,
                                  listen: false)
                              .invProduit(
                            _InventaireData['libelle']!,
                            int.parse(_InventaireData['codeEAN']!),
                            double.parse(_InventaireData['prix']!),
                            int.parse(_InventaireData['quantite']!),
                          );
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          bool? validation = prefs.getBool('validation');
                          print(validation);
                          if (validation == true) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                //backgroundColor: const Color(0xFFB2EBF2),
                                title: const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                  size: 90,
                                ),
                                content: const Text(
                                  'Inventaire créer avec succès',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: const Text('Okay'),
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          InventaireProduitScreen.routeName);
                                    },
                                  )
                                ],
                              ),
                            );
                          } else {
                            _showErrorDialog('une erreur est survenue');
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
                            Text('Créer Inventaire',
                                style: TextStyle(
                                  fontSize: 17,
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
