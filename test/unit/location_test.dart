import 'dart:convert';
import '../../lib/models/location.dart';
import 'package:test/test.dart';

void main() {

  test('location deserialization', () {
    const locationJSON =
      '''
      {
        "name": "Arashiyama Bamboo Grove",
        "url": "https://cdn-images-1.medium.com/max/2000/1*vdJuSUKWl_SA9Lp-32ebnA.jpeg",
        "facts": [
          {
            "title": "Summary",
            "text": "This bamboo grove is on the outskirts of Kyoto."
          }
        ]
      }
      ''';
    final locationMap = json.decode(locationJSON) as Map<String, dynamic>;
    expect('Arashiyama Bamboo Grove', equals(locationMap['name']));

    final location = Location.fromJson(locationMap);
    expect(location.name, equals(locationMap['name']));
    expect(location.url, equals(locationMap['url']));
    expect(location.facts[0].title, equals(locationMap['facts'][0]['title']));
    expect(location.facts[0].text, equals(locationMap['facts'][0]['text']));
  });

  // test('/locations and /locations/:id', () async {
  //   final locations = await Location.fetchAll();
  //   for (var location in locations) {
  //     expect(location.name, hasLength(greaterThan(0)));
  //     expect(location.url, hasLength(greaterThan(0)));
  //     final fetchedLocation = await Location.fetchById(location.id);
  //     expect(fetchedLocation.name, equals(location.name));
  //     expect(fetchedLocation.url, equals(location.url));
  //   }
  // });

}
