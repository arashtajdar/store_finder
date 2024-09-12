//**********************************************************************************
//DRAWER PROVIDER
//Keeps track of the hamburger menu drawer (Android Only)
//**********************************************************************************

import 'package:flutter/material.dart';

class DrawerProvider extends ChangeNotifier {
  bool _isDrawerOpen = false;

  bool get isDrawerOpen => _isDrawerOpen;

  void openDrawer() {
    _isDrawerOpen = true;
    notifyListeners();
  }

  void closeDrawer() {
    _isDrawerOpen = false;
    notifyListeners();
  }
}
