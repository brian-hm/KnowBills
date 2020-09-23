import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/wrapper.dart';
import 'package:appTCC/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //StreamProvider para saber se o usuário está logado ou não
    //o valor de value será a Stream criada em auth.dart que verifica o stata da autenticação
    //feito isso os dados do Usuario da Stream pode ser acessado por tudo que está dentro de Material App, no caso a screen Wrapper()
    //a Stream retorna um usuario se estiver logado ou null caso não estiver
    return StreamProvider<Usuario>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
