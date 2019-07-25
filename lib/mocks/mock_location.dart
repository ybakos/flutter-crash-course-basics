import '../models/location.dart';
import '../models/location_fact.dart';

class MockLocation extends Location {

  static Location fetchAny() {
    return Location(
      name: 'Magic Falls, Springfield, Oregon',
      url: 'https://bit.ly/2Yl7boC',
      facts: <LocationFact>[
        LocationFact(
          title: 'Summary',
          text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam'
        ),
        LocationFact(
          title: 'How to Get There',
          text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam'
        )
      ]
    );
  }

}
