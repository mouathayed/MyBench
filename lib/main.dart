import 'package:mybench/Apis/BenchMarkingApi.dart';
import 'package:mybench/Components/dark_theme_provider.dart';
import 'package:mybench/Screens/EditAccount/EditPassword.dart';
import 'package:mybench/Screens/InventaireProduit.dart';
import 'package:flutter/material.dart';
import 'package:mybench/Screens/AuthenticationScreen.dart';
import 'Apis/EditApi.dart';
import 'Apis/MagasinAPI.dart';
import 'Apis/MagasinierApi.dart';
import 'Components/themeData.dart';
import 'Screens/HomeScreen.dart';
import 'package:mybench/Apis/auth.dart';
import 'package:provider/provider.dart';
import 'Screens/InventaireProduit.dart';
import 'Screens/EmployeesScreen.dart';
import 'Screens/AddEmployee.dart';
import 'Apis/EmployeesApi.dart';
import 'Apis/inventaireApi.dart';
import 'Screens/InventairePix.dart';
import 'Screens/InventairesScreen.dart';
import 'Screens/produitsScreen.dart';
import 'Screens/Edit.dart';
import 'package:mybench/Screens/EditAccount/EditName.dart';
import 'Screens/EditAccount/EditNumber.dart';
import 'Screens/MagasinsScreen.dart';
import 'Screens/AddMagasin.dart';
import 'Screens/BenchMarkingScreen.dart';
import 'Screens/MagasinierScreen.dart';
import 'Screens/AddMagasinier.dart';
import 'Screens/MagasinsConScreen.dart';
import 'Screens/concurrentScreen.dart';
import 'Screens/AddMagasinCon.dart';
import 'Screens/EditMagasin/EditMagasin.dart';
import 'Screens/EditMagasin/EditMagasinName.dart';
import 'Screens/EditMagasin/EditMagasinPlace.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return themeChangeProvider;
          }),
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider.value(
            value: MagasinApi(),
          ),
          ChangeNotifierProvider.value(
            value: MagasinierApi(),
          ),
          ChangeNotifierProvider.value(
            value: EmployeesApi(),
          ),
          ChangeNotifierProvider.value(
            value: InventaireApi(),
          ),
          ChangeNotifierProvider.value(
            value: BenchMarkingApi(),
          ),
          ChangeNotifierProvider.value(
            value: EditApi(),
          ),
        ],
        child:
            Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
          return MaterialApp(
              title: 'MyBench',
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              home: AuthScreen(),
              routes: {
                MagasinierScreen.routeName: (context) => MagasinierScreen(),
                MagasinsScreen.routeName: (ctx) => MagasinsScreen(),
                AddMagasinier.routeName: (ctx) => AddMagasinier(),
                AddMagasin.routeName: (ctx) => AddMagasin(),
                AddMagasinCon.routeName: (ctx) => AddMagasinCon(),
                Edit.routeName: (ctx) => Edit(),
                EditName.routeName: (ctx) => EditName(),
                EditNumber.routeName: (ctx) => EditNumber(),
                EditPassword.routeName: (ctx) => EditPassword(),
                EditMagasin.routeName: (ctx) => EditMagasin(),
                EditMagasinName.routeName: (ctx) => EditMagasinName(),
                EditMagasinPlace.routeName: (ctx) => EditMagasinPlace(),
                AddEmployee.routeName: (ctx) => AddEmployee(),
                EmployeesScreen.routeName: (ctx) => EmployeesScreen(),
                HomeScreen.routeName: (ctx) => HomeScreen(),
                AuthScreen.routeName: (ctx) => AuthScreen(),
                InventaireProduitScreen.routeName: (ctx) =>
                    InventaireProduitScreen(),
                InventairePrixScreen.routeName: (ctx) => InventairePrixScreen(),
                InventaireScreen.routeName: (ctx) => InventaireScreen(),
                ProduitsScreen.routeName: (ctx) => ProduitsScreen(),
                BenchMarkingScreen.routeName: (ctx) => BenchMarkingScreen(),
                MagasinsConScreen.routeName: (ctx) => MagasinsConScreen(),
                InventaireConcurrent.routeName: (ctx) => InventaireConcurrent()
              });
        }));
  }
}
