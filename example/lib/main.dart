import 'package:flutter/material.dart';
import 'package:simple_location_picker/simple_location_picker_screen.dart';
import 'package:simple_location_picker/simple_location_result.dart';
import 'package:simple_location_picker/utils/slp_constants.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Location Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Simple Location Picker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SimpleLocationResult _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),

              // The button that opens the SimpleLocationPicker in display ONLY mode.
              // This opens the SimpleLocationPicker to display a specific location on the map with a marker.
              RaisedButton(
                child: Text("Display a location"),
                onPressed: () {
                  double latitude = _selectedLocation != null ? _selectedLocation.latitude : SLPConstants.DEFAULT_LATITUDE;
                  double longitude = _selectedLocation != null ? _selectedLocation.longitude : SLPConstants.DEFAULT_LONGITUDE;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SimpleLocationPicker(
                            initialLatitude: latitude,
                            initialLongitude: longitude,
                            appBarTitle: "Display Location",
                            displayOnly: true,
                          )));
                },
              ),
              SizedBox(height: 50),

              // The button that opens the SimpleLocationPicker in picker mode.
              // This opens the SimpleLocationPicker to allow the user to pick a location from the map.
              // The SimpleLocationPicker returns SimpleLocationResult containing the lat, lng of the picked location.
              RaisedButton(
                child: Text("Pick a Location"),
                onPressed: () {
                  double latitude = _selectedLocation != null ? _selectedLocation.latitude : SLPConstants.DEFAULT_LATITUDE;
                  double longitude = _selectedLocation != null ? _selectedLocation.longitude : SLPConstants.DEFAULT_LONGITUDE;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SimpleLocationPicker(
                                initialLatitude: latitude,
                                initialLongitude: longitude,
                                appBarTitle: "Select Location",
                              ))).then((value) {
                    if (value != null) {
                      setState(() {
                        _selectedLocation = value;
                      });
                    }
                  });
                },
              ),

              SizedBox(height: 50),
              // Displays the picked location on the screen as text.
              _selectedLocation != null ? Text('SELECTED: (${_selectedLocation.latitude}, ${_selectedLocation.longitude})') : Container(),
            ],
          ),
        ));
  }
}
