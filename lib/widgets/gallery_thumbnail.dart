//**********************************************************************************
//DETAILS GALLERY THUMNBAIL
//**********************************************************************************
import 'package:flutter/material.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

class GalleryThumbnail extends StatelessWidget {
  final int imgIndex;
  final String imgMini;
  final List<dynamic> fullArr;
  const GalleryThumbnail({
    Key? key,
    required this.imgIndex,
    required this.imgMini,
    required this.fullArr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          List<String> images = [];
          fullArr.asMap().forEach((index, item) {
            var imageUrl = item as Map<String, dynamic>;
            String finalUrl = imageUrl['attributes']['url'];
            images.add(finalUrl);
          });

          SwipeImageGallery(
            context: context,
            initialIndex: imgIndex,
            itemBuilder: (context, index) {
              return Image.network(images[index]);
            },
            itemCount: images.length,
          ).show();
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints.expand(
            width: 60,
            height: 60,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              //image: AssetImage(imgMini),
              image: NetworkImage(imgMini),
              fit: BoxFit.cover,
            ),
            // 7
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: const Align(alignment: Alignment.center),
        ),
      ),
    );
  }
}
