import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mybench/Screens/EditMagasin/EditMagasinPlace.dart';
import '../constants.dart';

class EditApi with ChangeNotifier {
  static bool valid1 = false;
  Future<void> EditEmployeName(String email, String nomComplet) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/employee/changeNom_complet'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'email': email,
          'nom_complet': nomComplet,
        },
      ),
    );
    var data = jsonDecode(response.body);
    valid1 = data;
    print(valid1);
  }

  Future<void> EditEmployeNumber(String email, String phoneNumber) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/employee/changePhone'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'email': email,
          'phone': phoneNumber,
        },
      ),
    );
    var data = jsonDecode(response.body);
    print(valid1);
    valid1 = data;
  }

  Future<void> EditEmployePassword(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/employee/changePassword'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    var data = jsonDecode(response.body);
    valid1 = data;
    print(valid1);
  }

  Future<void> EditMagasinierName(String email, String nomComplet) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/magasinier/changeNom_complet'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'email': email,
          'nom_complet': nomComplet,
        },
      ),
    );
    var data = jsonDecode(response.body);
    valid1 = data;
    print(valid1);
  }

  Future<void> EditMagasinierNumber(String email, String phoneNumber) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/magasinier/changePhone'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'email': email,
          'phone': phoneNumber,
        },
      ),
    );
    var data = jsonDecode(response.body);
    valid1 = data;
    print(valid1);
  }

  Future<void> EditMagasinierPassword(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/magasinier/changePassword'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    var data = jsonDecode(response.body);
    valid1 = data;
    print(valid1);
  }

  Future<void> EditAdminName(String email, String nomComplet) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/admin/changeNom_complet'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'email': email,
          'nom_complet': nomComplet,
        },
      ),
    );
    var data = jsonDecode(response.body);
    valid1 = data;
    print(valid1);
  }

  Future<void> EditAdminNumber(String email, String phoneNumber) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/admin/changePhone'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'email': email,
          'phone': phoneNumber,
        },
      ),
    );
    var data = jsonDecode(response.body);
    valid1 = data;
    print(valid1);
  }

  Future<void> EditAdminPassword(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/admin/changePassword'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    var data = jsonDecode(response.body);
    valid1 = data;
    print(valid1);
  }

  Future<void> EditMagasinName(String nom) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/magasin/changenom_magasin'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {"nom_magasin": nom, "magasin_id": magId},
      ),
    );
    var data = jsonDecode(response.body);
    valid1 = data;
    print(valid1);
  }

  Future<void> EditMagasinPlace(String place) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/magasin/changelieu_magasin'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {"lieu_magasin": place, "magasin_id": magId},
      ),
    );
    var data = jsonDecode(response.body);
    valid1 = data;
    print(valid1);
  }
}
