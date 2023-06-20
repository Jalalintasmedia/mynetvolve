import 'package:flutter/material.dart';
import 'package:mynetvolve/helpers/call_cs.dart';

class CallCSButton extends StatelessWidget {
  const CallCSButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          'Kontak Kami',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
        SizedBox(height: 5),
        FloatingActionButton(
          heroTag: 'CSButton',
          onPressed: callCS,
          child: ImageIcon(
            AssetImage('assets/icons/customer-service.png'),
          ),
        ),
      ],
    );
  }
}
