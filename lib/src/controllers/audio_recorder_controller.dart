import 'dart:io';
import 'package:audioplayers/audioplayers.dart';

import 'package:record/record.dart';
// clase AudioRecorderController va ligado al controlador

class AudioRecorderController {
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  String audioPath = '';

  AudioRecorderController() {
    audioPlayer = AudioPlayer();
    audioRecord = Record();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        isRecording = true;
      }
    } catch (e) {
      print('Error starting recording: $e');
      isRecording = false;
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      isRecording = false;
      audioPath = path ?? '';
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> playRecording() async {
    try {
      if (audioPath.isNotEmpty) {
        Source urlSource = UrlSource(audioPath);
        await audioPlayer.play(urlSource);
      } else {
        print('Audio path is empty.');
      }
    } catch (e) {
      print('Error playing recording: $e');
    }
  }

  void dispose() {
    audioRecord.dispose();
    audioPlayer.dispose();
  }
}
