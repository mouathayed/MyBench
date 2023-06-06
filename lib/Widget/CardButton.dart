import 'package:mybench/constants.dart';
import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  CardButton({
    required this.title,
    required this.line,
    required this.couleur,
    required this.onPressed,
    required this.icon,
  });
  final String title;
  final String line;
  final Color couleur;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5,
      ),
      child: Material(
        elevation: 5.0,
        color: couleur,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 320.0,
          height: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Icon(
                    icon,
                    size: 50,
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Center(
                child: Text(
                  line,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
