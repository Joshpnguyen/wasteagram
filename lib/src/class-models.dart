import 'package:wasteagram/exports.dart';

// Used to send image/image URL to the new post screen
class NewPostArguments {
  final String imageURL;
  final File image;

  NewPostArguments(this.imageURL, this.image);
}

// Used to send arguments to Detail Screen
class Post {
  int numberWasted;
  String date;
  double longitude;
  double latitude;
  String imageURL;

  Post(this.numberWasted, this.date, this.longitude, this.latitude,
      this.imageURL);

  String get number => numberWasted.toString();
}
