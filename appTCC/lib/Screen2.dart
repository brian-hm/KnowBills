import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Screen2 extends StatefulWidget {
  final String nota;
  Screen2(this.nota);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final produto = TextEditingController();
  final valor = TextEditingController();

  CollectionReference item = FirebaseFirestore.instance.collection('item');

  Future<void> insertData(product, price) async {
    return item
        .add({'nota': widget.nota, 'produto': product, 'valor': price}).then(
            (value) => print("Product add"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Itens'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Produto"),
              controller: produto,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Valor"),
              controller: valor,
            ),
            RaisedButton(
                child: Text('Salvar',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () {
                  insertData(produto.text, valor.text);
                }),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('item')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      if (querySnapshot.hasError) return Text("Some Error");
                      if (querySnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        final products = querySnapshot.data.docs;
                        return ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            if (products[index].data()['nota'].toString() ==
                                widget.nota) {
                              return Row(
                                children: [
                                  Text("Produto: " +
                                      products[index].data()['produto']),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Valor: " +
                                      products[index]
                                          .data()['valor']
                                          .toString()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Tributo: " +
                                      products[index]
                                          .data()['tributo']
                                          .toString())
                                ],
                              );
                            }
                            return Text('');
                          },
                        );
                      }
                    })),
          ],
        ));
  }
}
