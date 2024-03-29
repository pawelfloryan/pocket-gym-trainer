import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  late String imagePath = "";
  late String text = "";

  EmptyList({
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 80, right: 75, left: 75),
          child: Image.asset(imagePath),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 15,
          ),
          width: 290,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
