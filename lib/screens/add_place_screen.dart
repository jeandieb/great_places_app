import 'package:flutter/material.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = './add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
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
                ImageInput(),
              ],),
            ),
          )),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(elevation: 0.0, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            icon: Icon(Icons.add),
            onPressed: () {},
            label: Text('Add Place'),
          )
        ],
      ),
    );
  }
}
