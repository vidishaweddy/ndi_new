import 'package:flutter/material.dart';
import 'package:ndi_new/models/user.dart';
import 'package:ndi_new/pages/dashboard_page.dart';
import 'package:ndi_new/pages/service_page.dart';
import 'package:ndi_new/pages/login_page.dart';
import 'package:ndi_new/pages/profile_page.dart';
import 'package:ndi_new/pages/setting_page.dart';
import 'package:ndi_new/controllers/user_provider.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatelessWidget {
  final User? user;

  DrawerPage({this.user});

  @override
  Widget build(BuildContext context) {
    User currentUser = user == null ? Provider.of<UserProvider>(context).user : user!;
    return SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black54,
                ),
                accountName: Text(currentUser.name!),
                accountEmail: Text("I/C Number: " + currentUser.icNumber!),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                  Theme.of(context).platform == TargetPlatform.iOS
                      ? Colors.blue
                      : Colors.white,
                  child: Text(
                    "J",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                title: Text('Dashboard'),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => DashBoardPage(user: currentUser)));
                },
              ),
              ListTile(
                title: Text('Services'),
                leading: Icon(Icons.add_business_outlined),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ServicePage(user: currentUser)));
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage(user: currentUser)));
                },
                leading: Icon(Icons.account_circle_rounded),
                title: Text('Profile'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SettingPage(user: currentUser)));
                },
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              ListTile(
                onTap: () {
                  Provider.of<UserProvider>(context, listen: false).removeUser();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
                },
                leading: Icon(Icons.logout_outlined),
                title: Text('Log Out'),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}