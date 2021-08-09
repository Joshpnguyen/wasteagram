import 'package:wasteagram/exports.dart';
import 'package:intl/intl.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  static const routeName = '/extractArgs';

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NewPostArguments;

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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )),
      ),
    );
  }
}
