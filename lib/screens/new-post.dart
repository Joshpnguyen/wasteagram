import 'package:wasteagram/exports.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('New Post', style: TextStyle(fontSize: 22))),
      ),
      body: Column(
        children: [
          Flexible(flex: 10, child: (Container())),
          Flexible(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Number of Wasted Items',
                      border: OutlineInputBorder())),
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
            onPressed: () {},
          ),
        )),
      ),
    );
  }
}
