import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/gerenciarCategorias.dart';
import 'package:appTCC/services/database.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoriaForm extends StatefulWidget {
  

  @override
  _AddCategoriaFormState createState() => _AddCategoriaFormState();
}

class _AddCategoriaFormState extends State<AddCategoriaForm> {
  final _formKey = GlobalKey<FormState>();

  String _descricao;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Usuario>(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ADICIONAR CATEGORIA", style: TextStyle(color: kMainColor, fontSize: 20)),
            SizedBox(
                height: 20.0,
            ),
            TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Nome da Categoria',
                  labelText: 'Descrição',
                ),
                validator: (val) => val.isEmpty ? 'Insira uma descrição' : null,
                onChanged: (val) {
                  setState(() {
                    _descricao = val;
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
                      side: BorderSide(color: kMainColor)
                    ),
                    color: kMainColor,
                    child: Text("Salvar", style: TextStyle(color: Colors.white, fontSize: 20),),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).insertCategoria(_descricao);
                        Navigator.restorablePopAndPushNamed(context, "teste");
                      }
                    },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}