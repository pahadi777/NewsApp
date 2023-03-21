import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/views/home.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String url;

  ArticleView({required this.url});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: CategoryArticleWebView(
        url: widget.url,
      ),
    );
  }
}

class CategoryArticleWebView extends StatefulWidget {
  bool isLoading = true;
  String url;

  CategoryArticleWebView({required this.url});

  @override
  State<CategoryArticleWebView> createState() => _CategoryArticleWebViewState();
}

class _CategoryArticleWebViewState extends State<CategoryArticleWebView> {
  late WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController();
    controller
      ..loadRequest(
        Uri.parse(widget.url),
      )
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (finish) {
        setState(() {
          widget.isLoading = false;
        });
      }))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Center(
            child: Container(
              // color: Colors.black12,
              child: CircularProgressIndicator(),
            ),
          )
        : WebViewWidget(
            controller: controller,
          );
  }
}
