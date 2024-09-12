//**********************************************************************************
//CATEGORY MODEL
//Name and image are required on the backend
//Id is automatically created
//**********************************************************************************

class CategoryModel {
  final int id;
  final String name;
  final String image;
  final List<dynamic>? placeList;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.placeList,
  });
}
