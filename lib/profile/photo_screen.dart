import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_test/src/widgets/Buttons/btns.dart';

class PhotoScreen extends StatefulWidget {
   const PhotoScreen ({super.key, required this.title});
  final String title;

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  File? image;
  List<XFile> multipleimage = [];

  Future<void> pickimagefromgallery() async {
    final imagepicked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imagepicked != null) {
      setState(() {
        image = File(imagepicked.path);
      });
    }
  }

  Future<void> pickimagefromcamera() async {
    final imagepicked =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagepicked != null) {
      setState(() {
        image = File(imagepicked.path);
      });
    }
  }

  Future<void> pickmultipleimage() async {
    List<XFile> imagepicked = await ImagePicker().pickMultiImage();
    setState(() {
      multipleimage.addAll(imagepicked);
    });
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
            const SizedBox(
              height: 10,
            ),
            image == null
                ? const SizedBox(
                    height: 400,
                    width: 300,
                    child: Placeholder(),
                  )
                : Image.file(
                    image!,
                    height: 400,
                    width: 300,
                    fit: BoxFit.contain,
                  ),
            const SizedBox(
              height: 30,
            ),
             Btns(
              menuText: 'Seleccionar imagen', 
              onTap: () => pickimagefromgallery()
              ),
            const SizedBox(
              height: 10,
            ),
                  Btns(menuText:'Abrir camara',
                  onTap:() => pickimagefromcamera()
                  ),
            const SizedBox(
              height: 10,
            ),
          
                Btns(
                  menuText:'Seleccionar multiples imagenes',
                  onTap:() {
                  multipleimage.removeRange(0, multipleimage.length);
                  pickmultipleimage();
                }),
            const SizedBox(
              height: 30,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: multipleimage.length * 420, maxWidth: 300),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: multipleimage.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Image.file(
                          File(multipleimage[index].path),
                          height: 400,
                          width: 300,
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  })),
            )
          ],
        )),
      ),
    );
  }
}
