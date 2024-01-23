import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
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
      print('Error al iniciar la grabación: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      isRecording = false;
      audioPath = path!;
    } catch (e) {
      print('Error al intentar parar la grabación: $e');
    }
  }

  Future<void> playRecording() async {
    try {
      Source urlSource = UrlSource(audioPath);
      await audioPlayer.play(urlSource);
    } catch (e) {
      print('Error al reproducir la grabación: $e');
    }
  }
}
