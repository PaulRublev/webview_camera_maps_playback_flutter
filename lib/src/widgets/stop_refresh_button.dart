import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class StopRefreshButton extends StatelessWidget {
  const StopRefreshButton({
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
            future: webViewController?.isLoading(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return snapshot.data!
                    ? IconButton(
                        onPressed: (() {
                          webViewController!.stopLoading();
                          callback();
                        }),
                        icon: const Icon(Icons.cancel_outlined),
                      )
                    : IconButton(
                        onPressed: (() {
                          webViewController!.reload();
                          callback();
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
