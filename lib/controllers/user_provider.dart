import 'package:flutter/foundation.dart';
import 'package:ndi_new/models/user.dart';

class UserProvider with ChangeNotifier {
  User _user = new User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void removeUser() {
    _user = new User();
    notifyListeners();
  }
}