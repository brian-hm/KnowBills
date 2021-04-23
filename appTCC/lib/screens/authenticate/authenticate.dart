import 'package:appTCC/screens/authenticate/register.dart';
import 'package:appTCC/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

//Esse arquivo define se irá para a tela de log in ou a de registro

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn =
          !showSignIn; //toda vez que a funçaõ for chamada, o valor é invertido
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(
          toggleView:
              toggleView); //passa toggleView por parametro para as páginas "toggleView" do tipo toggleView()
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
