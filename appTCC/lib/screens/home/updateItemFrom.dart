import 'package:appTCC/models/categoria.dart';
import 'package:appTCC/models/item.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/services/database.dart';
import 'package:flutter/material.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:hexcolor/hexcolor.dart';
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
  String newCategoria;
  String currentCategoria;

  double newValor = 0;
  double currentValor;
  


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);

    currentCategoria = widget.item.categoria;
    currentValor = widget.item.valor;
   

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
                initialValue: widget.item.local,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Local', labelText: "Local da compra"),
                onChanged: (val) {
                  setState(() {
                    widget.item.local = val;
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
                    newValor = double.parse(val);
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
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
                        child: Text(snap.descricao,
                            style: TextStyle(color: HexColor(snap.cor))),
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
                              newCategoria = currentValue;
                              print(newCategoria);
                            });
                          },
                          value: newCategoria,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonTheme(
                      minWidth: 150.0,
                      height: 50.0,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)),
                          color: Colors.red,
                          child: Text(
                            'Deletar',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {                                                        
                              
                              await DatabaseService(uid: user.uid).removeValueCategoria(currentCategoria, currentValor);
                              await DatabaseService(uid: user.uid).deleteItem(widget.item.key);
                                                           
                              Navigator.pop(context);
                            }
                          )
                    ),
                    ButtonTheme(
                      minWidth: 150.0,
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
                            print(newCategoria);
                            if (_formKey.currentState.validate()) {
                              await DatabaseService(uid: user.uid).updateItemData(
                                widget.item.key,
                                widget.item.idNota,
                                widget.item.descricao,
                                widget.item.local,
                                newValor != 0 ? newValor : currentValor,
                                newCategoria,
                              );
                              
                              if(currentCategoria != newCategoria){
                                  await DatabaseService(uid: user.uid).removeValueCategoria(currentCategoria, currentValor);
                                if(newValor != 0){
                                  await DatabaseService(uid: user.uid).insertValueCategoria(newCategoria, newValor);
                                }else{
                                  await DatabaseService(uid: user.uid).insertValueCategoria(newCategoria, currentValor);
                                }
                                
                                
                              }
                              Navigator.pop(context);
                            }
                          }),
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ));
    ;
  }
}
