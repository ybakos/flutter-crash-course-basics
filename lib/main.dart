import 'package:flutter/material.dart';
import 'location_list.dart';
import 'models/location.dart';
import 'mocks/mock_location.dart';

void main() {

  final List<Location> mockLocations = MockLocation.fetchAll();

  return runApp(
    MaterialApp(
      home: LocationList(mockLocations)
    )
  );
}
