import 'package:flutter/material.dart';

class NewItemTextField extends StatelessWidget {
  String text = "";
  bool notClicked = false;
  var textController = TextEditingController();
  final void Function() onClicked;
  final Future<void> Function() addElement;

  NewItemTextField({
    required this.text,
    required this.notClicked,
    required this.textController,
    required this.onClicked,
    required this.addElement,
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
                const EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 10),
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                onClicked();
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Visibility(
          visible: notClicked,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width - 90,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3.5),
                  color: Colors.white),
              margin: EdgeInsets.only(
                left: 0,
                right: screenSize.width * 0.15,
                top: 0,
                bottom: 10,
              ),
              child: Container(
                margin:
                    const EdgeInsets.only(left: 7, top: 0, right: 0, bottom: 0),
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
