
import 'package:flutter/foundation.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List <Place> _items = [];

  List<Place> get items{
    return [..._items]; //returns a copy instead of a reference
  }
}