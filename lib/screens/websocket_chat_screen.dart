import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../widgets/chat/chat_bubble.dart';
import '../../widgets/chat/chat_input_widget.dart';
import '../../widgets/gradient_app_bar.dart';

class WebsocketChatScreen extends StatefulWidget {
  const WebsocketChatScreen({Key? key}) : super(key: key);

  @override
  State<WebsocketChatScreen> createState() => _WebsocketChatScreenState();
}

class _WebsocketChatScreenState extends State<WebsocketChatScreen> {
  final channel = WebSocketChannel.connect(
    Uri.parse(
      // 'wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self',
      // 'wss://socketsbay.com/wss/v2/1/demo/abcd123',
      'wss://echo.websocket.events',
    ),
  );
  final chatList = [];
  var _isLoading = false;

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void sendMessage(String message) {
    // messageController.clear();
    print('===== $message');
    channel.sink.add(message);
    // showSuccessMsg(context, 'Sent!');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const GradientAppBar(title: 'Chat'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: StreamBuilder(
              stream: channel.stream,
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (dataSnapshot.hasError) {
                  return Text(
                    'ERROR: ${dataSnapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  );
                }
                // return Text(dataSnapshot.hasData ? '${dataSnapshot.data}' : '');
                chatList.add(dataSnapshot.data);
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (ctx, i) => const SizedBox(
                          height: 8,
                        ),
                        itemCount: chatList.length,
                        itemBuilder: (ctx, i) => Padding(
                          padding: EdgeInsets.only(
                            top: i == 0 ? 8 : 0,
                            bottom: i == chatList.length - 1 ? 8 : 0,
                          ),
                          child: ChatBubble(message: chatList[i]),
                        ),
                      ),
                      // child: Container(
                      //   width: double.infinity,
                      //   padding: const EdgeInsets.only(right: 50),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: const [
                      //       ChatBubble(message: 'asdfkjadbfjhkasbfhasbdhfbasdkfsd fbdskfbaskdfbksd fshdfksd fshdfk asdk'),
                      //       ChatBubble(message: 'HIIIII'),
                      //       ChatBubble(message: '1\n2\n3\n4\n5\n6\n7\n8\n9\n10'),
                      //     ],
                      //   ),
                      // ),
                    ),
                    ChatInputWidget(
                      // messageController: messageController,
                      isLoading: _isLoading,
                      sendMessage: sendMessage,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
