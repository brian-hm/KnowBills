import 'package:appTCC/services/auth.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:appTCC/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); //chave criada para validar Form
  //cada TextFormFiel terá o validator

  bool loading = false;

  //text field state
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
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
                  "REGISTRAR",
                  style: TextStyle(color: Color(0xFF43BE7C)),
                ),
                actions: [
                  FlatButton.icon(
                      icon: Icon(
                        Icons.person,
                        color: Color(0xFF43BE7C),
                      ),
                      label: Text('Login',
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
                    key: _formKey, //conecta o Form com a chave para validação
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ImageIcon(AssetImage('lib/images/logo.png'),
                              color: Color(0xFF43BE7C), size: 100),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(height: 5.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: 'Nome', hintText: 'Nome Completo'),
                          validator: (val) =>
                              val.isEmpty ? 'Digite o nome' : null,
                          onChanged: (val) {
                            setState(() {
                              name = val;
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(height: 5.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: 'E-mail',
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
                        SizedBox(height: 5.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: 'Senha', hintText: ''),
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
                        SizedBox(height: 5.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: 'Confirmar Senha', hintText: ''),
                          validator: (val) => val != password
                              ? 'Senhas não correspondem'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              confirmPassword = val;
                            });
                          },
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
                                  'Registrar',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    //o método validate retorna true se os TextFormField forem válidos
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            name, email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error = 'Digite um email valido';
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
