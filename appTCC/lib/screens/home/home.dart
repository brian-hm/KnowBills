import 'package:appTCC/models/fiscalDocument.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/addDespesa.dart';
import 'package:appTCC/screens/home/data.dart';
import 'package:appTCC/screens/home/notas.dart';
import 'package:appTCC/screens/home/settings.dart';
import 'package:appTCC/services/auth.dart';
import 'package:appTCC/services/database.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:appTCC/shared/qrcodeScan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Text> _titles = [
    Text('DESPESAS GERAIS'),
    Text('DESPESAS'),
    Text('QR CODE'),
    Text('NOTAS'),
    Text('CONFIGURAÇÕES')
  ];

  final List<Widget> _children = [
    Data(),
    AddDespesa(),
    ScanQrcode(),
    Notas(),
    Settings()
  ];

  final AuthService _auth = AuthService();

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);

    return DefaultTabController(
      length: _currentIndex == 0 ? 2 : 0,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            // bottom: _currentIndex == 0
            //     ? TabBar(tabs: <Widget>[
            //         Tab(text: "GERAL",),
            //         Tab(text: "MÊS",)
            //       ])
            //     : null,
            title: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('lib/images/logo.png'),
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  _titles[_currentIndex]
                ],
              ),
            ),
            backgroundColor: Color(0xFF43BE7C),
          ),
        ),
        body:
            // TabBarView(children: [],) para exibir DIA MES e ANO
            _children[_currentIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: kMainColor,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.white,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_grocery_store_outlined),
                label: 'Despesas',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code_scanner_outlined), label: "QR code"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.file_copy_outlined), label: "Notas"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_applications_outlined),
                  label: "Configurações")
            ],
          ),
        ),
      ),
    );
  }
}
