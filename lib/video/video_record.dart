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
      body: Center(
        child: Column(
          children: [
            Text('Selccionar video'),
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

  class AspectRatioVideo extends StatefulWidget {
    final VideoPlayerController controller;
AspectRatioVideo(this.controller);

  @override
  State<AspectRatioVideo> createState() => _AspectRatioVideoState();
}

class _AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized=false;
  void _onVideoControllerUpdate(){
   if(!mounted){
return;
   } 
   if(initialized !=controller.value.isInitialized){
initialized=controller.value.isInitialized;
setState(() {
});
   }
  }
  @override
  void initState() {
    super.initState();
    controller.addListener(_onVideoControllerUpdate);
  }
  @override
  void dispose() {
    controller.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
if(initialized){
return Container(
padding: EdgeInsets.all(10),
child: AspectRatio(
  aspectRatio: 0.8,
  child: VideoPlayer(controller),
),
);
}
else{
return Container();
}
  }
}