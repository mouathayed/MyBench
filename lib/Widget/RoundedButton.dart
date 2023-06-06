import 'package:mybench/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({
    required this.title,
    required this.onPressed,
    required this.icon,
  });
  final String title;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 35,
      ),
      child: Material(
        elevation: 5.0,
        color: khomeButtonColor,
        borderRadius: BorderRadius.circular(60.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 320.0,
          height: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
              const SizedBox(
                width: 25,
              ),
              Text(title, style: khomeButtonTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}
