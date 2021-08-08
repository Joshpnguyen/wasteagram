import 'package:wasteagram/exports.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
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
    if (posts.isEmpty) {
      return loading();
    } else {
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
  }

  Widget loading() {
    return Scaffold(
      appBar: AppBar(
        title:
            Center(child: Text(widget.title, style: TextStyle(fontSize: 22))),
      ),
      body: Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget scrollingPostsList() {
  return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(3),
          child: ListTile(
            title: Text(
              posts[index].date,
              style: TextStyle(fontSize: 22),
            ),
            trailing: Text(
              posts[index].number,
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      });
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
