import 'dart:io';

import '../models/place.dart';
import '../widgets/location_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/great_places.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = './add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage)
  {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng){
    _pickedLocation = PlaceLocation(longitude: lng, latitude: lat);
  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null)
    {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                ),
                SizedBox(height: 10,),
                ImageInput(_selectImage),
                SizedBox(height: 10,),
                LocationInput(_selectPlace)
              ],),
            ),
          )),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(elevation: 0.0, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            icon: Icon(Icons.add),
            onPressed: _savePlace,
            label: Text('Add Place'),
          )
        ],
      ),
    );
  }
}
