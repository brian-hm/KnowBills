import 'package:appTCC/models/item.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/updateItemFrom.dart';
import 'package:appTCC/services/database.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appTCC/screens/home/item_list.dart';

class AddDespesa extends StatefulWidget {
  @override
  _AddDespesaState createState() => _AddDespesaState();
}

class _AddDespesaState extends State<AddDespesa> {
  String _dropDownValue = '1';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);

    return StreamProvider<List<Item>>.value(
      value: DatabaseService().getItems,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            ButtonTheme(
              minWidth: 300.0,
              height: 50.0,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: kMainColor)),
                  color: kMainColor,
                  child: Text(
                    'Adicionar',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    modalBottomSheet(context, user.uid);
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _dropDownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 20,
                  elevation: 16,
                  style: TextStyle(color: Colors.grey),
                  underline: Container(
                    height: 2,
                    color: kMainColor,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      _dropDownValue = newValue;
                    });
                  },
                  items: <String>['1', '2', '3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    onPressed: () {})
              ],
            ),
            SizedBox(height: 20),
            ItemList(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void modalBottomSheet(context, uid) {
    String _categoria;
    String _descricao;
    double _valor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
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
                    Text('Descrição',
                        style: TextStyle(color: kMainColor, fontSize: 20)),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Nome do produto'),
                      validator: (val) =>
                          val.isEmpty ? 'Insira um descrição' : null,
                      onChanged: (val) {
                        setState(() {
                          _descricao = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('Categoria',
                        style: TextStyle(color: kMainColor, fontSize: 20)),
                    SizedBox(
                      height: 5.0,
                    ),
                    DropdownButton<String>(
                      value: _categoria,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 20,
                      elevation: 16,
                      style: TextStyle(color: Colors.grey),
                      underline: Container(
                        height: 2,
                        color: kMainColor,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _categoria = newValue;
                        });
                      },
                      items: <String>['1', '2', '3']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('Valor',
                        style: TextStyle(color: kMainColor, fontSize: 20)),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          textInputDecoration.copyWith(hintText: '00.00'),
                      validator: (val) =>
                          val.isEmpty ? 'Informe o valor' : null,
                      onChanged: (val) {
                        setState(() {
                          _valor = double.parse(val);
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
                              'Salvar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await DatabaseService(uid: uid).insertItemData(
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
        });
  }
}
