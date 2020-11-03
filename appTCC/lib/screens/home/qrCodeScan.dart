import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

// ignore: camel_case_types
class ScanQrCode extends StatefulWidget {
  @override
  _ScanQrCodeState createState() => _ScanQrCodeState();
}

// ignore: camel_case_types
class _ScanQrCodeState extends State<ScanQrCode> {
  String code = "";

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
    return Scaffold(
        appBar: AppBar(
          title: Text("Bar Code Scanner"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: MaterialButton(
                color: Colors.blue,
                child: Text('Scan QR code'),
                onPressed: () => scanQrCode(),
              ),
            ),
            Text(code,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ));
  }
}
