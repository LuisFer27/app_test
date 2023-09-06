import 'package:flutter/material.dart';
import 'package:app_test/record/record.dart';
import 'package:app_test/profile/photo_screen.dart';
import 'package:app_test/video/video_record.dart';
import 'package:app_test/list/list.dart';
import 'package:app_test/geolocalization/geolocalization.dart';
import 'package:app_test/view/section/menu_button.dart';

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
        title:const Center(
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
              MenuButton(
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
              MenuButton(
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
              MenuButton(
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
              MenuButton(
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
              MenuButton(
                  menuText: 'Grabar audio',
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
