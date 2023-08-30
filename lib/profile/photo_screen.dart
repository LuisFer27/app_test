import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class PhotoScreen extends StatefulWidget {
   const PhotoScreen ({super.key, required this.title});
  final String title;

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

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
      // ignore: unused_local_variable
      var imageFile = picture;
    });
    Navigator.of(context).pop();
  }
void _openCamera(BuildContext context) async {
  final ImagePicker _picker = ImagePicker();
    var picture = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      // ignore: unused_local_variable
      var imageFile = picture;
    });
    Navigator.of(context).pop();
  }
  Widget _setImageView() {
    // ignore: prefer_typing_uninitialized_variables
    var imageFile;
    // ignore: unnecessary_null_comparison
    if (imageFile != null) {
      return Image.file(imageFile, width: 500, height: 500);
    } else {
      return const Text("Please select an image");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
