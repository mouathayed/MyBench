import 'package:flutter/material.dart';
import 'dart:math';

class MagasinButton extends StatelessWidget {
  MagasinButton({
    required this.name,
    required this.place,
    required this.onPressed,
  });
  final String name;
  final String place;

  final void Function() onPressed;
  var colors = [
    Colors.indigo,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.red,
    Colors.pink,
    Colors.purpleAccent,
    Colors.deepOrange,
    Colors.brown,
    Colors.greenAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14.0,
        horizontal: 35,
      ),
      child: Material(
        elevation: 5.0,
        color: Colors.primaries[Random().nextInt(colors.length)],
        borderRadius: BorderRadius.circular(60.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 340.0,
          height: 150.0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.store,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(name,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.place,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(place,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
