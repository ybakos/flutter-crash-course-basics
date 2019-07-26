import 'package:flutter/material.dart';
import 'location_detail.dart';
import 'models/location.dart';
import 'styles.dart';

class LocationList extends StatelessWidget {

  final List<Location> locations;

  LocationList(this.locations);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations', style: Styles.navBarTitle),
      ),
      body: ListView.builder(
        itemCount: this.locations.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: _itemThumbnail(this.locations[index]),
            title: _itemTitle(this.locations[index]),
            onTap: () => _navigateToLocationDetail(context, this.locations[index])
          );
        }
      )
    );
  }

  void _navigateToLocationDetail(BuildContext context, Location location) {
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => LocationDetail(location)
      )
    );
  }

  Widget _itemThumbnail(Location location) {
    return Container(
      constraints: BoxConstraints.tightFor(width: 100),
      child: Image.network(location.url, fit: BoxFit.fitWidth)
    );
  }

  Widget _itemTitle(Location location) {
    return Text('${location.name}', style: Styles.textDefault);
  }
}
