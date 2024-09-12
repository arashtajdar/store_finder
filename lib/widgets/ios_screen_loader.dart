//**********************************************************************************
//IOS SCREEN LOADER
//Controls the apps navigation with a bottom navigation bar. iOS use only.
//**********************************************************************************

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_finder/providers/navigation_provider.dart';
import 'package:store_finder/screens/bookmarks_list.dart';
import 'package:store_finder/utilities/customize_here.dart';

class IOSScreenLoader extends StatelessWidget {
  const IOSScreenLoader({super.key});

  void openBookmarks(context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: false,
        builder: (context) => const BookmarksList(),
      ),
    );
  }

  Widget customBottomBar() {
    return Consumer<NavigationProvider>(
      builder: (context, navigationState, child) {
        return BottomNavigationBar(
          currentIndex: navigationState.selectedIndex,
          selectedItemColor: Customize().mainAppColor,
          onTap: (index) {
            navigationState.updateSelectedIndex(index);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.map_outlined),
              label: Customize.mapSection,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.list_alt_outlined),
              label: Customize.categoriesSection,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.announcement_outlined),
              label: Customize.newsSection,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
        builder: (context, navigationState, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Customize().mainAppColor,
          title: Text(navigationState.currentTitle),
          actions: navigationState.currentTitle == Customize.categoriesSection
              ? [
                  IconButton(
                      icon: const Icon(Icons.bookmark),
                      onPressed: () {
                        openBookmarks(context);
                      })
                ]
              : [],
        ),
        body: navigationState.currentSection,
        bottomNavigationBar: customBottomBar(),
      );
    });
  }
}
