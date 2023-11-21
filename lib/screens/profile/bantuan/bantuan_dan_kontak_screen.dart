import 'package:flutter/material.dart';
import 'package:mynetvolve/helpers/copy_text.dart';
import 'package:mynetvolve/helpers/link_director.dart';
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
                  'admin.netvolve@jlm.net.id',
                  Icons.email_outlined,
                  () => emailWithMailApp('admin.netvolve@jlm.net.id'),
                ),
                const Divider(color: Colors.grey),
                kontakListTile(
                  'Call Center',
                  '021-5091-9980',
                  Icons.phone_outlined,
                  () => callNumber('02150919980'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile kontakListTile(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      leading: Icon(icon),
      trailing: IconButton(
        icon: const Icon(Icons.copy, size: 18),
        onPressed: () => copyText(copiedData: subtitle, copyType: title),
      ),
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0.0,
        vertical: 0.0,
      ),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
    );
  }
}
