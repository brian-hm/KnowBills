import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class ScanQrCode2 extends StatefulWidget {
  @override
  _ScanQrCode2State createState() => _ScanQrCode2State();
}

class _ScanQrCode2State extends State<ScanQrCode2> {
  scan() async {
    try {
      final result = await BarcodeScanner.scan();
      return result.rawContent;
    } catch (e) {
      return print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
