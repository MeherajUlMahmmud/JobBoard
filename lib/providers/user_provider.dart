import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic> _user = {};
  Map<String, dynamic> _tokens = {};

  void setUser(Map<String, dynamic> user) {
    _user = user;
    notifyListeners();
  }

  void setTokens(Map<String, dynamic> tokens) {
    _tokens = tokens;
    notifyListeners();
  }

  Map<String, dynamic> get user => _user;
  Map<String, dynamic> get tokens => _tokens;
}
