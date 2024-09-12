//**********************************************************************************
//REVIEW RATING CALCULATIONS
//**********************************************************************************

class StarRatingOperations {
  final List<dynamic> reviews;
  const StarRatingOperations(this.reviews);

  List<dynamic> getReviewRatings() {
    var ratinglist = [];
    reviews.asMap().forEach((key, value) {
      var review = value as Map<String, dynamic>;
      var reviewRating = review['attributes']['rating'];
      ratinglist.add(reviewRating);
    });
    return ratinglist;
  }

  Map countRatings() {
    var ratingsList = getReviewRatings();
    var map = Map();
    ratingsList.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });
    return map;
  }

  double calculateRating() {
    var map = countRatings();
    var stepOne = 0.0;
    var stepTwo = 0.0;
    var finalRating = 0.0;
    map.forEach((key, value) {
      stepOne += key * value;
      stepTwo += value;
    });

    //avoid division by 0
    if (stepOne != 0 && stepTwo != 0) {
      finalRating = (stepOne / stepTwo);
    } else {
      //places start at 5 stars
      return 5.0;
    }

    return finalRating;
  }
}
