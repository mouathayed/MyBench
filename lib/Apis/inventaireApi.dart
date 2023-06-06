import 'package:flutter/material.dart';
import 'dart:convert';
import '../Models/Inventaire.dart';
import 'package:http/http.dart' as http;
import 'package:mybench/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';

class InventaireApi with ChangeNotifier {
  Future<void> invProduit(
      String libelle, int codeEAN, double prix, int quantite) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/inventaire'),
      //ki yerka7 api employé badal url
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'labelle': libelle,
          'codeean': codeEAN,
          'prix': prix,
          'quantite': quantite,
          "magasin_id": magId,
        },
      ),
    );
    var data = jsonDecode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('validation', data);
    bool? validation = prefs.getBool('validation');
    print(validation);
  }

  Future<void> invPrix(int codeEAN, double prix) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/inventaire/changePrix'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'codeean': codeEAN,
          'prix': prix,
          'magasin_id': magId,
        },
      ),
    );
    var data = jsonDecode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('valid', data);
    bool? valid = prefs.getBool('valid');
    print(valid);
  }

  static Future<List<Inventaire>> getInventaire(String query) async {
    final url =
        Uri.parse('http://$kip:$kport/api/v1/inventaire/bymagasin/$magId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List Inventaires = json.decode(response.body);

      return Inventaires.map((json) => Inventaire.fromJson(json))
          .where((inventaire) {
        final codeEAN = inventaire.codeEAN;
        final quantite = inventaire.quantite;
        final prix = inventaire.prix;
        final libelle = inventaire.libelle;
        final searchLower = query.toLowerCase();

        return codeEAN.contains(searchLower) ||
            quantite.contains(searchLower) ||
            prix.contains(searchLower) ||
            libelle.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
