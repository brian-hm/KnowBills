import 'package:appTCC/models/user.dart';
import 'package:appTCC/services/database.dart';
import 'package:flutter/material.dart';
import 'package:appTCC/models/categoria.dart';
import 'package:provider/provider.dart';

class DropDownCategoria extends StatefulWidget {
  @override
  _DropDownCategoriaState createState() => _DropDownCategoriaState();
}

class _DropDownCategoriaState extends State<DropDownCategoria> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);
    return StreamBuilder<List<Categoria>>(
      stream: DatabaseService(uid: user.uid).getCategorias,
      builder: (context, snapshot) {
        return Container();
      },
    );
  }
}
