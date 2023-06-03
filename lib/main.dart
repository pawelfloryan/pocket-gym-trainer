import 'package:flutter/material.dart';
import 'package:gymbro/model/login.dart';
import 'package:gymbro/page/exercises_page.dart';
import 'package:gymbro/page/login_page.dart';
import 'package:gymbro/page/register_page.dart';
import 'package:gymbro/page/section_page.dart';
import 'package:gymbro/page/stats_page.dart';
import 'package:gymbro/page/home_page.dart';
import 'package:gymbro/page/dashboard_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: primaryBlack),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => RootPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => DashboardPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/sections',
      builder: (context, state) => SectionPage(),
    ),
    GoRoute(
      path: '/exercises',
      builder: (context, state) => ExercisesPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterPage(),
    ),
  ],
);

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

class RootPage extends StatefulWidget {
  const RootPage({super.key});
  static late bool logged = false;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  @override
  Widget build(BuildContext context) {
    return RootPage.logged ?
      DashboardPage()
      : LoginPage();
  }
}
