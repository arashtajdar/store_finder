//**********************************************************************************
//BOOKMARKS LIST SCREEN
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_finder/data/strapi_calls.dart';
import 'package:store_finder/models/place_model.dart';
import 'package:store_finder/providers/bookmarks_provider.dart';
import 'package:store_finder/utilities/customize_here.dart';
import 'place_list.dart';

class BookmarksList extends StatefulWidget {
  const BookmarksList({Key? key}) : super(key: key);

  @override
  State<BookmarksList> createState() => BookmarksListState();
}

List<PlaceModel> placeList = [];

class BookmarksListState extends State<BookmarksList> {
  @override
  void initState() {
    super.initState();
    updateBookmarks().then((bookmarkList) {
      final readProvider = context.read<BookmarksProvider>();
      readProvider.updateBookmarks(bookmarkList);
    });
  }

  Future<List<String>> updateBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? bookmarks = prefs.getStringList('bookmarks');
    return bookmarks ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final bookmarksProvider = Provider.of<BookmarksProvider>(context);
    List<String> bookmarkedPlaces = bookmarksProvider.getBookmarks;

    late List<PlaceModel>? snapList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Customize().mainAppColor,
        title: const Text('Bookmarks'),
      ),
      body: FutureBuilder(
        future: StrapiCalls().fetchPlaces(
          filterByCategories: null,
          filterByBookmarks: bookmarkedPlaces,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                EasyLoading.showError('Error: ${snapshot.error}');
              }
              snapList = snapshot.data as List<PlaceModel>?;
              if (snapList != null) {
                return PlaceList(snapList: snapList);
              } else {
                return ListView();
              }
          }
        },
      ),
    );
  }
}
