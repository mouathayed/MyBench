import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  ScanButton({
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
        vertical: 20.0,
        horizontal: 10,
      ),
      child: Material(
        elevation: 5.0,
        color: Colors.greenAccent.shade700,
        borderRadius: BorderRadius.circular(60.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 50.0,
          height: 50.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.white,
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
