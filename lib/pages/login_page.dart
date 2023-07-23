import 'package:PocketGymTrainer/components/auth_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/auth_result.dart';
import '../model/login.dart';
import '../services/auth_service.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Login login = Login();
  AuthResult authResult = AuthResult();

  String errorText = "";

  bool processing = false;

  bool isElevated = false;
  bool isVisible = false;

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
    if (!processing) {
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
    } else if (processing) {
      null;
    }
  }

  void loginAction() async {
    authResult = (await AuthService().loginAction(login));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {
              errors();
              authenticated();
            }));
  }

  Future<void> authenticate() async {
    setState(() {
      login.email = _emailController.text;
      login.password = _passwordController.text;
      loginAction();
    });
  }

  Future<void> authenticated() async {
    print(authResult.token);
    print(authResult.result);
    RootPage.token = authResult.token;
    if (authResult.result == true) {
      isVisible = false;
      setState(() {
        RootPage.logged = true;
        processing = !processing;
      });
      Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {
            context.go('/dashboard');
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
    if (badEmail || badPassword) {
      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
            isElevated = !isElevated;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 35, bottom: 10),
              child: GestureDetector(
                onTap: () {
                  context.go('/title');
                },
                child: FaIcon(
                  FontAwesomeIcons.arrowLeftLong,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
            ),
          ),
          Container(
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
                      style: TextStyle(fontSize: 40, color: Color(0xFF363f93)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 0, top: 0, right: 0, bottom: 12),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Enter your email",
                      ),
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
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: obscure
                                      ? Colors.black
                                      : Color(0xFF363f93),
                                ),
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
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 0, top: 50, right: 40, bottom: 0),
                            child: GestureDetector(
                              onTap: () {
                                context.go('/register');
                              },
                              child: Text(
                                "Haven't made \nan account yet?",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 0, top: 30, right: 72, bottom: 0),
                            child: GestureDetector(
                              onTap: () {
                                context.go('/forgotPassword');
                              },
                              child: Text(
                                "Forgot your\npassword?",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                      AuthButton(isElevated: isElevated, buttonActions: buttonActions)
                    ],
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Text(
                        "Error: " + errorText,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
