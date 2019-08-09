import 'package:flutter/material.dart';
import 'location_detail.dart';
import 'models/location.dart';
import 'styles.dart';

const listItemHeight = 245.0;

class LocationList extends StatefulWidget {

  @override
  createState() => _LocationListState();

}

class _LocationListState extends State<LocationList> {
  List<Location> locations = [];
  bool loading = false;

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
      body: RefreshIndicator(
        onRefresh: loadData,
        child: Column(
          children: [
            renderProgressBar(context),
            Expanded(child: renderListView(context))
          ]
        )
      )
    );
  }

  Future<void> loadData() async {
    if (this.mounted) {
      setState(() => this.loading = true);
      final locations = await Location.fetchAll();
      setState( () {
        this.locations = locations;
        this.loading = false;
      });
    }
  }

  Widget renderProgressBar(BuildContext context) {
    return this.loading ? LinearProgressIndicator(
      value: null,
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)
    ) : Container();
  }

  Widget renderListView(BuildContext context) {
    return ListView.builder(
      itemCount: this.locations.length,
      itemBuilder: _listViewItemBuilder
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final location = this.locations[index];
    return Container(
      height: listItemHeight,
      child: _tileImage(location.url, MediaQuery.of(context).size.width, listItemHeight)
    );
  }

  void _navigateToLocationDetail(BuildContext context, int locationId) {
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => LocationDetail(locationId)
      )
    );
  }

  Widget _tileImage(String url, double width, double height) {
    Image image;
    try {
      image = Image.network(url, fit: BoxFit.cover);
    } catch (e) {
      print('Could not load image $url');
    }
    return Container(
      constraints: BoxConstraints.expand(),
      child: image
    );
  }

  Widget _itemTitle(Location location) {
    return Text('${location.name}', style: Styles.textDefault);
  }
}
