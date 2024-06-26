import 'package:appTCC/models/categoria.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/addCategoriaForm.dart';
import 'package:appTCC/screens/home/updateCategoriaForm.dart';
import 'package:appTCC/services/database.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:appTCC/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GerenciarCategorias extends StatefulWidget {
  @override
  _GerenciarCategoriasState createState() => _GerenciarCategoriasState();
}

class _GerenciarCategoriasState extends State<GerenciarCategorias> {
  List<Categoria> categorias = [];

  @override
  Widget build(BuildContext context) {

    void _showAddPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return AddCategoriaForm();
          });
    }

    void _showUpdatePanel(Categoria categoria) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return UpdateCategoriaForm(categoria: categoria);
          });
    }


    final user = Provider.of<Usuario>(context);
    
    return StreamBuilder<List<Categoria>>(
      stream: DatabaseService(uid: user.uid).getCategorias,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Loading();
        }else{
          for (int i = 0; i < snapshot.data.length; i++) {
            Categoria categoria = new Categoria();
            categoria = snapshot.data[i];
            categorias.add(categoria);            
          }
          return  Scaffold(
            appBar: AppBar(
              title: Text("CATEGORIAS"),
              backgroundColor: Color(0xFF43BE7C)
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                children: [
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: kMainColor)),
                    color: kMainColor,
                    child: Text(
                      'Nova Categoria',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                       _showAddPanel();
                    }),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categorias.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(categorias[index].descricao),
                              Text(categorias[index].total.toString())
                            ],
                          ),
                          onPressed: (){
                            _showUpdatePanel(categorias[index]);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

