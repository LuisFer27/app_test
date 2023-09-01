import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
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