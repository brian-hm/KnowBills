import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/ajuda.dart';
import 'package:appTCC/services/auth.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Center(
        child: Column(
          children: [
            FlatButton(
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
            FlatButton(
              child: Row(
                children: [
                  Icon(
                    Icons.help,
                    color: kMainColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Ajuda",
                    style: TextStyle(color: kMainColor, fontSize: 25),
                  )
                ],
              ),
              onPressed: () {
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ajuda()),
                            );
              },
            ),
            FlatButton(
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
            )
          ],
        ),
      ),
    );
  }
}
