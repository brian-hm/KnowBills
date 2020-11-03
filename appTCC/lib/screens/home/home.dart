import 'package:appTCC/models/fiscalDocument.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/fiscalDocument_list.dart';
import 'package:appTCC/screens/home/qrCodeScan.dart';
import 'package:appTCC/services/auth.dart';
import 'package:appTCC/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  String code = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);

    return StreamProvider<List<FiscalDocument>>.value(
      //acessa a Stream em database.dart
      value: DatabaseService(uid: user.uid)
          .fiscalDocuments, //todo widget abaixo poderar acessar os dados da Stream
      child: Scaffold(
        appBar: AppBar(
          title: Text('App Flutter'),
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: FiscalDocumentList(),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 60.0,
          ),
        ),
        floatingActionButton: ButtonTheme(
          height: 70.0,
          child: RaisedButton(
            child: Text("QR"),
            shape: CircleBorder(),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScanQrCode()));
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
