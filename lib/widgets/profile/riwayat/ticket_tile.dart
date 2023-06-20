import 'package:flutter/material.dart';

class TicketTile extends StatelessWidget {
  const TicketTile({
    Key? key,
    required this.ticketNo,
    required this.requestType,
    required this.status,
  }) : super(key: key);

  final String ticketNo;
  final String requestType;
  final String status;

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.grey;
    switch (status) {
      case ('OPENED'):
        statusColor = Colors.red.shade800;
        break;
      case ('CLOSED'):
        statusColor = Colors.green;
        break;
      default:
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Request Type: $requestType',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(ticketNo),
        const SizedBox(height: 8),
        Text(
          'Tiket $status',
          style: TextStyle(
            color: statusColor,
            fontSize: 12,
          ),
        ),
        // const Divider(color: Colors.grey, height: 20),
      ],
    );
  }
}
