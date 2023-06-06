import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  DeleteButton({
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(90.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 10.0,
          height: 10.0,
          child: const Icon(
            Icons.remove_circle,
            size: 22,
          ),
        ),
      ),
    );
  }
}
