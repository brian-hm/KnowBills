import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class ScanQrcode extends StatefulWidget {
  @override
  _ScanQrcodeState createState() => _ScanQrcodeState();
}

class _ScanQrcodeState extends State<ScanQrcode> {
  String code = "";

  @override
  void initState() {
    super.initState();
    scanQrCode();
  }

  scanQrCode() async {
    try {
      final result = await BarcodeScanner.scan();
      setState(() {
        code = result.rawContent;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(code),
      //talve colocar um botão para nova leitura
    );
  }
}
