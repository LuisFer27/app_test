import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:app_test/src/widgets/Buttons/btns.dart';
class VideoRecord extends StatefulWidget {
  const VideoRecord({super.key, required this.title});
  final String title;
  @override
  State<VideoRecord> createState() => _VideoRecordState();
}

class _VideoRecordState extends State<VideoRecord> {
  File? video;
  VideoPlayerController? videocontroller;
  Future<void> pickvideofromgallery() async {
    final videopicked =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (videopicked != null) {
      video = File(videopicked.path);
      videocontroller = VideoPlayerController.file(video!)
        ..initialize().then((_) {
          setState(() {});
          videocontroller!.play();
          videocontroller!.setLooping(true);
        });
    }
  }

  Future<void> pickvideofromcamera() async {
    final videopicked = await ImagePicker().pickVideo(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        maxDuration: const Duration(seconds: 05));
    if (videopicked != null) {
      video = File(videopicked.path);
      videocontroller = VideoPlayerController.file(video!)
        ..initialize().then((_) {
          setState(() {});
          videocontroller!.play();
          videocontroller!.setLooping(true);
        });
    }
  }

  @override
  void dispose() {
    videocontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            video == null
                ? const SizedBox(
                    height: 400,
                    width: 300,
                    child: Placeholder(),
                  )
                : ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 400, maxWidth: 300),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {});
                        videocontroller!.value.isPlaying
                            ? videocontroller!.pause()
                            : videocontroller!.play();
                      },
                      child: AspectRatio(
                        aspectRatio: videocontroller!.value.aspectRatio,
                        child: Stack(children: [
                          VideoPlayer(videocontroller!),
                          Center(
                            child: videocontroller!.value.isPlaying
                                ? const SizedBox()
                                : const SizedBox.square(
                                    dimension: 100,
                                    //child: Image.asset('assets/playicon.png'),
                                  ),
                          )
                        ]),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 30,
            ),
                Btns(menuText:  'Seleccionar video', onTap:() => pickvideofromgallery()),
            const SizedBox(
              height: 10,
            ),
                Btns(menuText: 'Grabar video', onTap: () => pickvideofromcamera())

          ],
        )));
  }
}
