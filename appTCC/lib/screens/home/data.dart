import 'package:appTCC/models/categoria.dart';
import 'package:appTCC/models/item.dart';
import 'package:appTCC/models/user.dart';
import 'package:appTCC/screens/home/gerenciarCategorias.dart';
import 'package:appTCC/services/database.dart';
import 'package:appTCC/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  TooltipBehavior _tooltipBehavior;
  double valorTotal = 0;

  @override
  void initState(){
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

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
                    return Column(
                      children: [
                        SfCircularChart(
                          // title: ChartTitle(text: 'Categorias'),
                          legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap, position: LegendPosition.bottom),
                          tooltipBehavior: _tooltipBehavior,
                          series: <CircularSeries>[
                            PieSeries<Categoria, String>(
                              dataSource: categorias,
                              xValueMapper: (Categoria data,_) => data.descricao,
                              yValueMapper: (Categoria data,_) => data.total,
                              dataLabelSettings: DataLabelSettings(isVisible: true),
                              enableTooltip: true,
                              radius: '100%',
                              explode: true
                            )
                          ],
                        ),
                        TextButton(
                          child: Text("Gerenciar Categorias"),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GerenciarCategorias()),
                            )
                          })
                      ],
                    );
                    
                   
                  }
                }),
          ],
        ),
      ),
    );
  }
}
