import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mybench/Models/Employee.dart';
import 'package:mybench/constants.dart';

class EmployeesApi with ChangeNotifier {
  static bool allGood = true;
  static Future<List<Employee>> getEmployees(String query) async {
    final url =
        Uri.parse('http://$kip:$kport/api/v1/employee/bymagasin/$magId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List Employees = json.decode(response.body);

      return Employees.map((json) => Employee.fromJson(json)).where((employee) {
        final emailLower = employee.email.toLowerCase();
        final nameLower = employee.fullName.toLowerCase();
        final phoneNumber = employee.phoneNumber;
        final searchLower = query.toLowerCase();

        return emailLower.contains(searchLower) ||
            phoneNumber.contains(searchLower) ||
            nameLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<void> addEmployee(String email, String phoneNumber, String password,
      String nomComplet) async {
    final response = await http.post(
      Uri.parse('http://$kip:$kport/api/v1/employee'),
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
          //"magasin_id": Auth.role == 'admin' ? magId : Auth.magasin,
          "magasin_id": magId,
        },
      ),
    );
    var data = jsonDecode(response.body);
    if (data is bool) {
      allGood = false;
      print('oh No!');
    } else {
      print('All Good');
    }
  }

  Future<void> DeleteEmployee(int id) async {
    final response = await http.delete(
      Uri.parse('http://$kip:$kport/api/v1/employee/delete/$id'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    var data = jsonDecode(response.body);
    print('tfasa5= $data');
  }
}
