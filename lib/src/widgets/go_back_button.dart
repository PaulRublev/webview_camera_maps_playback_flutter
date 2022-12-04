import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({
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
            future: webViewController?.canGoBack(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return snapshot.data!
                    ? IconButton(
                        onPressed: (() {
                          webViewController!.goBack();
                          callback();
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
}
