import 'package:wasteagram/exports.dart';
import 'package:intl/intl.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  static const routeName = '/extractArgs';

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  late LocationData locationData;

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NewPostArguments;
    late int numberWasted;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('New Post', style: TextStyle(fontSize: 22))),
      ),
      body: Column(
        children: [
          Flexible(flex: 15, child: (Container(child: Image.file(args.image)))),
          Flexible(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Number of Wasted Items',
                      border: OutlineInputBorder()),
                  onSaved: (value) {
                    value = value ?? '';
                    numberWasted = int.parse(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    } else {
                      return null;
                    }
                  }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
            child: Container(
          height: 70,
          child: ElevatedButton(
            child: Icon(Icons.upload),
            onPressed: () {
              uploadPost(args.imageURL, numberWasted, locationData.longitude,
                  locationData.latitude);
              Navigator.pop(context);
            },
          ),
        )),
      ),
    );
  }
}

void uploadPost(
    String imageURL, int numberWasted, double? longitude, double? latitude) {
  FirebaseFirestore.instance.collection('Wasteagram Post').add({
    'imageURL': imageURL,
    'date': DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
    'numberWasted': numberWasted,
    'longitude': longitude,
    'latitude': latitude
  });
}
