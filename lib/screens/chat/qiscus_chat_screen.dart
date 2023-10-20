import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mynetvolve/providers/customer_profile.dart';
import 'package:mynetvolve/widgets/buttons/rounded_button.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
import 'package:provider/provider.dart' as prov;

class QiscusChatScreen extends StatefulWidget {
  const QiscusChatScreen({Key? key}) : super(key: key);

  @override
  State<QiscusChatScreen> createState() => _QiscusChatScreenState();
}

class _QiscusChatScreenState extends State<QiscusChatScreen> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Chat With Us'),
      body: QMultichannelConsumer(
        builder: (_, QMultichannel ref) {
          // void setUser() async {
          //   await ref.setUser(
          //     userId: 'guest-1001',
          //     displayName: 'guest-1001',
          //   );
          // }

          void startChat() async {
            // setState(() {
            _isLoading = true;
            // });
            await ref.initiateChat();
            setState(() {
              _isLoading = false;
            });
          }

          // setUser();
          print('===== ${ref.account.value}');
          // startChat();
          ref.initiateChat().then(
                (value) => print('===== ${value.id}'),
              );

          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container();
        },
      ),
    );
  }
}
