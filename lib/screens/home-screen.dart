import 'package:wasteagram/exports.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Wasteagram'),
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
  File? image;
  final picker = ImagePicker();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    if (image == null) {
      print('No image picked');
    }
    setState(() {});
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
        onPressed: getImage,
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
                style: TextStyle(fontSize: 24),
              ),
            ),
          );
        });
  } else {
    return Center(child: CircularProgressIndicator());
  }
}

List<Post> posts = [
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 7,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 7,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 7,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 7,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 7,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  ),
  Post(
    date: "Sunday, August 8, 2021",
    numberWasted: 5,
  )
];
