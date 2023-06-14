import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';
import '../page/dashboard_page.dart';
import '../main.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sidebarController =
        SidebarXController(selectedIndex: 0, extended: true);

    return Container(
      child: SidebarX(
        controller: _sidebarController,
        animationDuration: Duration(seconds: 0),
        items: [
          SidebarXItem(
            iconWidget: Container(
              margin: EdgeInsets.only(left: 50),
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          //Make Icons.person a user image
          SidebarXItem(
            icon: Icons.supervised_user_circle_rounded,
            label: 'Your profile',
            onTap: (() {
              context.push('/profile');
            }),
          ),
          SidebarXItem(icon: Icons.map_outlined, label: 'Muscle Map'),
          SidebarXItem(
            icon: Icons.logout_sharp,
            label: 'Sign out',
            onTap: (() {
              RootPage.logged = false;
              //DashboardPage.logOut = true;
              //TODO Find out how to make the context pop() not go()
              context.go('/');
            }),
          ),
        ],
        theme: const SidebarXTheme(
          itemTextPadding: const EdgeInsets.all(10.0),
          itemMargin: EdgeInsets.only(left: 10, top: 0, right: 0, bottom: 0),
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          selectedIconTheme: IconThemeData(color: Colors.white),
          selectedTextStyle: TextStyle(color: Colors.white),
          selectedItemTextPadding:
              EdgeInsets.only(left: 5, top: 0, right: 0, bottom: 0),
        ),
        extendedTheme: const SidebarXTheme(
          width: 175,
          textStyle: TextStyle(color: Colors.white),
        ),
        showToggleButton: false,
      ),
    );
  }
}
