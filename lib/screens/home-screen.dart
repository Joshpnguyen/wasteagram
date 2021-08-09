import 'package:wasteagram/exports.dart';

class MyApp extends StatelessWidget {
  static final routes = {
    NewPost.routeName: (context) => const NewPost(),
    'detail screen': (context) => DetailScreen()
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
              arguments:
                  NewPostArguments(imageURL.toString(), firestore, image));
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

Widget buildListItem(BuildContext context, AsyncSnapshot snapshot) {
  if (snapshot.hasData &&
      snapshot.data!.docs != null &&
      snapshot.data!.docs.length > 0) {
    return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (BuildContext context, int index) {
          var post = snapshot.data!.docs[index];
          return Padding(
            padding: const EdgeInsets.all(3),
            child: ListTile(
              title: Text(
                post['date'],
                style: TextStyle(fontSize: 22),
              ),
              trailing: Text(
                post['numberWasted'].toString(),
                style: TextStyle(fontSize: 23),
              ),
            ),
          );
        });
  } else {
    return Center(child: CircularProgressIndicator());
  }
}
