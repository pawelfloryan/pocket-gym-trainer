import 'pages/about_page.dart';
import 'pages/muscle_map.dart';
import 'pages/profile_page.dart';
import 'pages/forgot_password_page.dart';
import 'pages/title_page.dart';
import 'package:flutter/material.dart';
import '../model/login.dart';
import 'pages/exercises_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/section_page.dart';
import 'pages/stats_page.dart';
import 'pages/home_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/settings_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      path: '/title',
      builder: (context, state) => TitlePage(),
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
    GoRoute(
      path: '/forgotPassword',
      builder: (context, state) => ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfilePage(),
    ),
    GoRoute(
      path: '/muscleMap',
      builder: (context, state) => MuscleMapPage(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => AboutPage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => SettingsPage(),
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
  static late String token;
  static late int theme = 0;

  Future<void> getLightPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? lightMode = prefs.getInt("lightMode");

    if (lightMode != null) {
      theme = lightMode;
    }
    print(theme);
  }

  Future<void> getDarkPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? darkMode = prefs.getInt("darkMode");

    if (darkMode != null) {
      theme = darkMode;
    }
    print(theme);
  }

  Future<void> getNeonPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? neonMode = prefs.getInt("neonMode");

    if(neonMode != null){
      theme = neonMode;
    }
    print(theme);
  }

  Future<void> getFalconPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? falconMode = prefs.getInt("falconMode");

    if(falconMode != null){
      theme = falconMode;
    }
    print(theme);
  }

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return RootPage.logged ? DashboardPage() : TitlePage();
  }
}
