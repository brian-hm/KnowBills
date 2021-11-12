import 'package:appTCC/models/item.dart';
import 'package:appTCC/models/nota.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/deleteItensFromNota.dart';
import 'package:appTCC/screens/home/itensNota.dart';
import 'package:appTCC/services/database.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:appTCC/shared/webview_nota.dart';
import 'package:flutter/material.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';



class NotaTile extends StatelessWidget {
  final Nota nota;
  NotaTile({this.nota});
  @override
  Widget build(BuildContext context) {


    final user = Provider.of<Usuario>(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: HexColor("#4E7861"),
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              child: ListTile(
                  leading: Text("R\$ " + nota.valor.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  title: Column(
                    children: [
                      Text(
                        nota.local,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 7,
                      )
                    ],
                  ),
                  subtitle:
                      Text(nota.data, style: TextStyle(color: Colors.white)),
                    ),
                  
              onPressed: (){
                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItensFromNota(nota: nota),
                        ));
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
