//**********************************************************************************
//DETAILS MINI GALLERY
//The scrollable gallery that opens when a thumnbnail is clicked is
//from 'SwipeImageGallery'
//**********************************************************************************

import 'package:flutter/material.dart';
import 'package:store_finder/utilities/customize_here.dart';
import 'gallery_thumbnail.dart';
import 'section_title.dart';

class DetailsGallery extends StatelessWidget {
  final List<dynamic>? gallery;

  const DetailsGallery({
    Key? key,
    required this.gallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Retrieve image urls
    List<Widget> widgetArr = [];
    if (gallery != null) {
      gallery?.asMap().forEach((index, item) {
        var imageUrl = item as Map<String, dynamic>;
        String finalUrl = imageUrl['attributes']['url'];
        widgetArr.add(
          GalleryThumbnail(
            imgMini: finalUrl,
            imgIndex: index,
            fullArr: gallery!,
          ),
        );
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(
          sectionIcon: Icons.image_outlined,
          sectionName: Customize.gallerySection,
        ),
        SizedBox(
          height: 100,
          child: ListView(
            itemExtent: 75,
            scrollDirection: Axis.horizontal,
            children: widgetArr,
          ),
        ),
      ],
    );
  }
}
