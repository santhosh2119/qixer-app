import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MidtransPaymentWebviewPage extends StatefulWidget {
  const MidtransPaymentWebviewPage({Key? key, required this.redirectUrl})
      : super(key: key);

  final redirectUrl;

  @override
  _MidtransPaymentWebviewPageState createState() =>
      _MidtransPaymentWebviewPageState();
}

class _MidtransPaymentWebviewPageState
    extends State<MidtransPaymentWebviewPage> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text("Midtrans"),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: IconButton(
                      onPressed: () async {
                        controller.reload();
                      },
                      icon: const Icon(Icons.refresh)),
                )
              ]),
          body: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.redirectUrl,
            onWebViewCreated: (controller) {
              this.controller = controller;
            },
          ),
        ),
      ),
    );
  }
}
