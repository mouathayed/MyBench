import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:mybench/Widget/ScanButton.dart';
import 'package:mybench/Widget/NavigationDrawer.dart';
import 'package:mybench/constants.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Apis/BenchMarkingApi.dart';

class InventaireConcurrent extends StatefulWidget {
  static const routeName = '/inventaire_Concurrent';
  @override
  State<InventaireConcurrent> createState() => _InventaireConcurrentState();
}

class _InventaireConcurrentState extends State<InventaireConcurrent> {
  String nom = '';
  String lieu = '';
  String _BarCode = '';
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _BarCodecontroller = TextEditingController();
  TextEditingController _Pricecontroller = TextEditingController();
  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  void initState() {
    super.initState();
    _BarCodecontroller.text = "";
    updateUI(concurrentId);
  }

  Future<void> updateUI(int magasinID) async {
    await BenchMarkingApi().getMagasinConcurrent(magasinID);
    setState(() {
      BenchMarkingApi().getMagasinConcurrent(magasinID);
      nom = BenchMarkingApi.nomMagasin;
      lieu = BenchMarkingApi.lieuMagasin;
    });
  }

  _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", 'Cancel', true, ScanMode.BARCODE)
        .then((value) => setState(() => _BarCodecontroller.text = value));
    int currentValue = int.parse(_BarCodecontroller.text);
  }

  Map<String, String> _InventaireData = {
    'codeEAN': '',
    'prix': '',
  };
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        //backgroundColor: const Color(0xFF0097A7),
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
          'Inventaire Concurrent',
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 55),
            child: Column(
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
                          nom.toUpperCase(),
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
                          lieu.toUpperCase(),
                          style: const TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //FlatButton(onPressed: _scan, child: Text("Scan Barcode")),
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
                                    });
                                  },
                                ),
                              ),
                              ScanButton(
                                  title: 'scan',
                                  onPressed: _scan,
                                  icon: Icons.camera),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
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
                    onSaved: (value) {
                      setState(() {
                        _InventaireData['prix'] = value!;
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
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
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
                              .inventaireConcurrent(
                                  int.parse(_InventaireData['codeEAN']!),
                                  double.parse(_InventaireData['prix']!));
                          if (BenchMarkingApi.allgood == true) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                title: const Icon(
                                  Icons.done_rounded,
                                  color: Colors.green,
                                  size: 70,
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
                                          InventaireConcurrent.routeName);
                                    },
                                  )
                                ],
                              ),
                            );
                          } else {
                            _showErrorDialog('OH OH!!');
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
                              Icons.add_circle,
                              size: 25,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text('Envoyer',
                                style: TextStyle(
                                  fontSize: 20,
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
