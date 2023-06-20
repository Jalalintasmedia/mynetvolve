import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:provider/provider.dart';

import '../helpers/string_formatter.dart';
import '../models/notification.dart';
import '../providers/notification_prov.dart';
import 'tidak_ada_data_screen.dart';

class PemberitahuanScreen extends StatefulWidget {
  const PemberitahuanScreen({Key? key}) : super(key: key);

  @override
  State<PemberitahuanScreen> createState() => _PemberitahuanScreenState();
}

class _PemberitahuanScreenState extends State<PemberitahuanScreen> {
  late final _notifFuture =
      Provider.of<NotificationProv>(context, listen: false).getNotifications();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Pemberitahuan',
      ),
      body: FutureBuilder(
        future: _notifFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return const Center(
                child: Text('an error has occured'),
              );
            } else {
              return Consumer<NotificationProv>(
                builder: (ctx, notifData, _) {
                  if (notifData.notifications == [] ||
                      notifData.notifications!.isEmpty) {
                    return const TidakAdaDataScreen();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            // offset: Offset(5, 5),
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: notifListView(notifData),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

  ListView notifListView(NotificationProv notifData) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notifData.notifications!.length,
      itemBuilder: (ctx, i) {
        var notif = notifData.notifications![i];
        var requestDate = notif.requestDate;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // warningIcon(),
            // const SizedBox(width: 20),
            expandableContent(notif, DateTime.parse(requestDate)),
          ],
        );
      },
    );
  }

  Padding warningIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ImageIcon(
        const AssetImage('assets/icons/warning.png'),
        color: Colors.red.shade900,
        size: 18,
      ),
    );
  }

  Expanded expandableContent(
    CustNotification notif,
    DateTime date,
  ) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 8),
          ExpandablePanel(
            theme: const ExpandableThemeData(
              tapBodyToCollapse: true,
              tapBodyToExpand: true,
              tapHeaderToExpand: true,
              hasIcon: false,
            ),
            header: expandableHeader(notif, date),
            collapsed: ExpandableButton(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  parseHtmlString(notif.content),
                  overflow: TextOverflow.ellipsis,
                  // maxLines: 3,
                ),
              ),
            ),
            expanded: ExpandableButton(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  parseHtmlString(notif.content),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }

  Row expandableHeader(CustNotification notif, DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            notif.subject,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                getDate(date),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              Text(
                DateFormat('HH:mm').format(date),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
