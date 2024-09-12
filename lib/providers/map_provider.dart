//**********************************************************************************
//MAP PROVIDER
//Keeps track of CMS locations, marker state and user location
//**********************************************************************************
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store_finder/models/place_model.dart';

class MapProvider with ChangeNotifier {
//MAP LOCATIONS
  final List<PlaceModel> _placeList = [];
  List<PlaceModel>? get getPlaces => _placeList;
  void updatePlaces(List<PlaceModel> places) {
    _placeList.clear();
    _placeList.addAll(places);
    notifyListeners();
  }

//MAP PIN
  PlaceModel? _pinTapped;
  PlaceModel? get getPinTapped => _pinTapped;
  void updatePinTapped(PlaceModel placePin) {
    _pinTapped = placePin;
    notifyListeners();
  }

//USER LOCATION
  LatLng _currentUserLocation = const LatLng(0, 0);
  LatLng get getUserLocation => _currentUserLocation;
  void updatedUserLocation(LatLng newUserLoc) {
    _currentUserLocation = newUserLoc;
    notifyListeners();
  }

  //clear places on dispose - called when exiting view
  @override
  void dispose() {
    _placeList.clear();
    notifyListeners();
    super.dispose();
  }
}
