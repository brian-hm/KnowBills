import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewNota extends StatelessWidget {
  final String url;
  WebViewNota({this.url});

  @override
  Widget build(BuildContext context) {
    return url.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              title: Text('NFe'),
            ),
            body: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
            ))
        : Container(
            child: Center(
              child: Text("Não foi possível acessar a página"),
            ),
          );
  }
}

//Navigator.push(context,MaterialPageRoute(builder: (context) => WebViewNota(url: result.code)))
