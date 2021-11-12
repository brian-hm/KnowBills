import 'package:appTCC/models/item.dart';
import 'package:appTCC/screens/home/notas.dart';
import 'package:appTCC/services/database.dart';
import 'package:appTCC/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class DeleteItensFromNota extends StatelessWidget {
  final String nota;
  const DeleteItensFromNota({this.nota});

  void _deleteItem(Item item) async{
    await DatabaseService().removeValueCategoria(item.categoria, item.valor);
    await DatabaseService().deleteItem(item.key);
  }

  void _deleteNota(String chave) async{
    await DatabaseService().deleteNota(chave);
    
  }


  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<List<Item>>(
      stream: DatabaseService().getItensNota(nota),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Loading();
        }else{
          for (int i = 0; i < snapshot.data.length; i ++){ 
            _deleteItem(snapshot.data[i]);           
          }
          _deleteNota(nota);

          Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home()));
          

          return Container(
            // child: Scaffold(
            //   appBar: AppBar(
            //     title: Text("ITENS DA NOTA"),
            //     backgroundColor: Color(0xFF43BE7C)
            //   ),
            //   body: Container(
            //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            //     child: Center(child: Text("Nota Excluida")),
            //   ),
            // ),
          );

        }
        
      },
    );
  }
}