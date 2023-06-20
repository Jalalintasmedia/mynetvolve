import 'package:flutter/material.dart';
import 'package:mynetvolve/helpers/custom_dialog.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketChatScreen extends StatefulWidget {
  const WebsocketChatScreen({Key? key}) : super(key: key);

  @override
  State<WebsocketChatScreen> createState() => _WebsocketChatScreenState();
}

class _WebsocketChatScreenState extends State<WebsocketChatScreen> {
  final channel = WebSocketChannel.connect(Uri.parse(
    // 'wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self',
    'wss://socketsbay.com/wss/v2/1/demo/abcd123'
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Chat'),
      body: StreamBuilder(
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
          return Text(dataSnapshot.hasData ? '${dataSnapshot.data}' : '');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          channel.sink.add('From app!');
          showSuccessMsg(context, 'Sent!');
        },
      ),
    );
  }
}
