import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 35, bottom: 10),
              child: GestureDetector(
                onTap: () {
                  context.go('/login');
                },
                child: const FaIcon(
                  FontAwesomeIcons.arrowLeftLong,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(
                left: 40,
                top: 35,
              ),
              child: const Text(
                "Forgot\nPassword",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 40, top: 30, bottom: 50),
              child: const Text(
                "Select contact details which\nshould be used to reset\nyour password:",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    wordSpacing: 1,
                    height: 1.2),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 40),
              width: 275,
              height: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                ),
                onPressed: (() {}),
                child: Row(
                  children: [
                    const Icon(
                      Icons.phone_android_sharp,
                      size: 50,
                      color: Colors.black,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Text(
                            "via sms:",
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 25),
                          child: const Text(
                            "••• ••• 782",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 40, top: 25),
              width: 275,
              height: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                ),
                onPressed: (() {}),
                child: Row(
                  children: [
                    const Icon(
                      Icons.mail_outline,
                      size: 50,
                      color: Colors.black,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 40, right: 35),
                          child: Text(
                            "via email:",
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 25),
                          child: const Text(
                            "••••@mail.com",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
