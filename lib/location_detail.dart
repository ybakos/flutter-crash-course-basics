import 'package:flutter/material.dart';
import 'models/location.dart';
import 'styles.dart';

class LocationDetail extends StatefulWidget {

  final int locationId;

  LocationDetail(this.locationId);

  @override
  createState() => _LocationDetailState(this.locationId);

}

class _LocationDetailState extends State<LocationDetail>{

  final int locationId;
  Location location = Location.blank();

  _LocationDetailState(this.locationId);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final location = await Location.fetchById(this.locationId);
    if (mounted) {
      setState(() {
        this.location = location;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.location.name, style: Styles.navBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _renderBody(context, this.location)
        )
      )
    );
  }

  List<Widget> _renderBody(BuildContext context, Location location) {
    var result = List<Widget>();
    result.add(_bannerImage(location.url, 200));
    result.addAll(_renderFacts(context, location));
    return result;
  }

  List<Widget> _renderFacts(BuildContext context, Location location) {
    var result = List<Widget>();
    for (int i = 0; i < location.facts.length; ++i) {
      result.add(_sectionTitle(location.facts[i].title));
      result.add(_sectionText(location.facts[i].text));
    }
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 10),
      child: Text(text, textAlign: TextAlign.left, style: Styles.headerLarge)
    );
  }

  Widget _sectionText(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
      child: Text(text, style: Styles.textDefault)
    );
  }

  Widget _bannerImage(String url, double height) {
    Image image;
    try {
      if (url.isNotEmpty) {
        image = Image.network(url, fit: BoxFit.fitWidth);
      }
    } catch (e) {
      print('could not load image $url');
    }
    return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: image
    );
  }

}
