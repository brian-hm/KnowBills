import 'package:appTCC/models/fiscalDocument.dart';
import 'package:appTCC/screens/home/fiscalDoc_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiscalDocumentList extends StatefulWidget {
  @override
  _FiscalDocumentListState createState() => _FiscalDocumentListState();
}

class _FiscalDocumentListState extends State<FiscalDocumentList> {
  @override
  Widget build(BuildContext context) {
    final fiscalDocs = Provider.of<List<FiscalDocument>>(context);

    // fiscalDocs.forEach((fiscalDoc) {
    //   print(fiscalDoc.local);
    //   print(fiscalDoc.emitente);
    //   print(fiscalDoc.data);
    //   print(fiscalDoc.total);
    // });

    return ListView.builder(
        itemCount: fiscalDocs.length,
        itemBuilder: (context, index) {
          return FiscalDocTile(fiscalDoc: fiscalDocs[index]);
        });
  }
}
