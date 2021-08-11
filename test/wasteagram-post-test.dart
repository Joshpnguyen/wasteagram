import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/exports.dart';

void main() {
  test('Test creating a Post using preset values', () {
    final date = 'January 1,2021 at 8:00:00 PM UTC-7';
    const imageURL = 'Fake';
    const numberWasted = 5;
    const longitude = 1.0;
    const latitude = 2.0;

    final post = Post(numberWasted, date, longitude, latitude, imageURL);

    expect(post.date, date);
    expect(post.numberWasted, numberWasted);
    expect(post.imageURL, imageURL);
    expect(post.longitude, longitude);
    expect(post.latitude, latitude);
  });

  test('Test passing arguments to the New Screen', () {
    final imageURL = 'test.com';
    final image = File('');

    final newScreenArgs = NewPostArguments(imageURL, image);

    expect(newScreenArgs.imageURL, imageURL);
    expect(newScreenArgs.image, image);
  });
}
