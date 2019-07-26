import 'package:flutter/material.dart';
import 'location_list.dart';
import 'models/location.dart';
import 'mocks/mock_location.dart';

void main() {

  final Location mockLocation = MockLocation.fetchAny();

  return runApp(
    MaterialApp(
      home: LocationList([])
    )
  );
}
