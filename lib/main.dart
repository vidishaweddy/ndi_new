import 'package:flutter/material.dart';
import 'package:ndi_new/pages/dashboard_page.dart';
import 'package:ndi_new/pages/login_page.dart';
import 'package:ndi_new/controllers/auth_provider.dart';
import 'package:ndi_new/controllers/user_provider.dart';
import 'package:ndi_new/utils/user_preferences.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (Provider.of<UserProvider>(context).user.token == null)
                      return LoginPage();
                    return DashBoardPage(user: snapshot.data as User);
                }
              }),
          routes: {
            '/dashboard': (context) => DashBoardPage(),
            '/login': (context) => LoginPage(),
          }),
    );
  }
}