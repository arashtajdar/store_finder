//**********************************************************************************
//REVIEW LIST SCREEN
//**********************************************************************************

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_finder/providers/reviews_provider.dart';
import 'package:store_finder/utilities/customize_here.dart';
import 'package:store_finder/widgets/review_cell.dart';
import 'package:store_finder/data/strapi_calls.dart';
import 'package:store_finder/widgets/missing_list_banner.dart';
import 'review_create.dart';

class Reviews extends StatefulWidget {
  final String placeSelected;
  final int placeSelectedId;

  const Reviews({
    Key? key,
    required this.placeSelected,
    required this.placeSelectedId,
  }) : super(key: key);

  @override
  State<Reviews> createState() {
    return _ReviewsState();
  }
}

class _ReviewsState extends State<Reviews> {
  @override
  void initState() {
    super.initState();
    getCurrentReviews();
  }

  void getCurrentReviews() {
    //EasyLoading.show(status: 'Loading Reviews');
    StrapiCalls().fetchReviews(widget.placeSelected).then((reviewList) {
      final myProvider = context.read<ReviewsProvider>();
      myProvider.updateReviews(reviewList ?? []);
      //EasyLoading.dismiss();
    });
  }

  //check if this place has been reviewed
  Future<bool> isReviewed(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? getReviews = prefs.getStringList('reviewedPlaces');
    //getReviews != null && getReviews.contains(id) ? true : false;
    if (getReviews != null) {
      if (getReviews.contains(id)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<ReviewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Customize().mainAppColor,
        title: const Text('Our Reviews'),
        actions: [
          IconButton(
              onPressed: () async {
                //disable reviews
                var placeId = widget.placeSelectedId.toString();
                await isReviewed(placeId)
                    ? EasyLoading.showToast('You reviewed this place before')
                    : Navigator.of(context)
                        .push(
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => ReviewCreate(
                            placeRelation: widget.placeSelectedId,
                          ),
                        ),
                      )
                        .then((_) {
                        myProvider.updateRating(0); //reset rating
                        getCurrentReviews();
                      });
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      //body: checkForReviews(),
      body: myProvider.getReviews.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: myProvider.getReviews.length,
              itemBuilder: ((context, index) {
                return ReviewCell(
                  reviewList: myProvider.getReviews,
                  index: index,
                );
              }),
            )
          : const MissingListBanner(message: "No Reviews", icon: Icons.star),
    );
  }
}
