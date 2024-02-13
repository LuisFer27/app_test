import 'package:app_test/core/libraries.dart';

class VideoRecorderController {
  File? video;
  VideoPlayerController? videoController;

  Future<void> pickVideoFromGallery() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
      videoController = VideoPlayerController.file(video!)
        ..initialize().then((_) {
          videoController!.play();
          videoController!.setLooping(true);
        });
    }
  }

  Future<void> pickVideoFromCamera() async {
    final pickedVideo = await ImagePicker().pickVideo(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      maxDuration: const Duration(seconds: 5),
    );
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
      videoController = VideoPlayerController.file(video!)
        ..initialize().then((_) {
          videoController!.play();
          videoController!.setLooping(true);
        });
    }
  }

  void toggleVideoPlayback() {
    videoController!.value.isPlaying
        ? videoController!.pause()
        : videoController!.play();
  }

  void dispose() {
    videoController?.dispose();
  }
}
