import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/palette.dart';
import '../../providers/customer_profile.dart';

class FingerprintSwitch extends StatelessWidget {
  const FingerprintSwitch({
    Key? key,
    required this.pengaturanList,
  }) : super(key: key);

  final List<Map<String, dynamic>> pengaturanList;

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProfile>(
      builder: (ctx, custData, _) {
        // var custFingerprintActive = custData.custFingerprintActive;
        // print('customer.activateFingerprint: $custFingerprintActive');
        return SwitchListTile(
          contentPadding: const EdgeInsets.all(0),
          activeColor: Palette.kToDark,
          title: Row(
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: ImageIcon(
                  AssetImage(
                      'assets/icons/${pengaturanList[pengaturanList.length - 1]['icon']}'),
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                pengaturanList[pengaturanList.length - 1]['title'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          value: custData.customer!.activateFingerprint,
          onChanged: (newValue) async {
            try {
              // print(custData.customer!.activateFingerprint);
              await custData.setFingerprintBool(newValue);
            } catch (e) {
              return;
            }
          },
        );
      },
    );
  }
}
