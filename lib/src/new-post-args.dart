import 'package:wasteagram/exports.dart';

class NewPostArguments {
  final String imageURL;
  final FirebaseFirestore firestore;

  NewPostArguments(this.imageURL, this.firestore);
}
