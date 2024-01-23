import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoRecorderController {
  File? video;
  VideoPlayerController? videocontroller;

  Future<void> pickVideoFromGallery() async {
    final videopicked =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (videopicked != null) {
      video = File(videopicked.path);
      videocontroller = VideoPlayerController.file(video!)
        ..initialize().then((_) {
          videocontroller!.play();
          videocontroller!.setLooping(true);
        });
    }
  }

  Future<void> pickVideoFromCamera() async {
    final videopicked = await ImagePicker().pickVideo(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        maxDuration: const Duration(seconds: 05));
    if (videopicked != null) {
      video = File(videopicked.path);
      videocontroller = VideoPlayerController.file(video!)
        ..initialize().then((_) {
          videocontroller!.play();
          videocontroller!.setLooping(true);
        });
    }
  }

  void toggleVideoPlayback() {
    videocontroller!.value.isPlaying
        ? videocontroller!.pause()
        : videocontroller!.play();
  }
}
