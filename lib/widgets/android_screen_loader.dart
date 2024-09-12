//**********************************************************************************
//ANDROID SCREEN LOADER
//Controls the apps navigation with a custom drawer. Android use only.
//**********************************************************************************

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_finder/providers/navigation_provider.dart';
import 'package:store_finder/screens/bookmarks_list.dart';
import 'package:store_finder/utilities/customize_here.dart';

class AndroidScreenLoader extends StatelessWidget {
  const AndroidScreenLoader({super.key});

  void openBookmarks(context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: false,
        builder: (context) => const BookmarksList(),
      ),
    );
  }

  //default app bar height
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<NavigationProvider>(
        builder: (context, navigationState, child) {
          return navigationState.currentSection;
        },
      ),
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: Consumer<NavigationProvider>(
          builder: (context, navigationState, child) {
            return AppBar(
              backgroundColor: Customize().mainAppColor,
              title: Text(navigationState.currentTitle),
              actions:
                  navigationState.currentTitle == Customize.categoriesSection
                      ? [
                          IconButton(
                              icon: const Icon(Icons.bookmark),
                              onPressed: () {
                                openBookmarks(context);
                              })
                        ]
                      : [],
            );
          },
        ),
      ),
      drawer: Consumer<NavigationProvider>(
        builder: (context, navigationState, child) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              children: [
                ListTile(
                  tileColor: navigationState.selectedIndex == 0
                      ? Colors.grey.shade200
                      : null,
                  leading: const Icon(Icons.map_outlined),
                  title: Text(Customize.mapSection),
                  onTap: () {
                    navigationState.updateSelectedIndex(0);
                    Scaffold.of(context).closeDrawer();
                  },
                ),
                ListTile(
                  tileColor: navigationState.selectedIndex == 1
                      ? Colors.grey.shade200
                      : null,
                  leading: const Icon(Icons.list_alt_outlined),
                  title: Text(Customize.categoriesSection),
                  onTap: () {
                    navigationState.updateSelectedIndex(1);
                    Scaffold.of(context).closeDrawer();
                  },
                ),
                ListTile(
                  tileColor: navigationState.selectedIndex == 2
                      ? Colors.grey.shade200
                      : null,
                  leading: const Icon(Icons.announcement_outlined),
                  title: Text(Customize.newsSection),
                  onTap: () {
                    navigationState.updateSelectedIndex(2);
                    Scaffold.of(context).closeDrawer();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
