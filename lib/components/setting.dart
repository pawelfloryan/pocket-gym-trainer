import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  late String text = "";
  final Widget child;
  bool clicked = false;
  late void Function()? onClicked;
  Setting({
    required this.text,
    required this.child,
    required this.clicked,
    this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: Colors.grey[200]!),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10, left: 15),
            child: Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onClicked,
                child: Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Transform.rotate(
                    angle: !clicked ? 0 : 1.5,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
