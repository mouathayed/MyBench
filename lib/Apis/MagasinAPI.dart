import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mybench/Models/Magasin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'auth.dart';

class MagasinApi with ChangeNotifier {
  static bool delated = false;
  static bool allGood = true;
  static Future<List<Magasin>> getMagasins(String query) async {
    final url =
        Uri.parse('http://$kip:$kport/api/v1/magasin/byadmin/${Auth.adminId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List Magasins = json.decode(response.body);

      return Magasins.map((json) => Magasin.fromJson(json)).where((magasin) {
        final name = magasin.name;
        final place = magasin.place;
        final id = magasin.id;
        final searchLower = query.toLowerCase();

        return name.contains(searchLower) || place.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<void> createMagasin(String email, String password, String phoneNumber,
      String nomComplet, String nomMagasin, String lieuMagasin) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/magasinier'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'nom_magasin': nomMagasin,
          'lieu_magasin': lieuMagasin,
          "admin_id": Auth.adminId,
          'nom_complet': nomComplet,
          'phone': phoneNumber,
          'email': email,
          'password': password,
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedData = jsonDecode(response.body);
      print(decodedData);
      if (decodedData is bool) {
        allGood = false;
        print(decodedData);
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('magasin_id', decodedData['magasin_id']);
        int? magasin_id = prefs.getInt('magasin_id');
        magId = magasin_id!;
        print('magasin_id=$magasin_id');
        print('Magasin créer avec succés');
      }
    } else {
      print('http status code:' + response.statusCode.toString());
    }
  }

  Future<void> DeleteMagasin(int id) async {
    final response = await http.delete(
      Uri.parse('http://$kip:$kport/api/v1/magasin/delete/$id'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    var data = jsonDecode(response.body);
    print('tfasa5= $data');
    delated = data;
  }
}
