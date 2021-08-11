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
