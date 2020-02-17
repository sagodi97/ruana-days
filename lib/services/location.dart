import 'package:geolocator/geolocator.dart';

class Location {
  double lat;
  double long;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
      this.lat = position.latitude;
      this.long = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
