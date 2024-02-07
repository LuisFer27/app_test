import 'package:app_test/src/widgets/Buttons/btns.dart';
import 'package:flutter/material.dart';
import 'package:app_test/src/controllers/qr_barcode_controller.dart';

class QrBarcodePage extends StatefulWidget {
  const QrBarcodePage({super.key, required this.title});
  final String title;
  @override
  _QrBarcodeState createState() => _QrBarcodeState();
}

class _QrBarcodeState extends State<QrBarcodePage> {
  final QrBarcodeController _barcodeScannerController = QrBarcodeController();
  String _scanBarcode = 'Desconocido';

  @override
  void initState() {
    super.initState();
  }

  // Future<void> startBarcodeScanStream() async {
  //   FlutterBarcodeScanner.getBarcodeStreamReceiver(
  //           '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
  //       .listen((barcode) => print(barcode));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Btns(
                menuText: 'Escanear barcode',
                onTap: () async {
                  String result =
                      await _barcodeScannerController.scanBarcodeNormal();
                  setState(() {
                    _scanBarcode = result;
                  });
                },
              ),
              Btns(
                menuText: 'Escanear código Qr',
                onTap: () async {
                  String result = await _barcodeScannerController.scanQR();
                  setState(() {
                    _scanBarcode = result;
                  });
                },
              ),
              Text('Resultado: $_scanBarcode\n',
                  style: TextStyle(fontSize: 20)),
            ],
          ),
        );
      }),
    );
  }
}
