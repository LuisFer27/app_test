import 'package:app_test/core/route.dart';

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
  void dispose() {
    videoRecorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
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
                              .videoController!.value.aspectRatio,
                          child: Stack(
                            children: [
                              VideoPlayer(
                                  videoRecorderController.videoController!),
                              Center(
                                child: videoRecorderController
                                        .videoController!.value.isPlaying
                                    ? const SizedBox()
                                    : const SizedBox.square(
                                        dimension: 100,
                                        //child: Image.asset('assets/playicon.png'),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 30),
              Btns(
                menuText: 'Seleccionar video',
                onTap: () async {
                  await videoRecorderController.pickVideoFromGallery();
                  setState(() {});
                },
              ),
              const SizedBox(height: 10),
              Btns(
                menuText: 'Grabar video',
                onTap: () async {
                  await videoRecorderController.pickVideoFromCamera();
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
