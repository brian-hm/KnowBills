import 'package:appTCC/screens/home/updateItemFrom.dart';
import 'package:flutter/material.dart';
import 'package:appTCC/models/item.dart';
import 'package:appTCC/shared/constants.dart';

//template para exibir item

class ItemTile extends StatelessWidget {
  final Item item;
  ItemTile({this.item});

  @override
  Widget build(BuildContext context) {
    void _showUpdatePanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return UpdateItemForm(item: item);
          });
    }

    return Column(
      children: [
        OutlineButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0)),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.descricao,
                      style: TextStyle(color: kMainColor, fontSize: 20),
                    ),
                    Text(
                      "R\$ " + item.valor.toString(),
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Text(
                  item.categoria,
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
          ),
          onPressed: () => _showUpdatePanel(),
        ),
        SizedBox(height: 15)
      ],
    );
  }
}
