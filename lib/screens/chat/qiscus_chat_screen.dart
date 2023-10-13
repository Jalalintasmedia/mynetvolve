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
  @override
  Widget build(BuildContext context) {
    return QMultichannelProvider(
      appId: 'xjdmu-wt7turq3zovo16e',
      builder: (ctx) => Scaffold(
        appBar: const GradientAppBar(title: 'Chat With Us'),
        body: QMultichannelConsumer(
          builder: (ctx, ref) {
            return Column(
              children: [
                RoundedButton(
                  onPressed: () {
                    final cust =
                        prov.Provider.of<CustomerProfile>(ctx, listen: false)
                            .customer!;
                    var username = cust.accountName;
                    var displayName = '${cust.accountName} - ${cust.accountNo}';

                    ref.setUser(userId: username, displayName: displayName);
                    print(
                        '===== ${ref.account.hasValue}');
                  },
                  text: 'Login',
                  useSide: false,
                  useShadow: false,
                ),
                if (ref.account.hasValue) Text(ref.account.value!.name),
              ],
            );
          },
        ),
      ),
    );
  }
}
