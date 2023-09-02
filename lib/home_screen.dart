import 'package:flutter/material.dart';
import 'package:app_test/record/record.dart';
import 'package:app_test/profile/photo_screen.dart';
import 'package:app_test/video/video_record.dart';
import 'package:app_test/list/list.dart';
import 'package:app_test/geolocalization/geolocalization.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Home',
            ),
            ElevatedButton(
                child: const Text("Grabar audio"),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RecordPage(title: 'Grabar audio')))
                    }),
            ElevatedButton(
                child: const Text("Tomar foto"),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PhotoScreen(title: 'Tomar foto')))
                    }),
            ElevatedButton(
                child: const Text("Tomar video"),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const VideoRecord(title: 'Tomar video')))
                    }),
            ElevatedButton(
                child: const Text("Ver lista"),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ListPage(title: 'Ver lista')))
                    }),
            ElevatedButton(
                child: const Text("Ver Ubicación"),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const GeolocatorPage(title: 'Ver ubicación')))
                    })
          ],
        ),
      ),
    );
  }
}
