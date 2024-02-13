import 'package:app_test/core/libraries.dart';
import 'package:app_test/core/widgets.dart';
import 'package:app_test/core/controllers.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key, required this.title});
  final String title;
  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late AudioRecorderController audioRecorderController;

  @override
  void initState() {
    audioRecorderController = AudioRecorderController();
    super.initState();
  }

  @override
  void dispose() {
    audioRecorderController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (audioRecorderController.isRecording)
              const Text(
                'Grabación en progreso',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            Btns(
              menuText: audioRecorderController.isRecording
                  ? 'Parar la Grabación'
                  : 'Empezar Grabación',
              onTap: () async {
                if (audioRecorderController.isRecording) {
                  await audioRecorderController.stopRecording();
                } else {
                  await audioRecorderController.startRecording();
                }
                setState(() {});
              },
            ),
            const SizedBox(
              height: 25,
            ),
            if (!audioRecorderController.isRecording &&
                audioRecorderController.audioPath.isNotEmpty)
              Btns(
                menuText: 'Reproducir la grabación',
                onTap: audioRecorderController.playRecording,
              ),
          ],
        ),
      ),
    );
  }
}
