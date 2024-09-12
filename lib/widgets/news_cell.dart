//**********************************************************************************
//CUSTOM LIST TILE FOR NEWS SECTION
//**********************************************************************************

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/news_details.dart';

class NewsCell extends StatelessWidget {
  final String title;
  final String image;
  final String? content;
  final String date;

  const NewsCell({
    Key? key,
    required this.screenWidth,
    required this.title,
    required this.image,
    required this.content,
    required this.date,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            fullscreenDialog: false,
            builder: (context) => NewsDetails(
              image: image,
              title: title,
              content: content,
              date: date,
            ),
          ),
        );
      },
      child: Container(
        //width: screenWidth,
        height: 320,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: screenWidth,
              height: 100,
              color: const Color.fromRGBO(0, 0, 0, 0.65),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            date,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
