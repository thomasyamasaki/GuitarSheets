import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final url;

  WebViewPage({Key key, @required this.url}) : super(key: key);

  @override 
  _WebViewState createState() => _WebViewState(url);
}

class _WebViewState extends State<WebViewPage> {
  var _url;
  final _key = UniqueKey();

  _WebViewState(String url) {
    this._url = url;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Column(
        children: [
          Expanded( 
            child: WebView( 
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: _url,
            )
          )
        ]
      ),
    );
  }
}