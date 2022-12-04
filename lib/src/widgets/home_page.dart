import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
          _makeBar(),
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

  void _loadUrl() {
    _webViewController!.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(
          _editingController.value.text,
        ),
      ),
    );
  }

  Widget _makeBar() {
    return Container(
      height: 115,
      padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          makeGoBackButton(),
          makeGoForwardButton(),
          makeStopRefreshButton(),
          makeUrlField(),
        ],
      ),
    );
  }

  Widget makeUrlField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 200,
      child: TextField(
        onEditingComplete: () {
          _loadUrl();
          setState(() {
            FocusScope.of(context).unfocus();
          });
        },
        controller: _editingController,
        style: const TextStyle(fontWeight: FontWeight.w800),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget makeGoBackButton() {
    return _webViewController != null
        ? FutureBuilder(
            future: _webViewController?.canGoBack(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return snapshot.data!
                    ? IconButton(
                        onPressed: (() {
                          _webViewController!.goBack();
                          setState(() {});
                        }),
                        icon: const Icon(Icons.arrow_back),
                      )
                    : const Icon(
                        Icons.arrow_back,
                        color: Colors.grey,
                      );
              }
              return const Icon(
                Icons.arrow_back,
                color: Colors.grey,
              );
            })
        : const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          );
  }

  Widget makeGoForwardButton() {
    return _webViewController != null
        ? FutureBuilder(
            future: _webViewController?.canGoForward(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return snapshot.data!
                    ? IconButton(
                        onPressed: (() {
                          _webViewController!.goForward();
                          setState(() {});
                        }),
                        icon: const Icon(Icons.arrow_forward),
                      )
                    : const Icon(
                        Icons.arrow_forward,
                        color: Colors.grey,
                      );
              }
              return const Icon(
                Icons.arrow_forward,
                color: Colors.grey,
              );
            })
        : const Icon(
            Icons.arrow_forward,
            color: Colors.grey,
          );
  }

  Widget makeStopRefreshButton() {
    return _webViewController != null
        ? FutureBuilder(
            future: _webViewController?.isLoading(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return snapshot.data!
                    ? IconButton(
                        onPressed: (() {
                          _webViewController!.stopLoading();
                          setState(() {});
                        }),
                        icon: const Icon(Icons.cancel_outlined),
                      )
                    : IconButton(
                        onPressed: (() {
                          _webViewController!.reload();
                          setState(() {});
                        }),
                        icon: const Icon(Icons.refresh),
                      );
              }
              return const Icon(
                Icons.refresh,
                color: Colors.grey,
              );
            })
        : const Icon(
            Icons.refresh,
            color: Colors.grey,
          );
  }
}
