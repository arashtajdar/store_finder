//**********************************************************************************
//PLACE MODEL
//**********************************************************************************

class PlaceModel {
  int id;
  String name;
  String thumbnail;
  String? about;
  String keywords;
  String? website;
  String? email;
  String? phone;
  String address;
  List<dynamic>? gallery;
  double latitude;
  double longitude;
  List<dynamic>? reviews;

  PlaceModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.about,
    required this.keywords,
    required this.website,
    required this.email,
    required this.phone,
    required this.address,
    required this.gallery,
    required this.latitude,
    required this.longitude,
    required this.reviews,
  });
}
