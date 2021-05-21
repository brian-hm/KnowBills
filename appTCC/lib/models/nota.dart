import 'item.dart';

class Nota {
  String uid;
  String chave;
  String local;
  double valor;
  String link;
  String data;
  List<Item> listaItens = [];

  Nota(
      {this.uid,
      this.chave,
      this.local,
      this.valor,
      this.link,
      this.data,
      this.listaItens});
}
