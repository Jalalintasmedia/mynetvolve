import 'package:flutter/material.dart';

import 'fingerprint_switch.dart';

class PengaturanListPanel extends StatelessWidget {
  const PengaturanListPanel({
    Key? key,
    required this.judulSection,
    required this.pengaturanList,
    required this.context,
  }) : super(key: key);

  final String judulSection;
  final List<Map<String, dynamic>> pengaturanList;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 10,
          minWidth: double.infinity,
          maxHeight: double.infinity,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(5, 5),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  judulSection,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // const SizedBox(height: 15),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: pengaturanList.length,
                  itemBuilder: (ctx, i) {
                    if (pengaturanList[i]['title'] == 'Login Biometrik') {
                      return FingerprintSwitch(pengaturanList: pengaturanList);
                    }
                    return pengaturanListTile(
                      onTap: pengaturanList[i]['onTap'],
                      icon: pengaturanList[i]['icon'],
                      title: pengaturanList[i]['title'],
                    );
                  },
                ),
                // FingerprintSwitch(pengaturanList: pengaturanList),
                const Divider(
                  color: Colors.grey,
                  height: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pengaturanListTile({
    required VoidCallback onTap,
    required String icon,
    required String title,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.all(0),
          minLeadingWidth: 10,
          leading: FittedBox(
            fit: BoxFit.cover,
            child: ImageIcon(
              AssetImage('assets/icons/$icon'),
              color: Colors.black,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.black),
        ),
        const Divider(
          color: Colors.grey,
          height: 0,
        ),
      ],
    );
  }
}
