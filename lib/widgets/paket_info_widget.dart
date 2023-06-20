import 'package:flutter/material.dart';

class PaketInfoWidget extends StatelessWidget {
  const PaketInfoWidget({
    Key? key,
    required this.serviceName,
    required this.speed,
    required this.uomDesc,
    required this.shownFee,
    required this.feeSuffix,
  }) : super(key: key);

  final String serviceName;
  final String speed;
  final String uomDesc;
  final String shownFee;
  final String feeSuffix;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          smallContainer(
            icon: 'wifi-signal.png',
            title: serviceName,
            subtitle1: speed,
            subtitle2: uomDesc,
          ),
          // const VerticalDivider(color: Colors.grey),
          // smallContainer(
          //   icon: 'television.png',
          //   title: 'TV Channel',
          //   subtitle1: '0',
          //   subtitle2: 'Channel',
          // ),
          const VerticalDivider(color: Colors.grey),
          smallContainer(
            icon: 'price-tag.png',
            title: 'Harga Paket',
            subtitle1: shownFee,
            subtitle2: feeSuffix,
          ),
        ],
      ),
    );
  }

  Widget smallContainer({
    required String icon,
    required String title,
    required String subtitle1,
    required String subtitle2,
  }) {
    return Expanded(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: ImageIcon(
              AssetImage('assets/icons/$icon'),
              color: Colors.black,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                subtitle1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  // height: 0.1,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                subtitle2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
