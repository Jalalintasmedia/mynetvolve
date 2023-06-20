import 'package:flutter/material.dart';
import 'package:mynetvolve/helpers/copy_text.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';

class BantuanDanKontakScreen extends StatelessWidget {
  const BantuanDanKontakScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Bantuan dan Kontak'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                kontakListTile(
                  'Email',
                  'cs@bnetfit.id',
                  Icons.email_outlined,
                ),
                const Divider(color: Colors.grey),
                kontakListTile(
                  'Call Center',
                  '021 5091 9981',
                  Icons.phone_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile kontakListTile(String title, String subtitle, IconData icon) {
    return ListTile(
      onTap: () => copyText(copiedData: subtitle, copyType: title),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      leading: Icon(icon),
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0.0,
        vertical: 0.0,
      ),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
    );
  }
}
