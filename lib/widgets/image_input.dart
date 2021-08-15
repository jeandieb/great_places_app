import 'dart:io';
import 'package:flutter/material.dart';


import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;


class ImageInput extends StatefulWidget {
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
    setState(() {
      _storedImage = File(imageFile.path); 
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();

   //image file .copy does not work rn because .copy works on path object but here in the new version of ImagePicker pickImage returns an XFile not a path
   //or something like that , need to read more about it to get it fixed ...
   // imageFile.copy();
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
