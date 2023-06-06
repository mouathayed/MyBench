import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mybench/Models/MagasinConcurrent.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class BenchMarkingApi with ChangeNotifier {
  static String nomMagasin = '';
  static String lieuMagasin = '';
  static bool allRight = true;
  static bool allgood = true;
  static Future<List<MagasinConcurrent>> getMagasinsconcurrent(
      String query) async {
    final url = Uri.parse('http://$kip:$kport/api/v1/magasin_concurrent');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List Magasins = json.decode(response.body);

      return Magasins.map((json) => MagasinConcurrent.fromJson(json))
          .where((magasinConcurrent) {
        final name = magasinConcurrent.name;
        final place = magasinConcurrent.place;
        final id = magasinConcurrent.id;
        final searchLower = query.toLowerCase();

        return name.contains(searchLower) || place.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<void> createMagasinConcurrent(
      String nomMagasin, String lieuMagasin) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/magasin_concurrent'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'nom': nomMagasin,
          'lieu': lieuMagasin,
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedData = jsonDecode(response.body);
      print(decodedData);
      if (decodedData is bool) {
        allRight = false;
        print(decodedData);
      } else {
        allRight = true;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('id', decodedData['id']);
        int? magasin_id = prefs.getInt('id');
        concurrentId = magasin_id!;
        print('magasin_id=$magasin_id');
        print('Magasin créer avec succés');
      }
    } else {
      print('http status code:' + response.statusCode.toString());
    }
  }

  Future<void> inventaireConcurrent(int codeEAN, double prix) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/magasin_concurrent'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          "libellé_du_produit": "tropico 1l",
          'codeean': codeEAN,
          'prix': prix,
          "id_magasin_concurrent": concurrentId
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedData = jsonDecode(response.body);
      print(decodedData);
      if (decodedData == false) {
        allgood = false;
        print(decodedData);
      } else {
        allgood = true;
        print(decodedData);
      }
    } else {
      print('http status code:' + response.statusCode.toString());
    }
  }

  Future<dynamic> getMagasinConcurrent(int magasinId) async {
    http.Response resp = await http.get(Uri.parse(
        "http://$kip:$kport/api/v1/magasin_concurrent/$concurrentId"));
    var decodedData = jsonDecode(resp.body);
    print(decodedData);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nom', decodedData[0]['nom']);
    String? magname = prefs.getString('nom');
    nomMagasin = magname!;
    print('ismha: $nomMagasin');
    await prefs.setString('lieu', decodedData[0]['lieu']);
    String? magplace = prefs.getString('lieu');
    lieuMagasin = magplace!;
    //print(magplace);
    print('blasetha: $lieuMagasin');
    return decodedData;
  }
}
