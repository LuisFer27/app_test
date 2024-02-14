import 'package:app_test/core/route.dart';

class PhotoScreenController {
  File? image;
  List<File> multipleImages = [];

  Future<void> pickImageFromGallery() async {
    final imagePicked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imagePicked != null) {
      image = File(imagePicked.path);
    }
  }

  Future<void> pickImageFromCamera() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagePicked != null) {
      image = File(imagePicked.path);
    }
  }

  Future<void> pickMultipleImages() async {
    List<XFile> imagesPicked = await ImagePicker().pickMultiImage();
    multipleImages.addAll(imagesPicked.map((xFile) => File(xFile.path)));
  }
}
