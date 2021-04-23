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
    //Stream para saber se o usuário está logado ou não
    //o valor de value será a Stream criada em auth.dart que verifica o status da autenticação
    ////feito isso os dados do Usuario da Stream pode ser acessado por tudo que está dentro de Material App, no caso a screen Wrapper()
    //a Stream retorna, do firebase, um usuario se estiver logado ou null caso não estiver
    //a Strem faz a verificação a qualquer momento de alteração (SignIN,SignOut)
    //por isso assim que é feito o Login o Wrapper leva até a tela HOME
    //ou então o Logout e o Wrapper leva a tela Authentication (Login ou Register)

    //Provider, "alimentado" pela Stream que contém a informação de login ou logout
    //permite passar essa informação para todoas abaixo dele. Por isso ele tem como child
    //o MaterialApp(toda a widget three)
    //Dessa maneira, Wrapper consegue receber o status de Auth
    //O método "value" da StremProvider, permite colocar a Stream AuthService.user como valor
    return StreamProvider<Usuario>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
