import 'package:employee/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  WebViewScreen({Key? key, required this.title, required this.url}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.title}"),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            WebView(
              initialUrl: widget.url,
              zoomEnabled: true,
              onPageFinished: (url) {
                isLoading = false;
                setState(() {});
              },
              gestureNavigationEnabled: true,
            ),
            isLoading
                ? Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: ColorPrimary,
                    ))
                : SizedBox(
                    width: 0,
                    height: 0,
                  )
          ],
        ),
      ),
    );
  }
}
