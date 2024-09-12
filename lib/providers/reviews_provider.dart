//**********************************************************************************
//REVIEWS PROVIDER
//Keeps track of
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:store_finder/models/review_model.dart';

class ReviewsProvider extends ChangeNotifier {
  //api related
  final List<ReviewModel> _reviewList = [];

  List<ReviewModel> get getReviews => _reviewList;

  void updateReviews(List<ReviewModel> newReviews) {
    _reviewList.clear();
    _reviewList.addAll(newReviews);
    notifyListeners();
  }

  //rating related
  double _rating = 0;

  double get getRating => _rating;

  void updateRating(double updatedRating) {
    _rating = updatedRating;
    notifyListeners();
  }
}
