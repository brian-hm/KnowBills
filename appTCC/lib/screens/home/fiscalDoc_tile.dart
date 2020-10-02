import 'package:flutter/material.dart';
import 'package:appTCC/models/fiscalDocument.dart';

//widget para exibir cada documento fiscal

class FiscalDocTile extends StatelessWidget {
  final FiscalDocument fiscalDoc;
  FiscalDocTile({this.fiscalDoc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          title: Text(fiscalDoc.local),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Valor: ${fiscalDoc.total}"),
              Text("Data: ${fiscalDoc.data}")
            ],
          ),
          trailing:
              FlatButton(onPressed: () {}, child: Icon(Icons.arrow_forward)),
        ),
      ),
    );
  }
}
