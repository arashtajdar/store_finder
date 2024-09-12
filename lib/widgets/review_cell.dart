//**********************************************************************************
//CUSTOM LIST TILE FOR REVIEWS
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:store_finder/models/review_model.dart';

class ReviewCell extends StatelessWidget {
  final int index;
  final List<ReviewModel> reviewList;

  const ReviewCell({
    Key? key,
    required this.reviewList,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(width: 20),
            RatingStars(
              value: reviewList[index].rating.toDouble(),
              starSize: 15,
              starColor: Colors.yellow.shade700,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(reviewList[index].review),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                reviewList[index].date,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
