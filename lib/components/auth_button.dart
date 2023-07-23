import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  bool isElevated = false;
  final Future<void> Function() buttonActions;

  AuthButton({required this.isElevated, required this.buttonActions});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 0,
        top: 50,
        right: 0,
        bottom: 0,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTapDown: (details) async {
            await buttonActions();
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              boxShadow: isElevated
                  ? [
                      BoxShadow(
                          color: Colors.grey[500]!,
                          offset: Offset(4, 4),
                          blurRadius: 15,
                          spreadRadius: 1),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1),
                    ]
                  : null,
            ),
            child: Icon(
              Icons.arrow_forward,
              size: 75,
            ),
          ),
        ),
      ),
    );
  }
}
