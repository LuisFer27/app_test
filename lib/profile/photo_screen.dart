import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class PhotoScreen extends StatefulWidget {
   const PhotoScreen ({super.key, required this.title});
  final String title;

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  File? imageFile;



Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: const Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }
 
void _openGallery(BuildContext context) async {
     final ImagePicker _picker = ImagePicker();
 var picture = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = picture as File?;
    });
    Navigator.of(context).pop();
  }
void _openCamera(BuildContext context) async {
  final ImagePicker _picker = ImagePicker();
   final picture = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = picture as File?;
    });
    Navigator.of(context).pop();
  }
Widget _setImageView() {
    if (imageFile != null) {
      return Image.file(imageFile!, width: 500, height: 500);
    } else {
      return Text("Please select an image");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _setImageView()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSelectionDialog(context);
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
