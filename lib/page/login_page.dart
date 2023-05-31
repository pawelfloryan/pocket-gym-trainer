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

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                SizedBox(height: height * 0.04),
                Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                ),
                SizedBox(height: height * 0.04),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter your email"
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Enter correct email";
                    }else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter your password"
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Enter correct password";
                    }else {
                      return null;
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
