import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../core/constants.dart';

class StatusKoneksiContainer extends StatelessWidget {
  const StatusKoneksiContainer({
    Key? key,
    required this.deviceState,
    // required this.refreshIcon,
    required this.showcaseKey,
    required this.refreshNetworkInfo,
  }) : super(key: key);

  final String deviceState;
  // final Widget refreshIcon;
  final GlobalKey<State<StatefulWidget>> showcaseKey;
  final VoidCallback refreshNetworkInfo;

  @override
  Widget build(BuildContext context) {
    // var status = '';
    // switch (deviceState) {
    //   case '...':
    //     status = '';
    //     break;
    //   case 'WORKING':
    //     status = 'CONNECTED';
    //     break;
    //   default:
    //     status = deviceState;
    // }

    var icon = 'unplug';
    switch (deviceState) {
      // case '...':
      //   icon = '';
      //   break;
      case 'WORKING':
        icon = 'plug';
        break;
      case 'ACTIVE':
        icon = 'plug';
        break;
      case 'CONNECTED':
        icon = 'plug';
        break;
      case 'DISCONNECTED':
        icon = 'unplug';
        break;
      default:
        icon = 'unplug';
    }

    Color color = Colors.grey;
    switch (deviceState) {
      case ('WORKING'):
        color = const Color.fromRGBO(71, 155, 5, 1);
        break;
      case ('ACTIVE'):
        color = const Color.fromRGBO(71, 155, 5, 1);
        break;
      case ('CONNECTED'):
        color = const Color.fromRGBO(71, 155, 5, 1);
        break;
      case ('...'):
        color = Colors.grey;
        break;
      default:
        color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(5, 5),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: ImageIcon(
                  AssetImage('assets/icons/$icon.png'),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                'Status',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Showcase(
            key: showcaseKey,
            description: ToolTipString.REFRESH_NETWORK_STATUS,
            child: deviceState == '...'
                ? const SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    children: [
                      Text(
                        deviceState,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      IconButton(
                        tooltip: ToolTipString.REFRESH_NETWORK_STATUS,
                        onPressed: refreshNetworkInfo,
                        padding: const EdgeInsets.all(0),
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
