import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mybench/constants.dart';
import 'package:mybench/Models/Produit.dart';

class ProduitApi with ChangeNotifier {
  static Future<List<Produit>> getProduits(String query) async {
    final url = Uri.parse('http://$kip:$kport/api/v1/produit');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List Produits = json.decode(response.body);

      return Produits.map((json) => Produit.fromJson(json)).where((produit) {
        final libelleLower = produit.libelle.toLowerCase();
        final codeEAN = produit.codeEAN;
        final searchLower = query.toLowerCase();

        return libelleLower.contains(searchLower) ||
            codeEAN.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
