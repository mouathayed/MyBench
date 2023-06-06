import 'package:mybench/Components/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatefulWidget {
  @override
  State<ChangeThemeButtonWidget> createState() =>
      _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Row(
      children: [
        const SizedBox(width: 20),
        Icon(
          themeChange.darkTheme ? Icons.dark_mode : Icons.light_mode,
        ),
        const SizedBox(width: 30),
        Text(
          themeChange.darkTheme ? "Dark mode" : "Light mode",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 40),
        Switch.adaptive(
          value: themeChange.darkTheme,
          onChanged: (value) {
            setState(() {
              themeChange.darkTheme = value;
            });
            //final provider = Provider.of<ThemeProvider>(context, listen: false);
            //provider.toggleTheme(value);
          },
        ),
      ],
    );
  }
}
