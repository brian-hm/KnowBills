import 'package:appTCC/models/categoria.dart';
import 'package:appTCC/models/item.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/addItemForm.dart';
import 'package:appTCC/services/database.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:appTCC/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appTCC/screens/home/item_list.dart';
import 'package:hexcolor/hexcolor.dart';

class AddDespesa extends StatefulWidget {
  @override
  _AddDespesaState createState() => _AddDespesaState();
}

class _AddDespesaState extends State<AddDespesa> {
  String _categoria;

  @override
  Widget build(BuildContext context) {
    void _showAddPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return AddItemForm();
          });
    }

    final user = Provider.of<Usuario>(context);

    return StreamProvider<List<Item>>.value(
      value: DatabaseService().getItems(user.uid, _categoria),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: SingleChildScrollView(
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
                      _showAddPanel();
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<List<Categoria>>(
                    stream: DatabaseService().getCategorias,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Loading();
                      } else {
                        List<DropdownMenuItem> categorias = [];
                        categorias.add(DropdownMenuItem(
                          child: Text("Todos"),
                          value: "Todos",
                        ));
                        for (int i = 0; i < snapshot.data.length; i++) {
                          Categoria snap = snapshot.data[i];
                          categorias.add(DropdownMenuItem(
                            child: Text(
                              snap.descricao,
                              style: TextStyle(color: HexColor(snap.cor)),
                            ),
                            value: snap.descricao,
                          ));
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
      ),
    );
  }
}
