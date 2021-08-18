import 'dart:io';

import 'package:flutter/foundation.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items]; //returns a copy instead of a reference
  }

  Future<void> addPlace(
      String title, File pickedImage, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlacesAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        longitude: pickedLocation.latitude,
        latitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: pickedImage,
        location: updatedLocation);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetplaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
                longitude: item['loc_lng'],
                latitude: item['loc_lat'],
                address: item['address']),
          ),
        )
        .toList();
    notifyListeners();
  }

  Place getPlaceById(String id)
  {
    return _items.firstWhere((place) => place.id == id);
  }

}
