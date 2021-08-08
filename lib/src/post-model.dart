import 'package:wasteagram/exports.dart';

class Post {
  int numberWasted;
  String date;
  String longitude;
  String latitude;
  String imageURL;
  File? image;

  Post(
      {this.numberWasted = 0,
      this.date = "",
      this.longitude = "",
      this.latitude = "",
      this.imageURL = ""});

  String get number => numberWasted.toString();
}
