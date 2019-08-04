import 'package:flutter/material.dart';
import 'location_list.dart';
import 'models/location.dart';
import 'mocks/mock_location.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final List<Location> mockLocations = MockLocation.fetchAll();
    return new MaterialApp(
      home: LocationList(mockLocations)
    );
  }
  
}
