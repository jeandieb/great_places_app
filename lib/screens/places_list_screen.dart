import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../screens/add_place_screen.dart';
import '../screens/place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetplaces(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<GreatPlaces>(
                  child: Center(
                    child: const Text('Got no places yet, start adding some!'),
                  ),
                  builder: (ctx, greatPlaces, ch) {
                    return greatPlaces.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[i].image),
                              ),
                              title: Text(greatPlaces.items[i].title),
                              subtitle: Text(greatPlaces.items[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: greatPlaces.items[i].id);
                                //Go to detail page ...
                              },
                            ),
                          );
                  },
                ),
        ));
  }
}
