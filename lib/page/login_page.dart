// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String name = "";
  bool isElevated = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFffffff),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: formKey, //key for form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 0, top: 20, right: 0, bottom: 25),
                  child: Text(
                    "Welcome back!",
                    style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 0, top: 0, right: 0, bottom: 12),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Enter your email"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter correct email";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    labelText: "Enter your password",
                    ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter correct password";
                    } else {
                      return null;
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 0, top: 0, right: 40, bottom: 0),
                      child: Text(
                        "Haven't made \nan account yet?",
                        style: TextStyle(fontSize: 17),
                        ),
                    ),
                    Container(
                      //MediaQuery.of(context).size.width
                      margin: EdgeInsets.only(
                        left: 0,
                        top: 50,
                        right: 0,
                        bottom: 0,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          //  onPressed: () {
                          //    if (formKey.currentState!.validate()) {}
                          //  },
                          //  child: Text(
                          //    "SUBMIT",
                          //    style: const TextStyle(fontSize: 70),
                          //  ),
                          onTap: () {
                            setState(() {
                              isElevated = !isElevated;
                            });
                            if (formKey.currentState!.validate()) {
                              final snackBar =
                                  SnackBar(content: Text('Submitting form...'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
