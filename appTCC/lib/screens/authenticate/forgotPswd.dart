import 'package:appTCC/shared/constants.dart';
import 'package:flutter/material.dart';

class ForgotPswd extends StatefulWidget {
  @override
  _ForgotPswdState createState() => _ForgotPswdState();
}

class _ForgotPswdState extends State<ForgotPswd> {
  final _formKey = GlobalKey<FormState>();
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Color(0xFF43BE7C),
          title: Text("ESQUECI A SENHA"),
        ),
      ),
      body: Container(
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
                SizedBox(height: 30.0),
                Text('Email',
                    style: TextStyle(color: Color(0xFF43BE7C), fontSize: 20)),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'exemplo@gmail.com'),
                  validator: (val) => val.isEmpty ? 'Digite um e-mail' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: kMainColor)),
                        color: kMainColor,
                        child: Text(
                          'Enviar',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {}),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
