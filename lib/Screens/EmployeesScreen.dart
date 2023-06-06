import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mybench/Models/Employee.dart';
import 'package:mybench/Apis/EmployeesApi.dart';
import 'package:mybench/Screens/AddEmployee.dart';
import 'package:mybench/Widget/DeleteButton.dart';
import 'package:mybench/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/Employee.dart';
import '../Widget/NavigationDrawer.dart';

class EmployeesScreen extends StatefulWidget {
  static const routeName = '/Employees';
  @override
  EmployeesScreenState createState() => EmployeesScreenState();
}

class EmployeesScreenState extends State<EmployeesScreen> {
  List<Employee> employees = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final employees = await EmployeesApi.getEmployees(query);

    setState(() => this.employees = employees);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title:
              const Text('Liste des employées', style: TextStyle(fontSize: 18)),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10,
              ),
              child: Material(
                elevation: 5.0,
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(60.0),
                child: MaterialButton(
                  onPressed: (() {
                    Navigator.pushNamed(context, AddEmployee.routeName);
                  }),
                  minWidth: 40,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.person_add,
                        size: 17,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Ajouter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  return buildEmployee(employee);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Numéro portable ou Email',
        onChanged: searchEmployee,
      );

  Future searchEmployee(String query) async => debounce(() async {
        final employees = await EmployeesApi.getEmployees(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.employees = employees;
        });
      });

  Widget buildEmployee(Employee employee) => ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                const SizedBox(
                  child: Icon(
                    Icons.account_circle,
                    size: 60,
                    color: Colors.cyan,
                  ),
                  width: 60,
                  height: 60,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        employee.fullName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (employee.phoneNumber != null)
                        Text(
                          employee.phoneNumber,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      else
                        const Text(
                          'no number',
                          style: TextStyle(color: Colors.black),
                        )
                    ]),
              ],
            ),
            DeleteButton(onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => CupertinoAlertDialog(
                        title: const Text('Confirmer',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20)),
                        content: const Text(
                          'Supprimer se employée?',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Non')),
                          FlatButton(
                              onPressed: () async {
                                await Provider.of<EmployeesApi>(context,
                                        listen: false)
                                    .DeleteEmployee(employee.id);
                                Navigator.pushNamed(
                                    context, EmployeesScreen.routeName);
                              },
                              child: const Text('Oui')),
                        ],
                      ));
            })
          ],
        ),
      );
}
