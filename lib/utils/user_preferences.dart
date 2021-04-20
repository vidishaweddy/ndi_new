import 'package:ndi_new/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("userId", user.userId!);
    prefs.setString("name", user.name == null ? '' : user.name!);
    prefs.setString("icNumber", user.icNumber!);
    prefs.setString("phone", user.phone == null ? '' : user.phone!);
    prefs.setString("type", user.type == null ? '' : user.type!);
    prefs.setString("token", user.token!);
    prefs.setString("renewalToken", user.renewalToken!);

    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? userId = prefs.getInt("userId");
    String? name = prefs.getString("name");
    String? icNumber = prefs.getString("icNumber");
    String? phone = prefs.getString("phone");
    String? type = prefs.getString("type");
    String? token = prefs.getString("token");
    String? renewalToken = prefs.getString("renewalToken");
    return new User(
        userId: userId,
        name: name,
        icNumber: icNumber,
        phone: phone,
        type: type,
        token: token,
        renewalToken: renewalToken);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("type");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    return token;
  }
}