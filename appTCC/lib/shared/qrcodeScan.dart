import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/Webscraping/webscraping_Fazenda.dart';
import 'package:appTCC/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:appTCC/shared/webview_nota.dart';
import 'package:appTCC/shared/constants.dart';

class ScanQrcode extends StatefulWidget {
  @override
  _ScanQrcodeState createState() => _ScanQrcodeState();
}

class _ScanQrcodeState extends State<ScanQrcode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
              child: (result != null)
                  ? WebscrapingFazenda(url: result.code, uid: user.uid)
                  : Text("Scan a code")),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
