import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String feed_link;
  WebViewExample( this.feed_link);
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.feed_link.toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
