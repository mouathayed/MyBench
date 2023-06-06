import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mybench/constants.dart';

class Auth with ChangeNotifier {
  static int adminId = 0;
  static String m = '';
  static String role = '';
  static String emaill = '';
  static String nomMagasin = '';
  static String lieuMagasin = '';
  static int magasin = 0;
  static bool t3ada = true;
  static const url = 'http://$kip:$kport/api/v1/magasinier';
  Future<void> signUp(String email, String password, String phoneNumber,
      String nomComplet) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/admin'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'email': email,
          'phone': int.parse(phoneNumber),
          'password': password,
          'nom_complet': nomComplet,
          'role': 'admin',
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedData = jsonDecode(response.body);
      print(decodedData);
      if (decodedData is bool) {
        t3ada = false;
      } else {
        t3ada = true;
        role = 'admin';
        userRole = role;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', decodedData['email']);
        String? adminEmail = prefs.getString('email');
        emaill = adminEmail!;
        print(emaill);
        userEmail = emaill;
        await prefs.setInt('id', decodedData['id']);
        int? adid = prefs.getInt('id');
        adminId = adid!;
        print('Admin Id= $adminId');
      }
      print('t3ada= $t3ada');
    } else {
      print('http status code:' + response.statusCode.toString());
    }
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
        Uri.parse('http://$kip:$kport/api/v1/employee/login'),
        //badal Adresse IP ki tbadal blastik
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode({
          'email': email,
          'password': password,
        }));
    var data = jsonDecode(response.body);
    print(data);
    if (data is bool) {
      t3ada = false;
    } else {
      t3ada = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('role', data['role']);
      String? hisrole = prefs.getString('role');
      role = hisrole!;
      userRole = role;
      print('role=$hisrole');
      await prefs.setString('email', data['email']);
      String? hisEmail = prefs.getString('email');
      emaill = hisEmail!;
      print(emaill);
      userEmail = email;
      if (role != 'admin') {
        await prefs.setInt('magasin_id', data['magasin_id']);
        int? magasin_id = prefs.getInt('magasin_id');
        magasin = magasin_id!;
        print('magasin_id=$magasin_id');
        magId = magasin_id;
        print('magId=================$magId');
      }
      if (role == 'admin') {
        await prefs.setInt('admin_id', data['admin_id']);
        int? aid = prefs.getInt('admin_id');
        adminId = aid!;
        print('Admin Id= $adminId');
      }
    }
    print('t3ada= $t3ada');
  }

  Future<dynamic> getMagasin(int magasinId) async {
    http.Response resp = await http
        .get(Uri.parse("http://$kip:$kport/api/v1/magasin/$magasinId"));
    var decodedData = jsonDecode(resp.body);
    print(decodedData);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nom_magasin', decodedData[0]['nom_magasin']);
    String? magname = prefs.getString('nom_magasin');
    nomMagasin = magname!;
    //print('ismha: $nomMagasin');
    await prefs.setString('lieu_magasin', decodedData[0]['lieu_magasin']);
    String? magplace = prefs.getString('lieu_magasin');
    lieuMagasin = magplace!;
    //print(magplace);
    //print('blasetha: $lieuMagasin');
    return decodedData;
  }
}
