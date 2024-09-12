import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:store_finder/providers/bookmarks_provider.dart';
import 'package:store_finder/providers/map_provider.dart';
import 'package:store_finder/providers/navigation_provider.dart';
import 'package:store_finder/providers/reviews_provider.dart';
import 'package:store_finder/widgets/ios_screen_loader.dart';
import 'package:store_finder/utilities/customize_here.dart';
import 'package:store_finder/widgets/android_screen_loader.dart';

void main() {
  runApp(const StoreFinder());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.black.withOpacity(0.5)
    ..backgroundColor = Colors.white
    ..indicatorColor = Customize().mainAppColor
    ..textColor = Customize().mainAppColor
    ..userInteractions = false;
}

class StoreFinder extends StatelessWidget {
  const StoreFinder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Customize().mainAppColor,
          appBarTheme: AppBarTheme(color: Customize().mainAppColor)),
      home: const MyHomePage(title: 'Store Finder'),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NavigationProvider()),
          ChangeNotifierProvider(create: (context) => MapProvider()),
          ChangeNotifierProvider(create: (context) => BookmarksProvider()),
          ChangeNotifierProvider(create: (context) => ReviewsProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Menu',
          home: Platform.isAndroid
              ? const AndroidScreenLoader()
              : const IOSScreenLoader(),
          builder: EasyLoading.init(),
        ));
  }
}
