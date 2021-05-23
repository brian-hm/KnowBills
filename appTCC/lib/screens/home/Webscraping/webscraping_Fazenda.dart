import 'package:appTCC/models/categoria.dart';
import 'package:appTCC/models/item.dart';
import 'package:appTCC/models/nota.dart';
import 'package:appTCC/screens/home/itensNota.dart';
import 'package:appTCC/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:appTCC/services/database.dart';
import 'package:appTCC/shared/constants.dart';

class WebscrapingFazenda extends StatefulWidget {
  final String url;
  final String uid;
  WebscrapingFazenda({this.url, this.uid});
  @override
  _WebscrapingFazendaState createState() => _WebscrapingFazendaState();
}

class _WebscrapingFazendaState extends State<WebscrapingFazenda> {
  List<Item> newsItens;
  Nota newNota = new Nota();
  double totalValorNota;

  void initState() {
    super.initState();
    _getItens(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return (newsItens != null)
        ? RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: kMainColor)),
            color: kMainColor,
            child: Text('Ver Itens',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: () {
              // _updateCategoria(snapshot.data.descricao, snapshot.data.cor,
              //     categoria.total, widget.uid);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItensFromNota(
                            nota: newNota,
                          )));
            })
        : Loading();
  }

  _getItens(String uid) async {
    Nota nota = Nota();
    List<Item> itens = [];
    String rawUrl = widget.url;
    WebScraper webScraper = WebScraper('https://www.nfce.fazenda.sp.gov.br');
    String endpoint =
        rawUrl.replaceAll('https://www.nfce.fazenda.sp.gov.br', '');
    var currentDate = DateTime.now();
    String data = currentDate.day.toString() +
        "/" +
        currentDate.month.toString() +
        "/" +
        currentDate.year.toString();
    double valorNota = 0;

    if (await webScraper.loadWebPage(endpoint)) {
      final loja = webScraper.getElement('div.txtTopo', []);
      final descricoes = webScraper.getElement('span.txtTit', []);
      final valores = webScraper.getElement('span.valor', []);
      final chave = webScraper.getElement('span.chave', []);
      final total = webScraper.getElement('span.totalNumb', []);

      nota.chave = chave[0]['title'];
      nota.local = loja[0]['title'];
      nota.valor = double.parse(total[1]['title'].replaceAll(',', '.'));
      nota.link = widget.url;
      nota.data = data;

      // print(nota.chave);
      // print(nota.local);
      // print(nota.valor);
      // print(nota.link);
      // print(nota.data);

      await DatabaseService(uid: uid)
          .insertNota(nota.chave, nota.local, nota.valor, nota.link, nota.data);

      for (int i = 0; i < descricoes.length; i++) {
        Item item = new Item();
        String descricao = descricoes[i]['title'];
        String local = loja[0]['title'];
        double valor = double.parse(valores[i]['title'].replaceAll(',', '.'));
        String categoria = "Sem Categoria";

        item.idNota = nota.chave;
        item.descricao = descricao;
        item.local = local;
        item.valor = valor;
        item.categoria = categoria;

        valorNota = valorNota + item.valor;

        await DatabaseService(uid: uid).insertItemData(
          item.idNota,
          item.descricao,
          item.valor,
          item.categoria,
          item.local,
        );
        // print(item.descricao);
        // print(item.valor);
        // print(item.categoria);

        itens.add(item);
      }

      setState(() {
        newsItens = itens;
        newNota = nota;
        totalValorNota = valorNota;
      });
    }
  }

  _updateCategoria(
      String descricao, String cor, double total, String uid) async {
    await DatabaseService(uid: uid).updateCategoria(descricao, total, cor);
  }
}
