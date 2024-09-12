//**********************************************************************************
//MAIN MAP SECTION
//The map centers on the users location and displays all the places listed
//on the backend
//**********************************************************************************

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store_finder/data/strapi_calls.dart';
import 'package:store_finder/models/place_model.dart';
import 'package:store_finder/providers/map_provider.dart';
import 'package:store_finder/widgets/pin_info_banner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:the_widget_marker/the_widget_marker.dart'; // Import the image package

class MapMain extends StatefulWidget {
  const MapMain({Key? key}) : super(key: key);

  @override
  State<MapMain> createState() {
    return MainMapState();
  }
}

class MainMapState extends State<MapMain> with TickerProviderStateMixin {
  final Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = {};
  BitmapDescriptor? pinLocationIcon;
  late LatLng userLocation;

  @override
  void initState() {
    super.initState();
    //setCustomMapPin();

    configureUserLocation();
    animateBanner();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await MarkerIcon.svgAsset(
      context: context,
      assetName: 'assets/custom-marker.svg',
      size: 80,
    );
  }

  // void setCustomMapPin() async {
  //   pinLocationIcon = await BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(devicePixelRatio: 2.65),
  //     'assets/custom-marker.png',
  //   );
  // }

  void configureUserLocation() async {
    //request user permissions
    await Geolocator.requestPermission().then((_) {
      //get user location
      Geolocator.getCurrentPosition().then((userPos) async {
        //configure and animate camera to location
        var userLoc = LatLng(userPos.latitude, userPos.longitude);
        var newCameraPosition = CameraPosition(target: userLoc, zoom: 15.0);

        GoogleMapController controller = await _controller.future;
        var newPos = CameraUpdate.newCameraPosition(newCameraPosition);
        controller.animateCamera(newPos);

        //update map provider with user location
        var locationProvider = MapProvider();
        locationProvider.updatedUserLocation(userLoc);
        userLocation = locationProvider.getUserLocation;
      });
    }).onError((error, stackTrace) {
      Geolocator.requestPermission();
      throw ('Error requesting user permissions');
    });
  }

  void animateBanner() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 160),
      reverseDuration: const Duration(milliseconds: 50),
      vsync: this,
    );

    animationIn = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.ease,
      ),
    );
  }

  //initial camera position
  static const startingLoc = LatLng(0, 0);
  static const camPos = CameraPosition(target: startingLoc, zoom: 14);
  late AnimationController animationController;
  late Animation<Offset> animationIn;
  //late Animation<Offset> animationOut;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapProvider(),
      child: Scaffold(
        body: Stack(
          children: [
            Consumer<MapProvider>(
              builder: (context, mapState, child) {
                return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: camPos,
                  markers: markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                    controller.setMapStyle(
                      '[{"featureType": "poi","stylers": [{"visibility": "off"}]}]',
                    );

                    EasyLoading.show(status: 'Loading Places');
                    StrapiCalls()
                        .fetchPlaces(
                      filterByCategories: null,
                      filterByBookmarks: null,
                    )
                        .then((placeList) async {
                      EasyLoading.dismiss();
                      if (placeList == null) {
                        return;
                      }

                      //set custom marker
                      pinLocationIcon = await MarkerIcon.svgAsset(
                        context: context,
                        assetName: 'assets/custom-marker.svg',
                        size: 80,
                      );

                      //update provider
                      mapState.updatePlaces(placeList);

                      //check for changes
                      List<PlaceModel>? list = mapState.getPlaces;
                      if (list != null) {
                        for (var place in list) {
                          var lat = place.latitude;
                          var lon = place.longitude;

                          markers.add(
                            Marker(
                              markerId: MarkerId(place.id.toString()),
                              position: LatLng(lat, lon),
                              icon: pinLocationIcon!,
                              onTap: () {
                                //animate and show place info
                                animationController.forward();
                                mapState.updatePinTapped(place);
                              },
                            ),
                          );
                        }
                      }
                    }).onError((error, stackTrace) {
                      EasyLoading.dismiss();
                      EasyLoading.showError('$error');
                    });
                  },
                  onTap: (coords) {
                    animationController.reverse();
                  },
                );
              },
            ),
            Consumer<MapProvider>(
              builder: (context, mapState, child) {
                return PinInfoBanner(
                  animationIn: animationIn,
                  pinTapped: mapState.getPinTapped,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
