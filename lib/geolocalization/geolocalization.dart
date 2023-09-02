import'package:flutter/material.dart';
import'package:geolocator/geolocator.dart';


class GeolocatorPage extends StatefulWidget {
  const GeolocatorPage ({super.key,required this.title});
    final String title;

  @override
  State<GeolocatorPage> createState() => _GeolocatorPageState();
}

class _GeolocatorPageState extends State<GeolocatorPage> {

  Future<Position> determinePosition() async{
  LocationPermission permission;
  permission=await Geolocator.checkPermission();
  if(permission==LocationPermission.denied){
  permission=await Geolocator.requestPermission();
  if(permission==LocationPermission.denied){
   return Future.error('error');
  }
  }
  return await Geolocator.getCurrentPosition();
}
void getCurrentLocation()async{
  Position position=await determinePosition();
  print(position.latitude);
  print(position.longitude);
}
  @override
  Widget build(BuildContext context) {
   return Scaffold(
          appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){ getCurrentLocation();}, child: const Text('Pedir localización'))
      ),
    );
  }
}