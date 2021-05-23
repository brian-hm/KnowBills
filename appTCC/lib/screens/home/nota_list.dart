import 'package:appTCC/screens/home/nota_tile.dart';
import 'package:appTCC/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appTCC/models/nota.dart';

class NotaList extends StatefulWidget {
  @override
  _NotaListState createState() => _NotaListState();
}

class _NotaListState extends State<NotaList> {
  @override
  Widget build(BuildContext context) {
    final notas = Provider.of<List<Nota>>(context);
    return notas == null
        ? Loading()
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: notas.length,
            itemBuilder: (conext, index) {
              return NotaTile(nota: notas[index]);
            });
  }
}
