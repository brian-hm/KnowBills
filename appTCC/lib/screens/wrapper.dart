import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:appTCC/screens/home/home.dart';
import 'package:provider/provider.dart';

//retorna HOME ou pagina de Autenticação
//depende se o usuário está logado ou não

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //user recebe os dados da StreamProvider do main.dart
    final user = Provider.of<Usuario>(context);

    //return Home ou Autheticate Widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
