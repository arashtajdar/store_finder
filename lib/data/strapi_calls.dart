//***********************************************************************************************************
//STRAPI API
//Keep all Strapi calls in this file
//***********************************************************************************************************
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:store_finder/models/category_model.dart';
import 'package:store_finder/models/news_model.dart';
import 'package:store_finder/models/place_model.dart';
import 'package:store_finder/models/review_model.dart';
import 'package:store_finder/utilities/api_keys.dart';
import 'package:http/http.dart' as http;

//***********************************************************************************************************
//PLACES
//***********************************************************************************************************

class StrapiCalls {
  //general headers
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  Future<List<PlaceModel>?> fetchPlaces({
    required List<dynamic>? filterByCategories,
    required List<String>? filterByBookmarks,
  }) async {
    List<PlaceModel> allPlaces = [];

    String endpoint = '${APIKeys.strapiLink}/api/places?populate=*';
    Uri url = Uri.parse(endpoint);
    var response = await http.get(url, headers: headers);

    //handle errors
    if (response.statusCode != 200) {
      throw ('Error loading places');
    }

    var parsedJson = jsonDecode(response.body);
    var data = parsedJson['data'];
    List<dynamic> dataList = data;

    //Return places filtered by categories
    if (filterByCategories != null && filterByBookmarks == null) {
      var placeNames = [];
      filterByCategories.asMap().forEach((index, item) {
        var i = item as Map<String, dynamic>;
        var pName = i['attributes']['name'].toString();
        placeNames.add(pName);
      });

      for (var i in dataList) {
        var checkPlaceName = i['attributes']['name'];
        if (placeNames.contains(checkPlaceName)) {
          var newCategoryPlace = createPlace(i);
          allPlaces.add(newCategoryPlace);
        }
      }
      return allPlaces;
    } else {
      //return places found in bookmarks (user preferences)
      if (filterByBookmarks != null) {
        for (var i in dataList) {
          var checkPlaceId = i['id'];
          if (filterByBookmarks.contains(checkPlaceId.toString())) {
            var newBookmarkPlace = createPlace(i);
            allPlaces.add(newBookmarkPlace);
          }
        }
        return allPlaces;
      } else {
        //return unfiltered places
        for (var i in dataList) {
          var newPlace = createPlace(i);
          allPlaces.add(newPlace);
        }
        return allPlaces;
      }
    }
  }

  //Create place model
  PlaceModel createPlace(dynamic data) {
    var newPlace = PlaceModel(
      id: data['id'],
      name: data['attributes']?['name'],
      thumbnail: data['attributes']?['thumbnail']?['data']?['attributes']
          ?['url'],
      about: data['attributes']?['about'],
      keywords: data['attributes']['keywords'],
      gallery: data['attributes']?['gallery']?['data'],
      address: data['attributes']?['address'],
      latitude: data['attributes']?['latitude'],
      longitude: data['attributes']?['longitude'],
      website: data['attributes']?['website'],
      reviews: data['attributes']?['reviews']?['data'],
      email: data['attributes']?['email'],
      phone: data['attributes']?['phone'],
    );

    return newPlace;
  }

//***********************************************************************************************************
//CATEGORIES
//***********************************************************************************************************

  Future<List<CategoryModel>?> fetchCategories() async {
    List<CategoryModel> categoryList = [];

    String endpoint = '${APIKeys.strapiLink}/api/categories?populate=*';
    Uri url = Uri.parse(endpoint);
    var response = await http.get(url, headers: headers);

    //handle errors
    if (response.statusCode != 200) {
      throw ('Error loading categories');
    }
    var parsedJson = jsonDecode(response.body);
    var data = parsedJson['data'];
    List<dynamic> dataList = data;

    for (var i in dataList) {
      var newCategory = CategoryModel(
        id: i['id'],
        name: i['attributes']?['name'],
        image: i['attributes']?['image']?['data']?['attributes']?['url'],
        placeList: i['attributes']?['places']?['data'],
      );

      categoryList.add(newCategory);
    }

    //sort alphabetically and return
    categoryList.sort((a, b) => a.name.compareTo(b.name));
    return (categoryList);
  }

//***********************************************************************************************************
//NEWS
//***********************************************************************************************************

  Future<List<NewsModel>?> fetchNews() async {
    List<NewsModel> newsList = [];

    String endpoint = '${APIKeys.strapiLink}/api/news?populate=*';
    Uri url = Uri.parse(endpoint);
    var response = await http.get(url, headers: headers);

    //handle errors
    if (response.statusCode != 200) {
      throw ('Error loading news - ${response.statusCode}');
    }

    var parsedJson = jsonDecode(response.body);
    var data = parsedJson['data'];
    List<dynamic> dataList = data;

    for (var i in dataList) {
      //format newspiece date
      var reviewDate = i['attributes']?['createdAt'];
      var parseDate = DateTime.parse(reviewDate);
      var formatedDate = DateFormat('MMMM dd, yyyy').format(parseDate);

      var newPiece = NewsModel(
        id: i['id'],
        image: i['attributes']?['image']?['data']?['attributes']?['url'],
        title: i['attributes']?['title'],
        content: i['attributes']?['content'],
        date: formatedDate,
      );
      newsList.add(newPiece);
    }

    return (newsList);
  }

//***********************************************************************************************************
//REVIEWS
//***********************************************************************************************************

  Future<List<ReviewModel>?> fetchReviews(String placeSelected) async {
    List<ReviewModel> reviewList = [];

    String endpoint = '${APIKeys.strapiLink}/api/reviews?populate=place';
    Uri url = Uri.parse(endpoint);
    var response = await http.get(url, headers: headers);

    //handle errors
    if (response.statusCode != 200) {
      throw ('Error loading reviews');
    }

    var parsedJson = jsonDecode(response.body);
    var data = parsedJson['data'];
    List<dynamic> dataList = data;

    for (var i in dataList) {
      //format review date
      var reviewDate = i['attributes']?['createdAt'];
      var parseDate = DateTime.parse(reviewDate);
      var formatedDate = DateFormat('MMMM dd, yyyy').format(parseDate);

      var reviewPlace =
          i['attributes']?['place']?['data']?['attributes']?['name'];
      if (reviewPlace == placeSelected) {
        var newReview = ReviewModel(
          id: i['id'],
          review: i['attributes']?['review'],
          rating: i['attributes']?['rating'],
          date: formatedDate,
        );
        reviewList.add(newReview);
      }
    }
    //show new comments first
    reviewList = reviewList.reversed.toList();
    return (reviewList);
  }

  Future<void> saveReview(usrReview, usrRating, placeRelation) async {
    var endpoint = '${APIKeys.strapiLink}/api/reviews';
    var url = Uri.parse(endpoint);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    var reviewObj = jsonEncode({
      'data': {
        'review': usrReview,
        'rating': usrRating,
        'place': placeRelation,
      }
    });

    //post review, show error/success and dismiss loading
    var response = await http.post(url, headers: headers, body: reviewObj);
    if (response.statusCode != 200) {
      throw ('Error posting review, please try again');
    }
  }
}
