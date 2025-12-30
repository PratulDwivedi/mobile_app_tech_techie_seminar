import '../models/screen_args_model.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/common_gradient_header_widget.dart';

class WebViewScreen extends StatefulWidget {
  final ScreenArgsModel args;

  const WebViewScreen({required this.args, super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final WebViewController _controller = WebViewController();
  bool isMapVisible = false;

  @override
  void initState() {
    super.initState();

    String webUrl = widget.args.data['webUrl'];

    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.loadRequest(Uri.parse(webUrl));
    Future.delayed(
      const Duration(milliseconds: 100),
      () => setState(() {
        isMapVisible = true;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(
            title: widget.args.name,
          ),

          // WebView Content
          Expanded(
            child: AnimatedOpacity(
              curve: Curves.fastOutSlowIn,
              opacity: isMapVisible ? 1.0 : 0,
              duration: const Duration(milliseconds: 400),
              child: WebViewWidget(controller: _controller),
            ),
          ),
        ],
      ),
    );
  }
}
