//**********************************************************************************
//BOOKMARKS PROVIDER
//Takes care of tracking the 'SharedPreferences' bookmarks
//Calls to 'SharedPreferences' are done on the screen that requires it.
//**********************************************************************************

import 'package:flutter/material.dart';

class BookmarksProvider extends ChangeNotifier {
  final List<String> _bookmarksList = [];

  List<String> get getBookmarks => _bookmarksList;

  void updateBookmarks(List<String> newBookmarks) {
    _bookmarksList.clear();
    _bookmarksList.addAll(newBookmarks);
    notifyListeners();
  }
}
