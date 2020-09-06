# simple_location_picker

A Simple Location Picker using Openstreetmaps. This is a very basic and simple package for picking a location from a map. 
There is no places search or shortcut for the home location. The location pickers centers on the initial coordinates passed to it.  
The picker also operates in a 'Display Only' mode to display a location on the map.
 
## Usage

Navigate to the Simple Location Picker to display the picker.

```dart
Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SimpleLocationPicker(
                        initialLatitude: latitude,
                        initialLongitude: longitude,
                      ))).then((value) {
            if (value != null) {
              setState(() {
                _selectedLocation = value;
              });
            }
          });
```
          
The response is a 'SimpleLocationResult' object that contains the latitude and longitude
of the selected location, or null if the picker was cancelled.

## Parameters

| Parameter        | Type   | Description                                                                              |
|------------------|--------|------------------------------------------------------------------------------------------|
| initialLatitude  | double | The latitude of the initial position on which the maps focuses  and places a marker on.  |
| initialLongitude | double | The longitude of the initial position on which the maps focuses  and places a marker on. |
| zoomLevel        | int    | The initial zoom level of the map.                                                       |
| displayOnly      | bool   | If true, sets the picker to display only mode. Default is false.                         |
| appBarColor      | Color  | The background color of the appbar.                                                      |
| markerColor      | Color  | The background color of the map marker icon.                                             |
| appBarTextColor  | Color  | The text color of the appbar title.                                                      |
| appBarTitle      | String | The appbar title.                                                                        |

## Gallery

<img src="https://github.com/hashirabdulbasheer/my_assets/raw/master/simple_location_picker.gif" width="200"/>               
                  
