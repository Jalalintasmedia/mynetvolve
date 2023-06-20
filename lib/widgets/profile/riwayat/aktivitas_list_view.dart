import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:mynetvolve/widgets/profile/riwayat/ticket_tile.dart';

import '../../../core/palette.dart';
import '../../../models/tiket.dart';

class AktivitasListView extends StatelessWidget {
  const AktivitasListView({
    Key? key,
    required this.ticketList,
  }) : super(key: key);

  final List<Tiket> ticketList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.grey, height: 20),
      itemCount: ticketList.length,
      itemBuilder: (ctx, i) {
        final closeDate = ticketList[i].closeDate;
        return Theme(
          data: ThemeData().copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            // expandedCrossAxisAlignment: CrossAxisAlignment.end,
            title: TicketTile(
              ticketNo: ticketList[i].ticketNo,
              requestType: ticketList[i].requestTypeDesc,
              status: ticketList[i].statusDesc,
            ),
            tilePadding: EdgeInsets.zero,
            textColor: Colors.black,
            children: [
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    aktivitasProgressRow(
                      Palette.kToDark,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Ticket Open'),
                          Text(
                            '${ticketList[i].startDate} ${ticketList[i].startTime}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: DottedLine(
                        direction: Axis.vertical,
                        lineLength: 30,
                      ),
                    ),
                    const SizedBox(height: 2),
                    aktivitasProgressRow(
                      ThemeColors.accentColor,
                      const Text('On Progress'),
                    ),
                    const SizedBox(height: 2),
                    if (closeDate.isNotEmpty || closeDate != '')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: DottedLine(
                              direction: Axis.vertical,
                              lineLength: 30,
                            ),
                          ),
                          aktivitasProgressRow(
                            Palette.kToDark,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Ticket Close'),
                                Text(
                                  closeDate,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget aktivitasProgressRow(Color color, Widget child) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 8,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
