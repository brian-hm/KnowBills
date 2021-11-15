import 'package:appTCC/models/categoria.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/services/database.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateCategoriaForm extends StatefulWidget {
  final Categoria categoria;
  UpdateCategoriaForm({this.categoria});

  @override
  _UpdateCategoriaFormState createState() => _UpdateCategoriaFormState();
}

class _UpdateCategoriaFormState extends State<UpdateCategoriaForm> {
  final _formKey = GlobalKey<FormState>();
  String currentCategoria;
  String newCategoria;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);

    currentCategoria = widget.categoria.descricao;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ALTERAR CATEGORIA", style: TextStyle(color: kMainColor, fontSize: 20)),
            SizedBox(
                height: 20.0,
              ),
            TextFormField(
                initialValue: widget.categoria.descricao,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Nome da categoria', labelText: "Descrição"),
                validator: (val) => val.isEmpty ? 'Insira uma descrição' : null,
                onChanged: (currentCategoria) {
                  setState(() {
                    newCategoria = currentCategoria;
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
                        await DatabaseService(uid: user.uid).updateCategoria(widget.categoria.descricao, newCategoria, widget.categoria.total);
                        Navigator.pop(context);
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