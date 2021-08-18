import 'package:flutter/material.dart';
import '../models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation intitialLocation;
  final bool isSelecting;

  MapScreen(
      {this.intitialLocation =
          const PlaceLocation(latitude: 37.422, longitude: -122.084),
      this.isSelecting = false});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
            )
        ],
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              zoom: 16,
              target: LatLng(widget.intitialLocation.latitude,
                  widget.intitialLocation.longitude)),
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: _pickedLocation == null && widget.isSelecting
              ? {}
              : {
                  Marker(
                      markerId: MarkerId('m1'),
                      //check again if the _pickedLocation is null use the inital Location coordinates.. 
                      position: _pickedLocation ??
                          LatLng(
                            widget.intitialLocation.latitude,
                            widget.intitialLocation.longitude,
                          ))
                }),
    );
  }
}
