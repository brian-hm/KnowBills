import 'package:flutter/material.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:appTCC/models/categoria.dart';
import 'package:appTCC/services/database.dart';
import 'package:appTCC/shared/loading.dart';
import 'package:appTCC/models/user.dart';
import 'package:provider/provider.dart';

class AddItemForm extends StatefulWidget {
  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();

  String _categoria;
  String _descricao;
  double _valor;

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
              Text("ADICIONAR ITEM",
                  style: TextStyle(color: kMainColor, fontSize: 20)),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Nome do produto',
                  labelText: 'Descrição',
                ),
                validator: (val) => val.isEmpty ? 'Insira um descrição' : null,
                onChanged: (val) {
                  setState(() {
                    _descricao = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: textInputDecoration.copyWith(
                    hintText: 'R\$ 00.00', labelText: 'Valor'),
                validator: (val) => val.isEmpty ? 'Informe o valor' : null,
                onChanged: (val) {
                  setState(() {
                    _valor = double.parse(val);
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),

              //Dropdown with Stream
              StreamBuilder<List<Categoria>>(
                stream: DatabaseService().getCategorias,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Loading();
                  } else {
                    List<DropdownMenuItem> categorias = [];
                    for (int i = 0; i < snapshot.data.length; i++) {
                      Categoria snap = snapshot.data[i];
                      categorias.add(DropdownMenuItem(
                        child: Text(
                          snap.descricao,
                        ),
                        value: snap.descricao,
                      ));
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Categoria',
                            style: TextStyle(color: kMainColor, fontSize: 20)),
                        DropdownButton(
                          items: categorias,
                          onChanged: (currentValue) {
                            setState(() {
                              _categoria = currentValue;
                            });
                          },
                          value: _categoria,
                          isExpanded: false,
                          hint: Text('Selecione a Categoria'),
                        ),
                      ],
                    );
                  }
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
                          side: BorderSide(color: kMainColor)),
                      color: kMainColor,
                      child: Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).insertItemData(
                            _descricao,
                            _valor,
                            _categoria,
                          );
                          Navigator.pop(context);
                        }
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
