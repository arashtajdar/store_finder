//**********************************************************************************
//CUSTOM MAP BANNER
//Pops when a location is tapped on the map
//Opens place details
//Can be dismissed when clicking anywhere on the map
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:store_finder/models/place_model.dart';
import 'package:store_finder/screens/details_main.dart';
import 'package:store_finder/utilities/customize_here.dart';

class PinInfoBanner extends StatelessWidget {
  const PinInfoBanner({
    Key? key,
    required this.animationIn,
    required this.pinTapped,
  }) : super(key: key);

  final Animation<Offset> animationIn;
  final PlaceModel? pinTapped;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    //handle missing place on load
    if (pinTapped == null) {
      return const SizedBox.shrink();
    }

    return SlideTransition(
      position: animationIn,
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white.withAlpha(220),
        width: screenWidth,
        height: 100,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 33,
              backgroundImage: NetworkImage(pinTapped!.thumbnail),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * 0.50,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    pinTapped!.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                SizedBox(
                  width: screenWidth * 0.50,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    pinTapped!.address,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),

            const Spacer(), //keep spacer before icon
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailsMain(
                      placeSelected: pinTapped!,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.more_vert),
              iconSize: 30,
              color: Customize().mainAppColor,
            )
          ],
        ),
      ),
    );
  }
}
