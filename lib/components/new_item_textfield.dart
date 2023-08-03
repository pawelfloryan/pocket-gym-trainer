import 'package:flutter/material.dart';

class NewItemTextField extends StatelessWidget {
  String text = "";
  double opacity = 0;
  var textController = TextEditingController();
  final void Function() onClicked;
  final Future<void> Function() addElement;
  final Color backgroundColor;
  final Color iconColor;

  NewItemTextField({
    required this.text,
    required this.opacity,
    required this.textController,
    required this.onClicked,
    required this.addElement,
    required this.backgroundColor,
    required this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin:
                const EdgeInsets.only(right: 10, bottom: 10),
            child: FloatingActionButton(
              backgroundColor: backgroundColor,
              onPressed: () {
                onClicked();
              },
              child: Icon(
                Icons.add,
                color: iconColor,
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 150),
          opacity: opacity,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width - 90,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3.5),
                  color: Colors.white),
              margin: EdgeInsets.only(
                right: screenSize.width * 0.15,
                bottom: 10,
              ),
              child: Container(
                margin:
                    const EdgeInsets.only(left: 7),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: text,
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      color: Colors.black,
                      onPressed: addElement,
                      icon: Icon((Icons.done)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
