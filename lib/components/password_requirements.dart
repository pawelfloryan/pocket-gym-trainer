import 'package:flutter/material.dart';

class PasswordRequirements extends StatelessWidget {
  late void Function() popContext;

  PasswordRequirements({
    required this.popContext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        child: Text("Password requirements"),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    popContext;
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 10, bottom: 10),
                    child: Text(
                      "Close",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                )
              ],
              title: const Text("Password must have:"),
              content: Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "- a non-alphanumeric character",
                    ),
                    const Text(
                      "- a number",
                    ),
                    const Text(
                      "- at least 6 characters",
                    ),
                    const Text(
                      "- an uppercase character",
                    ),
                    const Text(
                      "- a lowercase character",
                    ),
                  ],
                ),
              ),
              contentPadding: const EdgeInsets.all(15.0),
            ),
          );
        },
      ),
    );
  }
}
