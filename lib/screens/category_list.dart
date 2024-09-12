//**********************************************************************************
//CATEGORY LIST SCREEN
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:store_finder/models/category_model.dart';
import 'package:store_finder/data/strapi_calls.dart';
import 'package:store_finder/widgets/missing_list_banner.dart';
import 'package:store_finder/widgets/category_cell.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<CategoryModel>? snapList;

    return Scaffold(
      body: FutureBuilder(
        future: StrapiCalls().fetchCategories(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              EasyLoading.show();
              return ListView();
            case ConnectionState.done:
              EasyLoading.dismiss();
              if (snapshot.hasError) {
                EasyLoading.showError('${snapshot.error}');
              }

              snapList = snapshot.data as List<CategoryModel>?;
              MissingListBanner missingListBanner = const MissingListBanner(
                message: "No Categories",
                icon: Icons.category,
              );

              if (snapList != null) {
                if (snapList!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapList!.length,
                    itemBuilder: (context, index) {
                      return CategoryCell(
                        cellName: snapList![index].name,
                        cellImg: snapList![index].image,
                        cellPlaces: snapList![index].placeList ?? [],
                      );
                    },
                  );
                } else {
                  return missingListBanner; //nothing to show
                }
              }
              return missingListBanner; //loading
          }
        },
      ),
    );
  }
}
