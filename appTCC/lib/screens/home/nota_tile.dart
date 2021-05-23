import 'package:appTCC/models/nota.dart';
import 'package:appTCC/screens/home/itensNota.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:appTCC/shared/webview_nota.dart';
import 'package:flutter/material.dart';
import 'package:appTCC/shared/constants.dart';
import 'package:hexcolor/hexcolor.dart';

class NotaTile extends StatelessWidget {
  final Nota nota;
  NotaTile({this.nota});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: HexColor("#4E7861"),
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                leading: Text("R\$ " + nota.valor.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 20)),
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
                    Text(nota.data, style: TextStyle(color: Colors.white))),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItensFromNota(nota: nota),
                        ));
                  },
                  child:
                      Text("VER ITENS", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("DELETAR", style: TextStyle(color: Colors.red)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
