import 'package:appTCC/models/item.dart';
import 'package:appTCC/models/nota.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/item_list.dart';
import 'package:appTCC/shared/webview_nota.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                  title: Text("ITENS DA NOTA"),
                  backgroundColor: Color(0xFF43BE7C)),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("LOCAL DA COMPRA: " + widget.nota.local),
                      Text("VALOR TOTAL: R\$ " + widget.nota.valor.toString()),
                      Text("DATA: " + widget.nota.data),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewNota(
                                          url: widget.nota.link,
                                        )));
                          },
                          child: Text('Visualizar Nota')),
                      ItemList(),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Text("Tá vazio");
  }
}
