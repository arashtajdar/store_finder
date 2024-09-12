//**********************************************************************************
//CATEGORY LIST SCREEN
//Keeps track of the tab bar (iOS Only)
//Keeps track of the screen displayed
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:store_finder/screens/category_list.dart';
import 'package:store_finder/screens/map_main.dart';
import 'package:store_finder/screens/news_list.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  static final List<Widget> _appSections = <Widget>[
    const MapMain(),
    const CategoryList(),
    const NewsList()
  ];

  final List<String> _sectionTitles = ['Map', 'Categories', 'News'];

  //GETTERS
  //**********************************************************************************
  int get selectedIndex => _selectedIndex;

  Widget get currentSection => _appSections[_selectedIndex];

  String get currentTitle => _sectionTitles[_selectedIndex];

  //SETTERS
  //**********************************************************************************
  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
