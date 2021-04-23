import 'package:appTCC/screens/authenticate/forgotPswd.dart';
import 'package:appTCC/services/auth.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:appTCC/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //instance of AuthService to use de Futures on auth.dart
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  //chave criada para validar Form
  //cada TextFormFiel terá o validator

  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text(
                  "LOGIN",
                  style: TextStyle(color: Color(0xFF43BE7C)),
                ),
                actions: [
                  FlatButton.icon(
                      icon: Icon(
                        Icons.person,
                        color: Color(0xFF43BE7C),
                      ),
                      label: Text('Registrar',
                          style: TextStyle(color: Color(0xFF43BE7C))),
                      onPressed: () {
                        widget.toggleView();
                      })
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ImageIcon(AssetImage('lib/images/logo.png'),
                              color: Color(0xFF43BE7C), size: 100),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Email',
                          style:
                              TextStyle(color: Color(0xFF43BE7C), fontSize: 20),
                        ),
                        SizedBox(height: 5.0),
                        TextFormField(
                          //textInputDecoration será está no arquivo "shared/constants"
                          decoration: textInputDecoration.copyWith(
                              hintText: 'exemplo@gmail.com'),

                          validator: (val) =>
                              val.isEmpty ? 'Digite um e-mail' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Senha',
                          style:
                              TextStyle(color: Color(0xFF43BE7C), fontSize: 20),
                        ),
                        SizedBox(height: 5.0),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: ''),
                          validator: (val) => val.length < 6
                              ? 'Digite uma senha com 6+ caracteres'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                                child: Text(
                                  'Esqueceu a senha?',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Color(0xFF43BE7C)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ForgotPswd()));
                                }),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: ButtonTheme(
                            minWidth: 200.0,
                            height: 50.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Color(0xFF43BE7C))),
                                color: Color(0xFF43BE7C),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () async {
                                  //é valido somente se os validators forem null
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    //dynamic bc could be null or a firabase user
                                    dynamic result =
                                        await _auth.signInWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error =
                                            'Não foi possível fazer Login com essas credenciais';
                                      });
                                    }
                                  }
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(error,
                            style:
                                TextStyle(color: Colors.red, fontSize: 14.0)),
                      ],
                    )),
              ),
            ));
  }
}
