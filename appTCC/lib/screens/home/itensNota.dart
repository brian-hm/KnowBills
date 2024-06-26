import 'package:appTCC/models/item.dart';
import 'package:appTCC/models/nota.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/deleteItensFromNota.dart';
import 'package:appTCC/screens/home/item_list.dart';
import 'package:appTCC/shared/webview_nota.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appTCC/services/database.dart';

class ItensFromNota extends StatefulWidget {
  final Nota nota;
  ItensFromNota({this.nota});
  @override
  _ItensFromNotaState createState() => _ItensFromNotaState();
}

class _ItensFromNotaState extends State<ItensFromNota> {

  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);


    return (widget.nota.chave != null)
        ? StreamProvider<List<Item>>.value(
            value:
                DatabaseService(uid: user.uid).getItensNota(widget.nota.chave),
            child: Scaffold(
              appBar: AppBar(
                  actions: [
                    TextButton(
                      onPressed: () => showDialog(
                        context: context, 
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("DELETAR NOTA"),
                          content: Text("Isso irá deletar todos os itens que pertecem a nota fiscal. Tem certeza que deseja deletar a nota?"),
                          actions: [
                            TextButton(
                              child: Text("Cancel"),
                              onPressed: () => Navigator.pop(context, 'Cancel') ,
                            ),
                            TextButton(
                              child: Text("Ok"),
                              onPressed: () =>  Navigator.pushReplacement
                              (
                                  context,
                                     MaterialPageRoute(
                                    builder: (context) => DeleteItensFromNota(
                                    nota: widget.nota.chave,
                              ))),
                            )
                          ],
                        )), 
                      child: Icon(Icons.delete, color: Colors.red,))
                  ],
                  title: Text("ITENS DA NOTA"),
                  backgroundColor: Color(0xFF43BE7C)),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          child: Text("LOCAL DA COMPRA: " + widget.nota.local)),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          alignment: Alignment.topLeft,
                          child: Text("VALOR TOTAL: R\$ " + widget.nota.valor.toString())),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          alignment: Alignment.topLeft,
                          child: Text("DATA: " + widget.nota.data)),
                        ItemList(),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                label: Text("Visualizar Nota"),
                icon: Icon(Icons.article),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebViewNota(
                                url: widget.nota.link,
                              )));
                },
              ),
            ),
          )
        : Container();
  }
}
