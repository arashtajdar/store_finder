//**********************************************************************************
//CUSTOM LIST TILE FOR CATEGORIES SECTION
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:store_finder/screens/place_list.dart';

class CategoryCell extends StatelessWidget {
  final String cellName;
  final String cellImg;
  final List<dynamic> cellPlaces;

  const CategoryCell({
    Key? key,
    required this.cellName,
    required this.cellImg,
    required this.cellPlaces,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Places(
                categoryPlaces: cellPlaces,
                categoryName: cellName,
              ),
            ),
          );
        },
        child: Container(
          width: screenWidth,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(cellImg),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.40),
                BlendMode.srcOver,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(
              cellName,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 34,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
