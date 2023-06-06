import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mybench/Models/Magasinier.dart';
import 'package:mybench/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';

class MagasinierApi with ChangeNotifier {
  static bool done = true;
  static Future<List<Magasinier>> getMagasinier(String query) async {
    final url =
        Uri.parse('http://$kip:$kport/api/v1/magasinier/bymagasin/$magId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List Magasiniers = json.decode(response.body);

      return Magasiniers.map((json) => Magasinier.fromJson(json))
          .where((magasinier) {
        final email = magasinier.email.toLowerCase();
        final name = magasinier.fullName.toLowerCase();
        final phoneNumber = magasinier.phoneNumber;
        final magasinName = magasinier.magasinName;
        final magasinPlace = magasinier.magasinPlace;
        final id = magasinier.id;
        final searchLower = query.toLowerCase();

        return email.contains(searchLower) ||
            phoneNumber.contains(searchLower) ||
            name.contains(searchLower) ||
            magasinName.contains(searchLower) ||
            magasinPlace.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<void> addMagasinier(String email, String phoneNumber, String password,
      String nomComplet) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/magasinier/magasinierbymagasin'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'email': email,
          'phone': phoneNumber,
          'password': password,
          'nom_complet': nomComplet,
          "admin_id": Auth.adminId,
          "magasin_id": magId,
        },
      ),
    );
    var data = jsonDecode(response.body);
    if (data == bool) {
      print(data);
      done = false;
      print('oooops!!!');
    } else {
      done = true;
      print(data);
      print('done');
    }
  }

  Future<void> DeleteMagasinier(int id) async {
    final response = await http.delete(
      Uri.parse('http://$kip:$kport/api/v1/magasinier/delete/$id'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    var data = jsonDecode(response.body);
    print('tfasa5= $data');
  }
}
