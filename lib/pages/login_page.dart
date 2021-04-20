import 'package:flutter/material.dart';
import 'package:ndi_new/utils/user_preferences.dart';
import 'package:ndi_new/controllers/auth_provider.dart';
import 'package:ndi_new/controllers/user_provider.dart';
import 'package:ndi_new/pages/dashboard_page.dart';
import 'package:ndi_new/models/user.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication auth = LocalAuthentication();
  final formKey = new GlobalKey<FormState>();

  String? _username, _password;

  Future<void> _authenticate() async {
    User user = await UserPreferences().getUser();
    bool isBiometricSupported = await auth.isDeviceSupported();
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    bool isAuthenticated = false;
    if (user.userId != null && isBiometricSupported && canCheckBiometrics) {

      if (Provider.of<UserProvider>(context, listen: false).user.token == null) {
        isAuthenticated = await auth.authenticate(
          localizedReason: 'Please complete the biometrics to proceed.',
          biometricOnly: true,
        );

        if (mounted && isAuthenticated) {
          Provider.of<UserProvider>(context, listen: false).setUser(user);
        }
      }
    }

    return;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._authenticate();
    if (Provider.of<UserProvider>(context).user.userId != null) {
      return DashBoardPage();
    }
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      validator: (value) => value!.isEmpty ? "Please enter I/C Number" : null,
      onSaved: (value) => _username = value!,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(4.0))),
        labelText: 'I/C Number',
        contentPadding: EdgeInsets.all(10.0),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value!.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(4.0))),
        labelText: 'password',
        contentPadding: EdgeInsets.all(10.0),
      ),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    var doLogin = () {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> successfulMessage =
        auth.login(_username!, _password!);

        successfulMessage.then((response) {
          if (response['status']) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            final snackBar = SnackBar(
              content: Text(response['message']['message'].toString()),
              duration: const Duration(milliseconds: 300),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      } else {
        print("form is invalid");
      }
    };

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.all(50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    usernameField,
                    const Padding(padding: EdgeInsets.all(12)),
                    passwordField,
                    const Padding(padding: EdgeInsets.all(12)),
                    auth.loggedInStatus == Status.Authenticating
                        ? loading
                        : MaterialButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: doLogin,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

