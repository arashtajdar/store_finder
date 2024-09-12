//**********************************************************************************
//DETAILS MAIN SCREEN
//Keep all detail view modules as sub-sections of this file
//**********************************************************************************

//CallToAction: includes transparent navigation bar, return, rate and bookmark
//actions, place name, place rating, place thumbnail, call and email action.

//About Section: Description of the place.

//Gallery: Pictures of the place.

//Location: Clickable address. When clicked it will open apple / google maps.

//Website: Clickable website link. When clicked, it will open the website in
//a web view.

//**********************************************************************************
import 'package:flutter/material.dart';
import 'package:store_finder/widgets/details_about.dart';
import 'package:store_finder/widgets/details_call_to_action.dart';
import 'package:store_finder/widgets/details_gallery.dart';
import 'package:store_finder/widgets/details_location.dart';
import 'package:store_finder/widgets/details_website_link.dart';
import '../models/place_model.dart';

class DetailsMain extends StatelessWidget {
  final PlaceModel placeSelected;
  const DetailsMain({
    Key? key,
    required this.placeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const divider = Divider(height: 50, thickness: 0.5);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          CallToAction(
            id: placeSelected.id,
            name: placeSelected.name,
            image: placeSelected.thumbnail,
            reviews: placeSelected.reviews ?? [],
            email: placeSelected.email ?? "",
            phone: placeSelected.phone ?? "",
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      DetailsAbout(about: placeSelected.about ?? ""),
                      divider,
                      DetailsGallery(gallery: placeSelected.gallery),
                      divider,
                      DetailsMap(
                        placeAddress: placeSelected.address,
                        placeLat: placeSelected.latitude,
                        placeLon: placeSelected.longitude,
                      ),
                      divider,
                      DetailsWebsiteLink(
                          websiteLink: placeSelected.website ?? ""),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
