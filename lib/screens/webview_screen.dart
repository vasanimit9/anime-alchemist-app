import 'dart:io';
import 'package:flutter/material.dart';
import 'package:anime_alchemist/constants.dart';
import 'package:webview_flutter/webview_flutter.dart' as webview;

class WebViewScreen extends StatelessWidget {
  static const route = '/webview';

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      webview.WebView.platform = webview.SurfaceAndroidWebView();
    }
    final WebViewArgs args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.provider,
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: webview.WebView(
          initialUrl: args.url,
          javascriptMode: webview.JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }
}
