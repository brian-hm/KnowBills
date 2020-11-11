import 'package:flutter/material.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Column(
        children: [
          Center(
            child: Image(image: AssetImage('lib/images/Total.png')),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Adicionar Categoria',
                  )),
            ],
          ),
          FlatButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categoria 1:",
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    "0%",
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    "0.00",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              )),
          FlatButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categoria 2:",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text(
                    "0%",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text(
                    "0.00",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              )),
          FlatButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categoria 3:",
                    style: TextStyle(color: Colors.green),
                  ),
                  Text(
                    "0%",
                    style: TextStyle(color: Colors.green),
                  ),
                  Text(
                    "0.00",
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
