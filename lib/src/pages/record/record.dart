import 'package:flutter/material.dart';

import 'package:app_test/src/widgets/Buttons/btns.dart';
import 'package:app_test/src/controllers/audio_recorder_controller.dart';

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
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
                onTap: audioRecorderController.isRecording
                    ? audioRecorderController.stopRecording
                    : audioRecorderController.startRecording),
            const SizedBox(
              height: 25,
            ),
            if (!audioRecorderController.isRecording &&
                audioRecorderController.audioPath != null)
              Btns(
                  menuText: 'Reproducir la grabación',
                  onTap: audioRecorderController.playRecording)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
