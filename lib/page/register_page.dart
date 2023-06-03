// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymbro/model/auth_result.dart';
import '../model/register.dart';
import '../services/auth_service.dart';
import '../main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static late bool loggedInto = false;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Register register = Register();
  AuthResult authResult = AuthResult();
  String errorText = "";

  bool isElevated = false;
  bool isVisible = false;

  void registerAction() async {
    authResult = (await AuthService().registerAction(register));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void authenticate() {
    setState(() {
      register.name = _emailController.text;
      register.email = _emailController.text;
      register.password = _passwordController.text;
      registerAction();
      errors();
    });
  }

  String errors() {
    authResult.errors?.forEach((error) {
      errorText = error;
    });
    return errorText;
  }

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
                    "Welcome to PGT!",
                    style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 0, top: 0, right: 0, bottom: 12),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Enter your username"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter correct email";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 0, top: 0, right: 0, bottom: 12),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Enter your email"),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                              .hasMatch(value!)) {
                        return "Enter correct email";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
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
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Text(
                          "Back to the \nlogin page",
                          style: TextStyle(fontSize: 17),
                        ),
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
                            onTapDown: (details) {
                              setState(() {
                                isElevated = !isElevated;
                              });
                              if (formKey.currentState!.validate()) {
                                authenticate();
                                Future.delayed(const Duration(seconds: 5))
                                    .then((value) => setState(() {}));
                                print(authResult.token);
                                print(authResult.result);
                                if (authResult.result == true) {
                                  isVisible = false;
                                  RegisterPage.loggedInto = true;
                                  setState(() {
                                    RootPage.logged = true;
                                  });
                                  Future.delayed(const Duration(seconds: 2))
                                      .then((value) => setState(() {
                                            context.push('/dashboard');
                                          }));
                                  //TODO Update both tables with userId keys
                                  // and specify which sections to show
                                } else if (authResult.result == false) {
                                  isVisible = true;
                                }

                                final snackBar = SnackBar(
                                  content: Text('Submitting form...'),
                                  duration: Duration(seconds: 1),
                                );
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
                Visibility(
                  visible: isVisible,
                  child: Text(
                    "Error: " + errorText,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
