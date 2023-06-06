import 'package:mybench/constants.dart';
import 'package:flutter/material.dart';

class AddMagasinButton extends StatelessWidget {
  AddMagasinButton({
    required this.onPressed,
  });
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 55,
      ),
      child: Material(
        elevation: 5.0,
        color: Colors.greenAccent.shade700,
        borderRadius: BorderRadius.circular(60.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add_circle_rounded,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Center(
                child: Text('Ajouter une\n Magasin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27.0,
                      fontWeight: FontWeight.w900,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
