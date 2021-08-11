import 'package:wasteagram/exports.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);
  static const routeN = '/extractDetails';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Post;
    return Scaffold(
        appBar: AppBar(
          title:
              Center(child: Text('Wasteagram', style: TextStyle(fontSize: 22))),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  flex: 10,
                  child: Text(args.date, style: TextStyle(fontSize: 32))),
              Flexible(
                  flex: 10,
                  child: Container(child: Image.network(args.imageURL))),
              itemsPrint(args.numberWasted),
              printLocation(args.longitude, args.latitude),
            ]));
  }
}

Widget itemsPrint(int numberOfItems) {
  String itemText;
  if (numberOfItems > 1) {
    itemText = '$numberOfItems items';
  } else {
    itemText = '$numberOfItems item';
  }

  return Flexible(
    flex: 5,
    child: Padding(
      padding: const EdgeInsets.all(28.0),
      child: Text(
        itemText,
        style: TextStyle(fontSize: 36),
      ),
    ),
  );
}

Widget printLocation(double longitude, double latitude) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Text('Location: (${latitude.toString()}, ${longitude.toString()})',
        style: TextStyle(fontSize: 20)),
  );
}
