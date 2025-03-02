import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeMode _changeTheme=ThemeMode.light;
  ThemeMode get changeTheme=>_changeTheme;

  void changeDeviceTheme(ThemeMode theme){
    _changeTheme=theme;
    notifyListeners();
  }


}