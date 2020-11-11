import 'package:appTCC/shared/constants.dart';
import 'package:flutter/material.dart';

class AddDespesa extends StatefulWidget {
  @override
  _AddDespesaState createState() => _AddDespesaState();
}

class _AddDespesaState extends State<AddDespesa> {
  String dropdownValue = 'Categoria 1';
  String descricao = '';
  double valor = 0.0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: dropdownValue,
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
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Categoria 1', 'Categoria 2', 'Categoria 3']
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
          OutlineButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Descrição Produto 1',
                        style: TextStyle(color: kMainColor, fontSize: 20),
                      ),
                      Text(
                        '0.00',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Text(
                    'Categoria 1',
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
            onPressed: () {},
          ),
          SizedBox(height: 20),
          OutlineButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Descrição Produto 2',
                        style: TextStyle(color: kMainColor, fontSize: 20),
                      ),
                      Text(
                        '0.00',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Text(
                    'Categoria 2',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
            ),
            onPressed: () {},
          ),
          SizedBox(
            height: 20,
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
                    'Adicionar',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    modalBottomSheet(context);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  void modalBottomSheet(context) {
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
                          descricao = val;
                        });
                      },
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
                          valor = double.parse(val);
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
                      value: dropdownValue,
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
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        'Categoria 1',
                        'Categoria 2',
                        'Categoria 3'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                            onPressed: () {}),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
