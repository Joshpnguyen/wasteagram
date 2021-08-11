import 'package:wasteagram/exports.dart';
import 'package:intl/intl.dart';

class MyApp extends StatelessWidget {
  static final routes = {
    NewPost.routeName: (context) => const NewPost(),
    DetailScreen.routeN: (context) => const DetailScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Wasteagram'),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late File image;
  final picker = ImagePicker();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);

    var filename = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(filename);
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    print(url);
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Center(child: Text(widget.title, style: TextStyle(fontSize: 22))),
      ),
      body: scrollingPostsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var imageURL = await uploadImage();
          Navigator.pushNamed(context, NewPost.routeName,
              arguments: NewPostArguments(imageURL.toString(), image));
        },
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget scrollingPostsList() {
    Stream postStream =
        FirebaseFirestore.instance.collection('Wasteagram Posts').snapshots();

    return StreamBuilder(
        stream: postStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return buildListItem(context, snapshot);
        });
  }
}

// Convert Firestore Timestamp to formatted string
String parseTimeStamp(Timestamp date, int format) {
  if (format == 0) {
    return DateFormat('EEEE, MMMM d, y').format(date.toDate());
  } else {
    return DateFormat('EEE, MMMM d, y').format(date.toDate());
  }
}
