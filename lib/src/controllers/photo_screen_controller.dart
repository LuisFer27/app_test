import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PhotoScreenController {
  File? image;
  List<XFile> multipleimage = [];

  Future<void> pickimagefromgallery() async {
    final imagepicked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imagepicked != null) {
      image = File(imagepicked.path);
    }
  }

  Future<void> pickimagefromcamera() async {
    final imagepicked =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagepicked != null) {
      image = File(imagepicked.path);
    }
  }

  Future<void> pickmultipleimage() async {
    List<XFile> imagepicked = await ImagePicker().pickMultiImage();
    multipleimage.addAll(imagepicked);
  }
}
