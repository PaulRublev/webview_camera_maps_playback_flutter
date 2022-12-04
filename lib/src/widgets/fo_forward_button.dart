import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GoForwardButton extends StatelessWidget {
  const GoForwardButton({
    super.key,
    required this.callback,
    required this.webViewController,
  });

  final Function callback;
  final InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return webViewController != null
        ? FutureBuilder(
            future: webViewController?.canGoForward(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return snapshot.data!
                    ? IconButton(
                        onPressed: (() {
                          webViewController!.goForward();
                          callback();
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
}
