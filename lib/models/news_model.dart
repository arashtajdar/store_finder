//**********************************************************************************
//NEWS MODELS
//**********************************************************************************

class NewsModel {
  int id;
  String image;
  String title;
  String? content;
  String date;
  NewsModel({
    required this.id,
    required this.image,
    required this.title,
    required this.content,
    required this.date,
  });
}
