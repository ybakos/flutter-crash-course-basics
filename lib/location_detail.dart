import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'components/location_tile.dart';
import 'models/location.dart';
import 'styles.dart';

const bannerImageHeight = 300.0;
const bodyVerticalPadding = 20.0;
const footerHeight = 100.0;

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
      body: Stack(children: [
        _renderBody(context, this.location),
        _renderFooter(context, location)
      ])
    );
  }

  Widget _renderBody(BuildContext context, Location location) {
    var result = List<Widget>();
    result.add(_bannerImage(location.url, bannerImageHeight));
    result.add(_renderHeader());
    result.addAll(_renderFacts(context, location));
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: result
      )
    );
  }

  Widget _renderHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: bodyVerticalPadding, horizontal: Styles.horizontalPaddingDefault),
      child: LocationTile(location: this.location, darkTheme: false)
    );
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
      padding: EdgeInsets.fromLTRB(Styles.horizontalPaddingDefault, 25, Styles.horizontalPaddingDefault, 0),
      child: Text(text.toUpperCase(), textAlign: TextAlign.left, style: Styles.headerLarge)
    );
  }

  Widget _sectionText(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: Styles.horizontalPaddingDefault),
      child: Text(text, style: Styles.textDefault)
    );
  }

  Widget _renderFooter(BuildContext context, Location location) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
          height: footerHeight,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: _renderBookButton()
          )
        )
      ],
    );
  }

  Widget _renderBookButton() {
    return FlatButton(
      color: Styles.accentColor,
      textColor: Styles.textColorBright,
      onPressed: _handleBookPress,
      child: Text('Book'.toUpperCase(), style: Styles.textCTAButton)
    );
  }

  void _handleBookPress() async {
    const url = 'mailto:hello@tourism.co?subject=inquiry';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
