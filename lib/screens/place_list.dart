//**********************************************************************************
//PLACE LIST SCREEN
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:store_finder/data/strapi_calls.dart';
import 'package:store_finder/utilities/customize_here.dart';
import 'package:store_finder/widgets/place_cell.dart';
import 'package:store_finder/models/place_model.dart';
import 'package:store_finder/widgets/missing_list_banner.dart';

class PlaceList extends StatelessWidget {
  final List<PlaceModel>? snapList;

  const PlaceList({
    Key? key,
    required this.snapList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MissingListBanner missingListBanner =
        const MissingListBanner(message: "No Places", icon: Icons.place);
    if (snapList != null) {
      if (snapList!.isNotEmpty) {
        return ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemBuilder: (context, index) {
            return PlaceCell(
              snapList: snapList!,
              index: index,
            );
          },
          itemCount: snapList!.length,
        );
      } else {
        return missingListBanner;
      }
    } else {
      return missingListBanner;
    }
  }
}

class Places extends StatefulWidget {
  final List<dynamic> categoryPlaces;
  final String categoryName;
  const Places(
      {Key? key, required this.categoryPlaces, required this.categoryName})
      : super(key: key);

  @override
  State<Places> createState() => _PlacesState();
}

List<PlaceModel> placeList = [];

class _PlacesState extends State<Places> {
  @override
  Widget build(BuildContext context) {
    late List<PlaceModel>? snapList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Customize().mainAppColor,
        title: Text(widget.categoryName),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: CustomSearch(placesList: snapList!));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: StrapiCalls().fetchPlaces(
            filterByCategories: widget.categoryPlaces, filterByBookmarks: null),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const PlaceList(snapList: null);
            case ConnectionState.waiting:
              EasyLoading.show();
              return const PlaceList(snapList: null);
            case ConnectionState.active:
              EasyLoading.show();
              return const PlaceList(snapList: null);
            case ConnectionState.done:
              EasyLoading.dismiss();
              if (snapshot.hasError) {
                EasyLoading.showError('Error: ${snapshot.error}');
              }
              snapList = snapshot.data as List<PlaceModel>?;
              return PlaceList(snapList: snapList);
          }
        },
      ),
    );
  }
}

//***********************************************************************************************************
//SEARCH FUNCTIONS
//***********************************************************************************************************

class CustomSearch extends SearchDelegate {
  late final List<PlaceModel> placesList;

  CustomSearch({required this.placesList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_outlined),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<PlaceModel> allPlaces = placesList
        .where(
          (place) => place.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView.builder(
      itemCount: allPlaces.length,
      itemBuilder: (context, index) => PlaceCell(
        snapList: allPlaces,
        index: index,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<PlaceModel> placeSuggestions = placesList
        .where(
          (place) => place.keywords.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      itemCount: placeSuggestions.length,
      itemBuilder: (context, index) => PlaceCell(
        snapList: placeSuggestions,
        index: index,
      ),
    );
  }
}
