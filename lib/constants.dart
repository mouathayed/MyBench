import 'package:flutter/material.dart';

//const khomeButtonColor = Color(0xFF009688);
const khomeButtonColor = Color.fromRGBO(50, 75, 205, 1);
const kbuttonColor = Color(0xFF001B35);
const khomeButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);
const kip = '192.168.1.18';
const kport = '3020';
const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class BM {
  BM._();

  static const _kFontFam = 'BMI';
  static const String? _kFontPkg = null;

  static const IconData icon = IconData(
    0xe800,
    fontFamily: _kFontFam,
    fontPackage: _kFontPkg,
  );
}

int magId = 0;
int concurrentId = 0;
String userRole = '';
String userEmail = '';
