//**********************************************************************************
//DETAILS LOCATIONS
//TODO: Add minimap later
//**********************************************************************************
import 'package:flutter/material.dart';
import 'package:store_finder/utilities/customize_here.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import 'section_title.dart';

class DetailsMap extends StatelessWidget {
  final String placeAddress;
  final double placeLat;
  final double placeLon;

  const DetailsMap({
    Key? key,
    required this.placeAddress,
    required this.placeLat,
    required this.placeLon,
  }) : super(key: key);

//open google or apple maps with address
  static Future<void> openMap(
      BuildContext context, double lat, double lng) async {
    String url = '';
    String urlAppleMaps = '';
    if (Platform.isAndroid) {
      //
      url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else {
      urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';
      url = 'comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else if (await canLaunchUrl(Uri.parse(urlAppleMaps))) {
        await launchUrl(Uri.parse(urlAppleMaps));
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          sectionIcon: Icons.location_on_outlined,
          sectionName: Customize.locationSection,
        ),
        const SizedBox(height: 15),
        GestureDetector(
          child: Text(
            placeAddress,
            style: const TextStyle(
                color: Colors.blue,
                fontSize: 18,
                decoration: TextDecoration.underline),
          ),
          onTap: () async {
            openMap(context, placeLat, placeLon);
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
