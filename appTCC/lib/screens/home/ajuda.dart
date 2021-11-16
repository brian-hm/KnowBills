import 'package:appTCC/shared/constants.dart';
import 'package:flutter/material.dart';

class Ajuda extends StatefulWidget {

  @override
  _AjudaState createState() => _AjudaState();
}

class MyItem{
  final String header;
  final String body;
  bool isExpanded;
  MyItem({this.isExpanded: false, this.header, this.body});  
}

class _AjudaState extends State<Ajuda> {
  List<MyItem> _items = <MyItem>[
    MyItem(header: "DESPESAS", body: "Tela que exibe os produtos cadastrados, permitindo alterá-los (selecionando o produto) e também adicionar um novo, clicando no botão Adicionar."),
    MyItem(header: "CATEGORIAS", body:  "Recomenda-se alterar os produtos cadastrados, associandos as categorias para melhor controle de desepesas. As categorias e o total de gastos ficão exobidos na tela inicial do aplicativo. A partir dela também é possível gerenciar as categorias (Alterar, deletar e criar novas)." ),
    MyItem(header: "QR-CODE", body: "Essa função permite registrar os produtos comprados, bastando apontar a câmara para o código QR-Code de uma nota fiscal."),
    MyItem(header: "NOTAS", body: "Tela que exibe as notas cadastradas no aplicativos. Para consultá-las basta selecioná-las. Será exibido os itens pertencentes a ela, permitindo também a alteração e deleção. Além disso é possível consultar a nota fiscal eletrônica, clicando em Visualizar Nota."),
    MyItem(header: "CONFIGURAÇÕES", body: "Tela que oferece opções para alterar os dados pessoais e realizar o logout do aplicativo.")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: Text("INSTRUÇOES PARA USO"),
              backgroundColor: Color(0xFF43BE7C)
            ),
      body: ListView(
        children: <Widget>[
          ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.all(8),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _items[index].isExpanded = !_items[index].isExpanded;
              });
            },

            children: _items.map((MyItem item ) {
              return ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded){
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Text(item.header, style: TextStyle(color: kMainColor),));
                },
                isExpanded: item.isExpanded,
                body: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(item.body))
              );
            }).toList(),
          )
        ],
      )
    );
  }
}