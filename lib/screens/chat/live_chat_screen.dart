// import 'package:flutter/gestures.dart';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mynetvolve/core/palette.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({Key? key}) : super(key: key);

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
//   final controller = WebViewController.fromPlatformCreationParams(
//     const PlatformWebViewControllerCreationParams(),
//   );

//   final String title = 'Online Chat';
//   final String selectedUrl = '';
//   // final _controller = Completer<WebViewController>();
//   var position = 1;
//   final key = UniqueKey();

//   void _doneLoading(String A) {
//     setState(() {
//       position = 0;
//     });
//   }

//   void _startLoading(String A) {
//     setState(() {
//       position = 1;
//     });
//   }

//   @override
//   void initState() {
//     // if(Platform.isAndroid) {
//     //   controller.loadFile(absoluteFilePath)
//     // }
//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       // ..loadRequest(Uri.parse('https://google.com'));
//       ..loadRequest(Uri.parse('https://tawk.to/chat/639fceabb0d6371309d50efd/1gkk3uk92'))
//       ..setNavigationDelegate(NavigationDelegate(
//         onWebResourceError: (error) => print('===== WEBVIEW ERROR: $error'),
//         onPageFinished: _doneLoading,
//         onPageStarted: _startLoading,
//       ));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var verticalGestures = Factory<VerticalDragGestureRecognizer>(
//     //     () => VerticalDragGestureRecognizer());
//     // Set<Factory<OneSequenceGestureRecognizer>>? gestureSet =
//     //     Set.from([verticalGestures]);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Chat',
//           // style: TextStyle(fontFamily: 'Abel'),
//         ),
//       ),
//       body: SafeArea(
//         child: IndexedStack(
//           index: position,
//           children: [
//             // WebView(
//             //   initialUrl:
//             //       'https://tawk.to/chat/639fceabb0d6371309d50efd/1gkk3uk92',
//             //   onWebViewCreated: (WebViewController webViewController) {
//             //     _controller.complete(webViewController);
//             //   },
//             //   gestureRecognizers: gestureSet,
//             //   javascriptMode: JavascriptMode.unrestricted,
//             //   key: key,
//             //   onPageFinished: _doneLoading,
//             //   onPageStarted: _startLoading,
//             //   allowsInlineMediaPlayback: true,
//             // ),
//             WebViewWidget(controller: controller),
//             Container(
//               color: Colors.white,
//               child: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           ],
//         ),
//         // child: WebViewWidget(controller: controller),
//       ),
//     );
  // }
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  late PullToRefreshController pullToRefreshController;
  String url = '';
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Palette.kToDark,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
            urlRequest: URLRequest(url: await webViewController?.getUrl()),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Chat'),
      body: Stack(
        children: [
          InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(
                url: Uri.parse(
                    'https://tawk.to/chat/639fceabb0d6371309d50efd/1gkk3uk92')),
            initialOptions: options,
            pullToRefreshController: pullToRefreshController,
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
            },
            androidOnPermissionRequest:
                (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url!;

              if (![
                "http",
                "https",
                "file",
                "chrome",
                "data",
                "javascript",
                "about"
              ].contains(uri.scheme)) {
                if (await canLaunchUrl(Uri.parse(url))) {
                  // Launch the App
                  await launchUrl(Uri.parse(url));
                  // and cancel the request
                  return NavigationActionPolicy.CANCEL;
                }
              }

              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, url) async {
              pullToRefreshController.endRefreshing();
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
            },
            onLoadError: (controller, url, code, message) {
              pullToRefreshController.endRefreshing();
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                pullToRefreshController.endRefreshing();
              }
              setState(() {
                this.progress = progress / 100;
                urlController.text = this.url;
              });
            },
            onUpdateVisitedHistory: (controller, url, androidIsReload) {
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
            },
            onConsoleMessage: (controller, consoleMessage) {
              print(consoleMessage);
            },
          ),
          progress < 1
              ? const Center(child: CircularProgressIndicator(),)
              : Container(),
        ],
      ),
    );
  }
}
