import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as slpMap;
import 'package:simple_location_picker/utils/slp_constants.dart';
import 'simple_location_result.dart';

class SimpleLocationPicker extends StatefulWidget {

  // the initial location - latitude that the map must be centered on
  final double initialLatitude;

  // the initial location - longitude that the map must be centered on
  final double initialLongitude;

  // the map zoom level
  final double zoomLevel;

  // if true: displays a marker on the map at a location only, no selection
  // if false: allows to tap on the map to select a location
  final bool displayOnly;

  // UI
  final Color appBarColor;
  final Color markerColor;
  final Color appBarTextColor;
  final String appBarTitle;

  SimpleLocationPicker(
      {this.initialLatitude = SLPConstants.DEFAULT_LATITUDE,
      this.initialLongitude = SLPConstants.DEFAULT_LONGITUDE,
      this.zoomLevel = SLPConstants.DEFAULT_ZOOM_LEVEL,
      this.displayOnly = false,
      this.appBarColor = Colors.blueAccent,
      this.appBarTextColor = Colors.white,
      this.appBarTitle = "Select Location",
      this.markerColor = Colors.blueAccent});

  @override
  _SimpleLocationPickerState createState() => _SimpleLocationPickerState();
}

class _SimpleLocationPickerState extends State<SimpleLocationPicker> {
  SimpleLocationResult _selectedLocation;

  void initState() {
    super.initState();
    _selectedLocation = SimpleLocationResult(widget.initialLatitude, widget.initialLongitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.appBarColor,
        title: Text(widget.appBarTitle, style: TextStyle(color: widget.appBarTextColor)),
        actions: <Widget>[
          // DISPLAY_ONLY MODE: no save button for display only mode
          widget.displayOnly
              ? Container()
              : IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    Navigator.of(context).pop(_selectedLocation);
                  },
                  color: widget.appBarTextColor,
                ),
        ],
      ),
      body: _osmWidget(),
    );
  }

  Widget _osmWidget() {
    return slpMap.FlutterMap(
        options: slpMap.MapOptions(
            center: _selectedLocation.getLatLng(),
            zoom: widget.zoomLevel,
            onTap: (tapLoc) {
              // DISPLAY_ONLY MODE: no map taps for display only mode
              if (!widget.displayOnly) {
                setState(() {
                  _selectedLocation = SimpleLocationResult(tapLoc.latitude, tapLoc.longitude);
                });
              }
            }),
        layers: [
          slpMap.TileLayerOptions(urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
          slpMap.MarkerLayerOptions(markers: [
            slpMap.Marker(
                width: 80.0,
                height: 80.0,
                anchorPos: slpMap.AnchorPos.align(slpMap.AnchorAlign.top),
                point: _selectedLocation.getLatLng(),
                builder: (ctx) {
                  return Icon(Icons.room, size: 80, color: widget.markerColor);
                })
          ])
        ]);
  }
}
