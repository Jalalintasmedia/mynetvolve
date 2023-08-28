// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({Key? key}) : super(key: key);

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final String title = 'Online Chat';
  final String selectedUrl = '';
  // final _controller = Completer<WebViewController>();
  var position = 1;
  final key = UniqueKey();

  void _doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  void _startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var verticalGestures = Factory<VerticalDragGestureRecognizer>(
    //     () => VerticalDragGestureRecognizer());
    // Set<Factory<OneSequenceGestureRecognizer>>? gestureSet =
    //     Set.from([verticalGestures]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          // style: TextStyle(fontFamily: 'Abel'),
        ),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: position,
          children: [
            // WebView(
            //   initialUrl:
            //       'https://tawk.to/chat/639fceabb0d6371309d50efd/1gkk3uk92',
            //   onWebViewCreated: (WebViewController webViewController) {
            //     _controller.complete(webViewController);
            //   },
            //   gestureRecognizers: gestureSet,
            //   javascriptMode: JavascriptMode.unrestricted,
            //   key: key,
            //   onPageFinished: _doneLoading,
            //   onPageStarted: _startLoading,
            //   allowsInlineMediaPlayback: true,
            // ),
            Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
