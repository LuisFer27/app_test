import 'package:flutter/material.dart';
import 'package:app_test/src/controllers/photo_screen_controller.dart';
import 'package:app_test/src/widgets/Buttons/btns.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key, required this.title});
  final String title;

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  late PhotoScreenController photoScreenController;

  @override
  void initState() {
    photoScreenController = PhotoScreenController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              photoScreenController.image == null
                  ? const SizedBox(
                      height: 400,
                      width: 300,
                      child: Placeholder(),
                    )
                  : Image.file(
                      photoScreenController.image!,
                      height: 400,
                      width: 300,
                      fit: BoxFit.contain,
                    ),
              const SizedBox(height: 30),
              Btns(
                menuText: 'Seleccionar imagen',
                onTap: () async {
                  await photoScreenController.pickImageFromGallery();
                  setState(() {});
                },
              ),
              const SizedBox(height: 10),
              Btns(
                menuText: 'Abrir cámara',
                onTap: () async {
                  await photoScreenController.pickImageFromCamera();
                  setState(() {});
                },
              ),
              const SizedBox(height: 10),
              Btns(
                menuText: 'Seleccionar múltiples imágenes',
                onTap: () async {
                  photoScreenController.multipleImages.clear();
                  await photoScreenController.pickMultipleImages();
                  setState(() {});
                },
              ),
              const SizedBox(height: 30),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: photoScreenController.multipleImages.length * 420,
                  maxWidth: 300,
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: photoScreenController.multipleImages.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Image.file(
                          photoScreenController.multipleImages[index],
                          height: 400,
                          width: 300,
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
