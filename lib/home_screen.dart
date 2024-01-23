import 'package:flutter/material.dart';
import 'package:app_test/src/pages/record/record.dart';
import 'package:app_test/src/pages/profile/photo_screen.dart';
import 'package:app_test/src/pages/video/video_record.dart';
import 'package:app_test/src/pages/list/list.dart';
import 'package:app_test/src/pages/geolocalization/geolocalization.dart';
import 'package:app_test/src/widgets/Buttons/btns.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(
          child: Text(
            'Aplicación de prueba',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Btns(
                  menuText: 'Grabar audio',
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const RecordPage(title: 'Grabar audio'),
                          ),
                        ),
                      }),
              Btns(
                  menuText: 'Tomar foto',
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PhotoScreen(title: 'Tomar foto'),
                          ),
                        ),
                      }),
              Btns(
                  menuText: 'Tomar video',
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const VideoRecord(title: 'Tomar video'),
                          ),
                        ),
                      }),
              Btns(
                  menuText: 'Ver lista',
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ListPage(title: 'Ver lista'),
                          ),
                        ),
                      }),
              Btns(
                  menuText: 'Ver ubicación',
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const GeolocatorPage(title: 'Ver ubicación'),
                          ),
                        ),
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
