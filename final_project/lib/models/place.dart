import 'package:latlong/latlong.dart';

class Place {
  LatLng latlng;

  Place({
    this.latlng
  });
 
  Map<String, dynamic> toMap() {
    return{
      'latlng': latlng
    };
  }
}