//**********************************************************************************
//NEWS DETAIL SCREEN
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:store_finder/utilities/customize_here.dart';

class NewsDetails extends StatefulWidget {
  final String image;
  final String title;
  final String? content;
  final String date;

  const NewsDetails(
      {Key? key,
      required this.image,
      required this.title,
      required this.content,
      required this.date})
      : super(key: key);

  @override
  //_NewsDetailsState createState() => _NewsDetailsState();
  State<NewsDetails> createState() {
    return _NewsDetailsState();
  }
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    //var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          stretch: true,
          backgroundColor: Customize().mainAppColor,
          expandedHeight: screenHeight / 2.40,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [StretchMode.zoomBackground],
            background: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, height: 1.3),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 15, color: Colors.grey.shade600),
                      const SizedBox(width: 5),
                      Text(
                        widget.date,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.content ?? "",
                    style: const TextStyle(fontSize: 16, height: 1.8),
                  ),
                  const SizedBox(height: 100)
                ],
              ),
            )
          ]),
        )
      ],
    ));
  }
}
