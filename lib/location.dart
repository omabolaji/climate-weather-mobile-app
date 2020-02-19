import 'package:geolocator/geolocator.dart';

class LocationStatus {
  double latitude;
  double longitude;

//  LocationStatus({this.latitude, this.longitude});

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
