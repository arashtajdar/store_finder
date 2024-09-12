//**********************************************************************************
//CREATE NEW REVIEW SCREEN
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_finder/data/strapi_calls.dart';
import 'package:store_finder/providers/reviews_provider.dart';
import 'package:store_finder/utilities/customize_here.dart';

// ignore: must_be_immutable
class ReviewCreate extends StatelessWidget {
  final int placeRelation;
  ReviewCreate({Key? key, required this.placeRelation}) : super(key: key);

  TextEditingController reviewController = TextEditingController();

  double finalRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Customize().mainAppColor,
        title: const Text('My Review'),
        actions: [
          IconButton(
            onPressed: () {
              if (reviewController.text.isEmpty == false && finalRating != 0) {
                EasyLoading.show(status: 'Saving Review...');
                StrapiCalls()
                    .saveReview(
                  reviewController.text,
                  finalRating,
                  placeRelation,
                )
                    .then((_) {
                  blockReviews();
                  EasyLoading.dismiss().then((_) {
                    Navigator.pop(context);
                  });
                }).onError((error, stackTrace) {
                  EasyLoading.showError(
                      'There was an error saving the comment');
                });
              } else {
                EasyLoading.showToast(
                    'Make sure to provide a rating and a review');
              }
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: Consumer<ReviewsProvider>(
                builder: (context, reviewsState, child) {
                  return RatingStars(
                    value: reviewsState.getRating,
                    onValueChanged: (rating) {
                      reviewsState.updateRating(rating);
                      finalRating = rating;
                    },
                    valueLabelVisibility: false,
                    starSize: 40,
                    starColor: Colors.yellow.shade700,
                    starOffColor: Colors.grey.shade300,
                  );
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: reviewController,
              decoration: const InputDecoration(
                  hintText: 'Write you review here...',
                  border: InputBorder.none),
              maxLines: null,
              maxLength: 500,
            ),
          ),
        ],
      ),
    );
  }

//block more reviews from this user
  void blockReviews() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? reviewed = prefs.getStringList('reviewedPlaces');
    List<String> currentReviewed = [];

    //rebuild the array with previously reviewed places
    if (reviewed != null) {
      for (var id in reviewed) {
        currentReviewed.add(id);
      }
    }

    //add new place id if it doesn't exist in array
    var placeId = placeRelation.toString();
    if (!currentReviewed.contains(placeId)) {
      currentReviewed.add(placeId);
    }

    //save
    await prefs.setStringList('reviewedPlaces', currentReviewed);
  }
}
