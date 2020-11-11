import 'package:appTCC/services/auth.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        children: [
          Center(
            child: Text(
              'USUÁRIO',
              style: TextStyle(color: kMainColor, fontSize: 40),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: FlatButton(
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: kMainColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Alterar Dados",
                    style: TextStyle(color: kMainColor, fontSize: 25),
                  )
                ],
              ),
              onPressed: () {},
            ),
          ),
          Center(
            child: FlatButton(
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          )
        ],
      ),
    );
  }
}
