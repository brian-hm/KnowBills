import 'package:appTCC/models/categoria.dart';
import 'package:appTCC/models/item.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/services/database.dart';
import 'package:flutter/material.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:appTCC/shared/loading.dart';

class UpdateItemForm extends StatefulWidget {
  final Item item;
  UpdateItemForm({this.item});

  @override
  _UpdateItemFormState createState() => _UpdateItemFormState();
}

class _UpdateItemFormState extends State<UpdateItemForm> {
  final _formKey = GlobalKey<FormState>();

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
              Text("ALTERAR DADOS",
                  style: TextStyle(color: kMainColor, fontSize: 20)),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: widget.item.descricao,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Nome do produto', labelText: "Descrição"),
                validator: (val) => val.isEmpty ? 'Insira uma descrição' : null,
                onChanged: (val) {
                  setState(() {
                    widget.item.descricao = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: "R\$ " + widget.item.valor.toString(),
                keyboardType: TextInputType.number,
                decoration: textInputDecoration.copyWith(
                    hintText: 'R\$ 00.00', labelText: 'Valor'),
                validator: (val) => val.isEmpty ? 'Informe o valor' : null,
                onChanged: (val) {
                  setState(() {
                    widget.item.valor = double.parse(val);
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              // Text('Categoria',
              //     style: TextStyle(color: kMainColor, fontSize: 20)),
              // DropdownButton<String>(
              //   value: widget.item.categoria.toString(),
              //   icon: Icon(Icons.arrow_drop_down),
              //   iconSize: 20,
              //   elevation: 16,
              //   style: TextStyle(color: Colors.grey),
              //   underline: Container(
              //     height: 2,
              //     color: kMainColor,
              //   ),
              //   onChanged: (String newValue) {
              //     setState(() {
              //       widget.item.categoria = newValue;
              //     });
              //   },
              //   items: <String>['1', '2', '3']
              //       .map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // ),
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
                              widget.item.categoria = currentValue;
                            });
                          },
                          value: widget.item.categoria,
                          isExpanded: false,
                          hint: Text('Selecione a Categoria'),
                        ),
                      ],
                    );
                  }
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
                        'Salvar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateItemData(
                            widget.item.key,
                            widget.item.descricao,
                            widget.item.valor,
                            widget.item.categoria,
                          );
                          Navigator.pop(context);
                        }
                      }),
                ),
              ),
            ],
          ),
        ));
    ;
  }
}
