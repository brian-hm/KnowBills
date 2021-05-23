import 'package:appTCC/models/categoria.dart';
import 'package:appTCC/models/item.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/services/database.dart';
import 'package:appTCC/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);
    List<Categoria> categorias = [];
    double total = 0;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Colocar valor total nas categorias
            //Colocar valor total no Usuário
            StreamBuilder<List<Categoria>>(
                stream: DatabaseService(uid: user.uid).getCategorias,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Loading();
                  } else {
                    for (int i = 0; i < snapshot.data.length; i++) {
                      Categoria categoria = new Categoria();
                      categoria = snapshot.data[i];
                      categorias.add(categoria);
                      total = total + categoria.total;
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: categorias.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                categorias[index].descricao,
                                style: TextStyle(
                                    color: HexColor(categorias[index].cor)),
                              ),
                              Text(categorias[index].total.toString()),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
          ],
          // children: [
          //   Center(
          //     child: Image(image: AssetImage('lib/images/Total.png')),
          //   ),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       FlatButton(
          //           onPressed: () {},
          //           child: Text(
          //             'Adicionar Categoria',
          //           )),
          //     ],
          //   ),
          //   FlatButton(
          //       onPressed: () {},
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "Categoria 1:",
          //             style: TextStyle(color: Colors.red),
          //           ),
          //           Text(
          //             "0%",
          //             style: TextStyle(color: Colors.red),
          //           ),
          //           Text(
          //             "0.00",
          //             style: TextStyle(color: Colors.red),
          //           )
          //         ],
          //       )),
          //   FlatButton(
          //       onPressed: () {},
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "Categoria 2:",
          //             style: TextStyle(color: Colors.blue),
          //           ),
          //           Text(
          //             "0%",
          //             style: TextStyle(color: Colors.blue),
          //           ),
          //           Text(
          //             "0.00",
          //             style: TextStyle(color: Colors.blue),
          //           )
          //         ],
          //       )),
          //   FlatButton(
          //       onPressed: () {},
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "Categoria 3:",
          //             style: TextStyle(color: Colors.green),
          //           ),
          //           Text(
          //             "0%",
          //             style: TextStyle(color: Colors.green),
          //           ),
          //           Text(
          //             "0.00",
          //             style: TextStyle(color: Colors.green),
          //           )
          //         ],
          //       ))
          // ],
        ),
      ),
    );
  }
}
