import 'package:flutter/material.dart';

class RecoverOption extends StatelessWidget {
  String text1 = "";
  String text2 = "";

  RecoverOption({required this.text1, required this.text2});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40),
          child: Text(
            text1,
            style: TextStyle(color: Colors.grey[400], fontSize: 15),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 25),
          child: Text(
            text2,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
