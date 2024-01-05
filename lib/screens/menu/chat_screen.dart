// import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynetvolve/core/constants.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';

// import '../../providers/auth.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/faq_panel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _isLoading = false;
  static const oneTalkLiveChatMethodChannel =
      MethodChannel('io.taptalk.onetalklivechat');

  Future<void> _openOneTalkLiveChatUI() async {
    try {
      final bool isOneTalkInitialized = await oneTalkLiveChatMethodChannel
          .invokeMethod('initOneTalkLiveChat');
      if (isOneTalkInitialized) {
        await oneTalkLiveChatMethodChannel.invokeMethod('openLiveChatView');
      }
    } on PlatformException catch (e) {
      print('===== ERROR: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Chat'),
      body: const Padding(
        padding: EdgeInsets.only(
          right: 16,
          left: 16,
          top: 16,
          bottom: 16 + 60 + 15,
        ),
        child: FaqPanel(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _isLoading
          ? const CircularProgressIndicator()
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              height: 60,
              child: Tooltip(
                message: ToolTipString.MULAI_CHAT,
                verticalOffset: 35,
                preferBelow: false,
                child: RoundedButton(
                  // onPressed: () async {
                  //   final cust = prov.Provider.of<CustomerProfile>(
                  //     context,
                  //     listen: false,
                  //   ).customer!;
                  //   ref.setUser(
                  //     userId: cust.accountNo,
                  //     displayName: '${cust.accountName} - ${cust.accountNo}',
                  //   );
                  //   try {
                  //     ref.initiateChat().then(
                  //       (room) {
                  //         print('===== INITIATE CHAT SUCCESS: ${room.id}');
                  //       },
                  //       onError: (err) {
                  //         print('===== INITIATE CHAT ERROR: $err');
                  //       },
                  //     );
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context) =>
                  //             QChatRoomScreen(onBack: (ctx) {
                  //           print('on do back!');
                  //           ref.clearUser();
                  //           Navigator.of(context)
                  //               .maybePop()
                  //               .then((r) => debugPrint('maybePop: $r'));
                  //         }),
                  //       ),
                  //     );
                  //   } catch (e) {
                  //     print('===== ERROR: $e');
                  //   }
                  // },
                  // onPressed: () {
                  //   final qiscus = qscs.QiscusSDK();
                  //   final cust = Provider.of<CustomerProfile>(
                  //     context,
                  //     listen: false,
                  //   ).customer!;

                  //   qiscus.chatUser(userId: cust.accountNo).then((chatroom) {
                  //     print('===== SUCCESS $chatroom');
                  //   });
                  // },
                  // onPressed: () => Navigator.of(context)
                  //     .pushNamed(RouteNames.LIVE_CHAT_ROUTE),
                  onPressed: _openOneTalkLiveChatUI,
                  text: 'Mulai Chat!',
                  useSide: true,
                  useShadow: false,
                ),
              ),
            ),
    );
  }
}
