//**********************************************************************************
//CALL TO ACTION SECTION OF DETAILS
//**********************************************************************************

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_finder/providers/bookmarks_provider.dart';
import 'package:store_finder/utilities/contact_functions.dart';
import 'package:store_finder/utilities/customize_here.dart';
import 'package:store_finder/utilities/star_rating.dart';
import '../screens/review_list.dart';

class CallToAction extends StatelessWidget {
  final int id;
  final String image;
  final String name;
  final String email;
  final String phone;
  final List<dynamic> reviews;

  const CallToAction({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.reviews,
    required this.email,
    required this.phone,
  }) : super(key: key);

  void openRatings(context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => Reviews(
          placeSelected: name,
          placeSelectedId: id,
        ),
      ),
    );
  }

  void addBookmark(BookmarksProvider provider) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? bookmarks = prefs.getStringList('bookmarks');
    List<String> currentBookmarks = [];

    // get previously saved bookmarks
    if (bookmarks != null) {
      for (var bookmark in bookmarks) {
        currentBookmarks.add(bookmark);
      }
    }

    //check if bookmark was saved before
    var newBookmark = id.toString();
    if (currentBookmarks.contains(newBookmark)) {
      currentBookmarks.remove(newBookmark);
    } else {
      currentBookmarks.add(newBookmark);
    }

    //update shared preferences
    await prefs.setStringList('bookmarks', currentBookmarks);

    //update provider data
    provider.updateBookmarks(currentBookmarks);
  }

  @override
  Widget build(BuildContext context) {
    //bookmarks provider
    final bookmarksProvider = Provider.of<BookmarksProvider>(context);

    return SliverAppBar(
      backgroundColor: Customize().mainAppColor,
      expandedHeight: 350,
      stretch: true,
      actions: [
        //IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        IconButton(
            icon: const Icon(Icons.reviews_outlined),
            onPressed: () {
              openRatings(context);
            }),

        IconButton(
          onPressed: () {
            addBookmark(bookmarksProvider);
          },
          icon: bookmarksProvider.getBookmarks.contains(id.toString())
              ? const Icon(Icons.bookmark)
              : const Icon(Icons.bookmark_add_outlined),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.30), BlendMode.srcOver),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 80),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    //width: 300,
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RatingStars(
                    onValueChanged: (value) => {openRatings(context)},
                    value: StarRatingOperations(reviews).calculateRating(),
                    valueLabelVisibility: false,
                    starSize: 23,
                    starColor: Colors.yellow.shade700,
                    starOffColor: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          openUrl('tel:$phone');
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white30,
                          radius: 25,
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      InkWell(
                        onTap: () {
                          openUrl('mailto:$email');
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white30,
                          radius: 25,
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
