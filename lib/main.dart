import 'package:sidebarx/sidebarx.dart';

import 'pages/about_page.dart';
import 'pages/prepared_list_page.dart';
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

    if (neonMode != null) {
      theme = neonMode;
    }
    print(theme);
  }

  Future<void> getFalconPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? falconMode = prefs.getInt("falconMode");

    if (falconMode != null) {
      theme = falconMode;
    }
    print(theme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: theme == 0
          ? ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: primaryBlack,
              appBarTheme: AppBarTheme(backgroundColor: Colors.black),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    Colors.black,
                  ),
                  foregroundColor: MaterialStatePropertyAll<Color>(
                    Colors.white,
                  ),
                ),
              ),
            )
          : ThemeData(
              scaffoldBackgroundColor: Colors.black,
              primarySwatch: primaryBlack,
              appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
              navigationBarTheme: NavigationBarThemeData(
                backgroundColor: Colors.grey[700],
                iconTheme: MaterialStateProperty.resolveWith<IconThemeData>(
                  (Set<MaterialState> states) {
                    return IconThemeData(
                      color: Colors.white,
                    );
                  },
                ),
                labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                  (Set<MaterialState> states) {
                    return TextStyle(color: Colors.white);
                  },
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    Colors.grey[400]!,
                  ),
                  foregroundColor: MaterialStatePropertyAll<Color>(
                    Colors.black,
                  ),
                ),
              ),
            ),
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
      path: '/preparedList',
      builder: (context, state) => PreparedListPage(),
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
  static late String? token;
  static late bool workoutStarted = false;
  static late bool filledOnce = false;
  static late List<String> sectionIdList;
  static late bool cancelToolTip = false;
  static late bool toolTipsOn = true;
  static late int sectionsLength = -1;
  static late var sidebarController =
      SidebarXController(selectedIndex: 0, extended: true);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  //TODO Make sidebar hide after coming back to the dashboard
  void sidebarHide() {
    setState(() {
      RootPage.sidebarController =
          SidebarXController(selectedIndex: 0, extended: false);
      print(RootPage.sidebarController.extended);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RootPage.logged ? DashboardPage() : TitlePage();
  }
}
