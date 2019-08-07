import 'package:flutter/material.dart';
import 'location_detail.dart';
import 'models/location.dart';
import 'styles.dart';

class LocationList extends StatefulWidget {

  @override
  createState() => _LocationListState();

}

class _LocationListState extends State<LocationList> {
  List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations', style: Styles.navBarTitle),
      ),
      body:
        Column(
          children: [
            LinearProgressIndicator(
              value: null,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)
            ),
            Expanded(child: ListView.builder(
              itemCount: this.locations.length,
              itemBuilder: _listViewItemBuilder
            )
          )
        ]
      )
    );
  }

  loadData() async {
    final locations = await Location.fetchAll();
    setState( () {
      this.locations = locations;
    });
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final location = this.locations[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: _itemThumbnail(location),
      title: _itemTitle(location),
      onTap: () => _navigateToLocationDetail(context, location.id)
    );
  }

  void _navigateToLocationDetail(BuildContext context, int locationId) {
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => LocationDetail(locationId)
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
