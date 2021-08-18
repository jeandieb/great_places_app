import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/map_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const String routeName = '/place_detail_screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).getPlaceById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Text(selectedPlace.location.address),
          ),
          SizedBox(
            height: 15,
          ),
          TextButton(
              child: Text('View in Map'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MapScreen(
                    intitialLocation: selectedPlace.location,
                    isSelecting: false,
                  ),
                ));
              }),
        ],
      ),
    );
  }
}
