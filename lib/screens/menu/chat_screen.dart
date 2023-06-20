import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:mynetvolve/core/constants.dart';
import 'package:mynetvolve/providers/customer_profile.dart';
import 'package:mynetvolve/screens/websocket_chat_screen.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:salesiq_mobilisten/salesiq_mobilisten.dart';

import '../../providers/auth.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/faq_panel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
    initMobilisten();
  }

  Future<void> initMobilisten() async {
    var custProfile =
        Provider.of<CustomerProfile>(context, listen: false).customer;
    var accountNo = custProfile!.accountNo;
    var custName = custProfile.accountName;
    var custEmail = custProfile.accountEmail;
    var custPhoneNo = custProfile.accountHp;
    var tAccountId = Provider.of<Auth>(
      context,
      listen: false,
    ).tAccountId;
    var sid = int.parse(tAccountId!) * 999;
    print('$sid');

    if (io.Platform.isIOS || io.Platform.isAndroid) {
      String appKey;
      String accessKey;
      if (io.Platform.isIOS) {
        appKey =
            // "jDKxdpOB1%2FbV3RhLFx3%2F3DQAi99X7ZlARzaFVU044NWQwVPF8x2EUNkb%2B6HwityS";
            'Ss445bXWchli3WJfhElP6vKT%2FkEIh1y9';
        accessKey =
            // "%2Brt7Xm5vDO6MMrF2k4HX9itajRurG3sgkZM5lKPMZqciq51gep3RhBhDC3OiyC%2FjbduiVepSv6PXO1ezu9CB8Cnxj95lrKZRiTCJ8AnC9hyAGCs74vNmeEpvCVujvyH4Zhoj8EhcRLlGZZycfLbb5D41m5lLFa26";
            '%2Brt7Xm5vDO6MMrF2k4HX9g0kOLp%2Bs43XHpiDMhnrHpHKwz6CIY7DDxRXLXWqcFlOzfthWZdaSzogMGW2p5traQeiVTZuhUWoKDpHOxQlLkHnR5A0B7rcTyXEW88IDNAcrzuoxSpEXusj1lhgdjLU6dn5d%2B4iVNYe';
      } else {
        appKey =
            // "jDKxdpOB1%2FbV3RhLFx3%2F3DQAi99X7ZlARzaFVU044NWQwVPF8x2EUNkb%2B6HwityS";
            'Ss445bXWchli3WJfhElP6vKT%2FkEIh1y9';
        accessKey =
            // "%2Brt7Xm5vDO6MMrF2k4HX9itajRurG3sgkZM5lKPMZqciq51gep3RhBhDC3OiyC%2Fj3x0nNkj9YMukr4whzN6uWv8tQutjRxXesmOJn6AimpZubQ8rgosMmUpvCVujvyH4Zhoj8EhcRLlGZZycfLbb5D41m5lLFa26";
            '%2Brt7Xm5vDO6MMrF2k4HX9g0kOLp%2Bs43XHpiDMhnrHpHKwz6CIY7DDxRXLXWqcFlOM0%2BZBkI2rpCLv9SZIPeV%2BZ9186%2FDAKy0r%2FRY01qt4nEFurpL2zLGoyXEW88IDNAcrzuoxSpEXusj1lhgdjLU6dn5d%2B4iVNYe';
      }
      ZohoSalesIQ.init(appKey, accessKey).then((_) {
        ZohoSalesIQ.setLanguage('in');
        // ZohoSalesIQ.setChatActionTimeout(20);
        ZohoSalesIQ.enableInAppNotification();
        ZohoSalesIQ.setVisitorName('$custName - $accountNo');
        ZohoSalesIQ.setVisitorEmail(custEmail);
        ZohoSalesIQ.setVisitorContactNumber(custPhoneNo);
        ZohoSalesIQ.setVisitorAddInfo('sid', '$sid');
        ZohoSalesIQ.setVisitorAddInfo('account_no', accountNo);
        ZohoSalesIQ.setVisitorAddInfo('account_name', custName);
      }).catchError((error) {
        return;
      });
    }
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final custData = Provider.of<CustomerProfile>(context, listen: false)
        .customer!
        .accountNo;
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
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        height: 60,
        child: Tooltip(
          message: ToolTipString.MULAI_CHAT,
          verticalOffset: 35,
          preferBelow: false,
          child: RoundedButton(
            onPressed: custData == '' ? null : () => ZohoSalesIQ.show(),
            // onPressed: () => Navigator.of(context).push(
            //   MaterialPageRoute(builder: (_) => const WebsocketChatScreen()),
            // ),
            text: 'Mulai Chat!',
            useSide: true,
            useShadow: false,
          ),
        ),
      ),
    );
  }
}
