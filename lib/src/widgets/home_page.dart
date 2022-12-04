import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'fo_forward_button.dart';
import 'go_back_button.dart';
import 'stop_refresh_button.dart';
import 'url_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InAppWebViewController? _webViewController;
  final TextEditingController _editingController =
      TextEditingController(text: _initialUri);
  static const String _initialUri = 'https://github.com/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 115,
            padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GoBackButton(
                  callback: _refreshState,
                  webViewController: _webViewController,
                ),
                GoForwardButton(
                  callback: _refreshState,
                  webViewController: _webViewController,
                ),
                StopRefreshButton(
                  callback: _refreshState,
                  webViewController: _webViewController,
                ),
                UrlField(
                  callback: _refreshState,
                  webViewController: _webViewController,
                  editingController: _editingController,
                ),
              ],
            ),
          ),
          Expanded(
            child: InAppWebView(
              onLoadStart: (controller, url) {
                setState(() {});
              },
              onLoadStop: (controller, url) {
                setState(() {});
              },
              onWebViewCreated: (controller) {
                _webViewController = controller;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  void _refreshState() {
    setState(() {});
  }
}
