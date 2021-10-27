import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatelessWidget {
  final String title;
  final String selectedUrl;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  MyWebView({
    Key? key,
    required this.title,
    required this.selectedUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                    child: TextButton(
                  child: const Text('Abrir no browser'),
                  onPressed: () async {
                    await launch(selectedUrl);
                  },
                ))
              ],
            ),
          ],
        ),
        body: WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
