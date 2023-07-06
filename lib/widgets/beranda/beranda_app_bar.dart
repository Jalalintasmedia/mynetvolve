import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mynetvolve/helpers/copy_text.dart';
import 'package:mynetvolve/providers/customer_profile.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../helpers/save_image.dart';

class BerandaAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BerandaAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  State<BerandaAppBar> createState() => _BerandaAppBarState();
}

class _BerandaAppBarState extends State<BerandaAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProfile>(builder: (ctx, custData, _) {
      final customer = custData.customer!;
      Uint8List? image;

      if (customer.profileFileId != '') {
        image = convertBase64(customer.pictContent);
      }
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage: customer.profileFileId == ''
                        ? const AssetImage(
                            'assets/images/photo_placeholder.jpg')
                        : MemoryImage(image!) as ImageProvider,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, ${customer.accountName}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: [
                          Text(
                            customer.accountNo,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            onPressed: () =>
                                copyText(copiedData: customer.accountNo),
                            icon: const ImageIcon(
                              AssetImage('assets/icons/copy.png'),
                              color: Colors.white,
                              size: 14,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouteNames.PEMBERITAHUAN_ROUTE);
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
