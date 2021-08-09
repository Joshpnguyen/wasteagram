import 'package:wasteagram/exports.dart';

class NewPostArguments {
  final String imageURL;
  final FirebaseFirestore firestore;
  final File image;

  NewPostArguments(this.imageURL, this.firestore, this.image);
}
