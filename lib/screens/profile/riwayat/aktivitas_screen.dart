import 'package:flutter/material.dart';
import 'package:mynetvolve/providers/tiket_prov.dart';
import 'package:mynetvolve/widgets/loading/shimmer_list_view.dart';
import 'package:mynetvolve/widgets/profile/riwayat/aktivitas_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../widgets/profile/riwayat/aktivitas_list_view.dart';
import '../../tidak_ada_data_screen.dart';

class AktivitasScreen extends StatefulWidget {
  const AktivitasScreen({Key? key}) : super(key: key);

  @override
  State<AktivitasScreen> createState() => _AktivitasScreenState();
}

class _AktivitasScreenState extends State<AktivitasScreen> {
  @override
  Widget build(BuildContext context) {
    late final _ticketsFuture = Provider.of<TicketProvider>(
      context,
      listen: false,
    ).getTickets();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Riwayat Aktivitas',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: _ticketsFuture,
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return const ShimmerListView(shimmerTile: AktivitasShimmer());
                } else {
                  if (dataSnapshot.error != null) {
                    return const Center(
                      child: Text('an error occured'),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () {
                        return Future(() {
                          setState(() {});
                        });
                      },
                      child: Consumer<TicketProvider>(
                        builder: (ctx, ticketData, _) {
                          if (ticketData.tickets!.isEmpty) {
                            return const TidakAdaDataScreen(isCenter: false);
                          } else {
                            final ticketList = ticketData.tickets!;
                            return AktivitasListView(ticketList: ticketList);
                          }
                        },
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
