import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class UrlField extends StatelessWidget {
  const UrlField({
    super.key,
    required this.callback,
    required this.editingController,
    required this.webViewController,
  });

  final Function callback;
  final TextEditingController? editingController;
  final InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 200,
      child: TextField(
        onEditingComplete: () {
          _loadUrl();
          FocusScope.of(context).unfocus();
          callback();
        },
        controller: editingController,
        style: const TextStyle(fontWeight: FontWeight.w800),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }

  void _loadUrl() {
    webViewController!.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(
          editingController!.value.text,
        ),
      ),
    );
  }
}
