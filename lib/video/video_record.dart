import 'package:app_test/controller/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
class VideoRecord extends StatefulWidget {
  const VideoRecord({super.key, required this.title});
  final String title;
  @override
  State<VideoRecord> createState() => _VideoRecordState();
}

class _VideoRecordState extends State<VideoRecord> {
String ? imagePath;
  String ? videoPath;
late VideoPlayerController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Selccionar video'),
            (videoPath == null) ? Container() : AspectRatioVideo(_controller),
            ElevatedButton(
              child: Text('Grabar Video'),
              onPressed: () async {
                final ImagePicker _picker=ImagePicker();
                XFile? _pickedFile =
                 await _picker.pickVideo(
                  source: ImageSource.camera,
                  maxDuration: const Duration(seconds: 10),
                );
                videoPath=_pickedFile?.path;
               
                _controller=VideoPlayerController.networkUrl(videoPath as Uri);
                _controller.initialize();
                _controller.setLooping(true);
                _controller.play();
                setState(() {
                  
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}


