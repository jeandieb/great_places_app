import 'dart:io';
import 'package:flutter/material.dart';


import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;


class ImageInput extends StatefulWidget {

  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if(imageFile == null)
    {
      return; 
    }
    setState(() {
      _storedImage = File(imageFile.path); 
    });
    //get a Path to a directory where the application may place data that is user-generated,
    // or that cannot otherwise be recreated by your application.
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    //get file name as named by the OS 
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(width: 1)),
          height: 100,
          width: 150,
          child: _storedImage == null
              ? Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.camera),
              label: Text('Take Picture')),
        )
      ],
    );
  }
}
