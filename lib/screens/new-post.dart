import 'package:wasteagram/exports.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  static const routeName = '/extractArgs';

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  late LocationData locationData;
  late FieldValue date;
  final numberWastedController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    retrieveLocation();
    super.initState();
  }

  Future retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    date = FieldValue.serverTimestamp();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NewPostArguments;

    return FutureBuilder(
        future: retrieveLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingCircle();
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Center(
                      child: Text('New Post', style: TextStyle(fontSize: 22))),
                ),
                body: Column(
                  children: [
                    Flexible(
                        flex: 15,
                        child: (Container(child: Image.file(args.image)))),
                    Flexible(
                      flex: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: numberWastedField(),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Semantics(
                    button: true,
                    enabled: true,
                    onTapHint: 'Uploads new post to Wasteagram',
                    child: uploadButton(args)));
          }
        });
  }

  // sends data to Firestore database
  void uploadPost(String imageURL, int numberWasted, double? longitude,
      double? latitude, FieldValue date) {
    FirebaseFirestore.instance.collection('Wasteagram Posts').add({
      'imageURL': imageURL,
      'date': date,
      'numberWasted': numberWasted,
      'longitude': longitude,
      'latitude': latitude
    });
  }

  Widget uploadButton(NewPostArguments args) {
    return SafeArea(
      child: BottomAppBar(
          child: Container(
        height: 90,
        child: ElevatedButton(
          child: Icon(Icons.upload),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              uploadPost(args.imageURL, int.parse(numberWastedController.text),
                  locationData.longitude, locationData.latitude, date);
              sleep(Duration(milliseconds: 200));
              Navigator.pop(context);
            }
          },
        ),
      )),
    );
  }

  // Widget for the number of items wasted texted field
  Widget numberWastedField() {
    return Form(
      key: formKey,
      child: TextFormField(
          controller: numberWastedController,
          decoration: InputDecoration(
              labelText: 'Number of Wasted Items',
              border: OutlineInputBorder()),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          onSaved: (value) {},
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a number';
            } else {
              return null;
            }
          }),
    );
  }
}

Widget loadingCircle() {
  return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('New Post', style: TextStyle(fontSize: 22))),
      ),
      body: Center(child: CircularProgressIndicator()));
}
