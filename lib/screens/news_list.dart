//**********************************************************************************
//NEWS LIST SCREEN
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:store_finder/data/strapi_calls.dart';
import 'package:store_finder/models/news_model.dart';
import 'package:store_finder/widgets/missing_list_banner.dart';
import 'package:store_finder/widgets/news_cell.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<NewsModel>? snapList;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
          future: StrapiCalls().fetchNews(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return ListView();
              case ConnectionState.active:
                EasyLoading.show();
                return ListView();
              case ConnectionState.waiting:
                EasyLoading.show();
                return ListView();
              case ConnectionState.done:
                EasyLoading.dismiss();
                if (snapshot.hasError) {
                  EasyLoading.showError('Error: ${snapshot.error}');
                }

                snapList = snapshot.data as List<NewsModel>?;
                MissingListBanner missingListBanner = const MissingListBanner(
                  message: "No News",
                  icon: Icons.newspaper,
                );
                if (snapList != null) {
                  if (snapList!.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return NewsCell(
                          screenWidth: screenWidth,
                          content: snapList![index].content,
                          date: snapList![index].date,
                          image: snapList![index].image,
                          title: snapList![index].title,
                        );
                      },
                      itemCount: snapList!.length,
                    );
                  } else {
                    return missingListBanner; //Nothing to show
                  }
                }
                return missingListBanner; //loading or missing
            }
          }),
    );
  }
}
