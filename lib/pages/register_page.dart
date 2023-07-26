// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../components/auth_button.dart';
import '../model/auth_result.dart';
import '../model/register.dart';
import '../model/user_stats.dart';
import '../services/auth_service.dart';
import '../main.dart';
import '../services/user_stats_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

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
  UserStats userStats = UserStats();
  
  String errorText = "";

  bool isElevated = false;
  bool isVisible = false;

  bool badUsername = false;
  bool badEmail = false;
  bool badPassword = false;

  late FocusNode passwordFocus = FocusNode();
  bool focus = false;

  late bool obscure = true;

  @override
  void initState() {
    super.initState();

    passwordFocus.addListener(() {
      if (passwordFocus.hasFocus) {
        setState(() {
          focus = passwordFocus.hasFocus;
        });
      } else {
        focus = false;
      }
    });
  }

  Future<void> buttonActions() async {
    setState(() {
      isElevated = !isElevated;
    });
    Future.delayed(const Duration(milliseconds: 5))
        .then((value) => setState(() {
              inputErrors();
            }));
    if (formKey.currentState!.validate()) {
      authenticate();
    }
  }

  void createUserStats() async {
    userStats = (await UserStatsService().createUserStats(userStats))!;
  }

  Future<void> setUserStats(String statsId) async {
    userStats.id = statsId;
    userStats.entries = 0;
    createUserStats();
  }

  void registerAction() async {
    authResult = (await AuthService().registerAction(register));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {
              errors();
              authenticated();
            }));
  }

  void authenticate() {
    setState(() {
      register.name = _emailController.text;
      register.email = _emailController.text;
      register.password = _passwordController.text;
      registerAction();
    });
  }

  Future<void> authenticated() async {
    print(authResult.token);
    print(authResult.result);
    RootPage.token = authResult.token;
    if (authResult.result == true) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(authResult.token!);
      String decodedUserId = decodedToken["id"];
      setUserStats(decodedUserId);
      isVisible = false;
      setState(() {
        RootPage.logged = true;
      });
      Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {
            context.push('/dashboard');
          }));
    } else if (authResult.result == false) {
      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
            isElevated = !isElevated;
          }));
      isVisible = true;
    }

    final snackBar = SnackBar(
      content: Text('Submitting form...'),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String errors() {
    authResult.errors?.forEach((error) {
      errorText = error;
    });
    return errorText;
  }

  Future<void> inputErrors() async {
    if (badUsername || badEmail || badPassword) {
      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
            isElevated = !isElevated;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                  margin: const EdgeInsets.only(top: 20, bottom: 25),
                  child: Text(
                    "Welcome to PGT!",
                    style: TextStyle(fontSize: 40, color: Color(0xFF363f93)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: TextFormField(
                    controller: _nameController,
                    decoration:
                        InputDecoration(labelText: "Enter your username"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          badUsername = true;
                        });
                        return "Enter correct username";
                      } else {
                        setState(() {
                          badUsername = false;
                        });
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Enter your email"),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                              .hasMatch(value!)) {
                        setState(() {
                          badEmail = true;
                        });
                        return "Enter correct email";
                      } else {
                        setState(() {
                          badEmail = false;
                        });
                        return null;
                      }
                    },
                  ),
                ),
                TextFormField(
                  focusNode: passwordFocus,
                  onTapOutside: (details) {
                    setState(() {
                      passwordFocus.unfocus();
                    });
                  },
                  controller: _passwordController,
                  obscureText: obscure,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      labelText: "Enter your password",
                      suffixIcon: focus
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              child: Icon(Icons.remove_red_eye),
                            )
                          : null),
                  validator: (value) {
                    if (value!.isEmpty) {
                      setState(() {
                        badPassword = true;
                      });
                      return "Enter correct password";
                    } else {
                      setState(() {
                        badPassword = false;
                      });
                      return null;
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 40),
                      child: GestureDetector(
                        onTap: () {
                          context.go('/login');
                        },
                        child: Text(
                          "Back to the \nlogin page...",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    AuthButton(isElevated: isElevated, buttonActions: buttonActions)
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
