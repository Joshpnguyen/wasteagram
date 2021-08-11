import 'package:wasteagram/exports.dart';

// Build the list tile of each post on home screen
Widget buildListItem(BuildContext context, AsyncSnapshot snapshot) {
  if (snapshot.hasData &&
      snapshot.data!.docs != null &&
      snapshot.data!.docs.length > 0) {
    return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (BuildContext context, int index) {
          var post = snapshot.data!.docs[index];
          return Padding(
            padding: const EdgeInsets.all(4),
            child: ListTile(
              title: Text(
                parseTimeStamp(post['date'], 0),
                style: TextStyle(fontSize: 22),
              ),
              trailing: Text(
                post['numberWasted'].toString(),
                style: TextStyle(fontSize: 23),
              ),
              onTap: () {
                Navigator.pushNamed(context, DetailScreen.routeN,
                    arguments: Post(
                        post['numberWasted'],
                        parseTimeStamp(post['date'], 1),
                        post['longitude'],
                        post['latitude'],
                        post['imageURL']));
              },
            ),
          );
        });
  } else {
    return Center(child: CircularProgressIndicator());
  }
}
