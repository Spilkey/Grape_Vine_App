import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geocoding/geocoding.dart';

import '../models/place.dart';

class MapPage extends StatefulWidget {

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  // geolocator for finding user location
  var _geolocator = Geolocator();
  LatLng _userLocation;
  String _street;
  // for setting new location
  Place newLocation;
  
  // map controller
  MapController _mapController;

  // default map options
  double _zoom = 15.0;
  var _center;

  // default marker
  var _currentMarker = Marker(
    point: LatLng(0.0, 0.0)
  );
  
  @override
  void initState(){
    _mapController = MapController();
    super.initState();
  }

  @override
  Widget build (BuildContext context) {

    // set geolocator
    if (_userLocation == null){
      Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).then(
        (pos){
          _updateLocationStream(pos);
        }
      );
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a location'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: () {
              zoomIn();
            }
          ),
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: () {
              zoomOut();
            }
          )
        ]
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _center,
          zoom: _zoom,
          maxZoom: 18.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [_currentMarker],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: new FloatingActionButton(
              heroTag: 'btn1',
              child: Icon(Icons.add_location),
              onPressed: () {
                setState(() {
                  var newCenter = _mapController.center;
                    _userLocation = LatLng(newCenter.latitude, newCenter.longitude);
                    Place newLocation = Place(latlng: _userLocation);
                    _buildMarker(newLocation);
                    setState((){});
                    });
                  }
                )
              ),
    
          Container(
            margin: const EdgeInsets.all(10.0),
            child: new FloatingActionButton(
              heroTag: 'btn2',
              child: Icon(Icons.check),
              onPressed: () {
                setState(() {
                  Navigator.pop(context, {_street});
                });
              }
            )
          ),
        ] 
      ),
    );
  }

  void _buildMarker(Place newLocation){
    _currentMarker = Marker(
      width: 60.0,
      height: 60.0,
      point: newLocation.latlng,
      builder: (ctx) => Container(
        child: Icon(
          Icons.location_on,
          color: Colors.purple
        )
      )
    );
  }

  void _updateLocationStream(Position userLocation) {
    if (mounted){
      setState(() {
            placemarkFromCoordinates(
            userLocation.latitude, userLocation.longitude)
          .then((List<Placemark> places) {
            _street = places[0].street;
            _userLocation = LatLng(userLocation.latitude, userLocation.longitude);  
            _center = _userLocation;
        });
      });
    }
  }

  void zoomIn() {
    _zoom += 0.5;
    _mapController.move(_mapController.center, _zoom);
  }

  void zoomOut() {
    _zoom -= 0.5;
    _mapController.move(_mapController.center, _zoom);
  }
}