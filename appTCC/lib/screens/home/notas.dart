import 'package:appTCC/models/nota.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/nota_list.dart';
import 'package:appTCC/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notas extends StatefulWidget {
  @override
  _NotasState createState() => _NotasState();
}

class _NotasState extends State<Notas> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);

    return StreamProvider<List<Nota>>.value(
      value: DatabaseService().getNotas(user.uid),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NotaList(),
              ],
            ),
          )),
    );
  }
}
