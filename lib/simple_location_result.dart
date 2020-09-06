import 'package:latlong/latlong.dart' as coordinates;

class SimpleLocationResult {

  final double latitude;
  final double longitude;

  SimpleLocationResult(this.latitude, this.longitude);

  getLatLng() => coordinates.LatLng(latitude, longitude);

}