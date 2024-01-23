import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:app_test/src/widgets/Buttons/btns.dart';
import 'package:app_test/src/controllers/video_recorder_controller.dart';

class VideoRecord extends StatefulWidget {
  const VideoRecord({super.key, required this.title});
  final String title;
  @override
  State<VideoRecord> createState() => _VideoRecordState();
}

class _VideoRecordState extends State<VideoRecord> {
  late VideoRecorderController videoRecorderController;

  @override
  void initState() {
    videoRecorderController = VideoRecorderController();
    super.initState();
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
            videoRecorderController.video == null
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
                        videoRecorderController.toggleVideoPlayback();
                      },
                      child: AspectRatio(
                        aspectRatio: videoRecorderController
                            .videocontroller!.value.aspectRatio,
                        child: Stack(children: [
                          VideoPlayer(videoRecorderController.videocontroller!),
                          Center(
                            child: videoRecorderController
                                    .videocontroller!.value.isPlaying
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
            Btns(
                menuText: 'Seleccionar video',
                onTap: () => videoRecorderController.pickVideoFromGallery()),
            const SizedBox(
              height: 10,
            ),
            Btns(
                menuText: 'Grabar video',
                onTap: () => videoRecorderController.pickVideoFromCamera())
          ],
        )));
  }
}
