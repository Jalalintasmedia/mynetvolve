import 'package:flutter/material.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:mynetvolve/widgets/paket/paket_card_button.dart';

class AddonsScreen extends StatelessWidget {
  const AddonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Addons'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              gameSection(),
              const SizedBox(height: 8),
              const Divider(color: Colors.grey),
              const SizedBox(height: 8),
              iptvSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget gameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bnetfit Gamers',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/images/bnetfit-game-banner.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        PaketCardButton(
          text1: 'Ultimate Package',
          color: const Color.fromRGBO(220, 166, 77, 1),
          icon: Icons.download_for_offline_outlined,
          onTap: () {},
        ),
        const SizedBox(height: 8),
        PaketCardButton(
          text1: 'Lite Package',
          color: const Color.fromRGBO(205, 197, 184, 1),
          icon: Icons.download_for_offline_outlined,
          onTap: () {},
        ),
      ],
    );
  }

  Widget iptvSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'IPTV',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/images/bnetfit-game-banner.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        PaketCardButton(
          text1: 'IPTV',
          color: const Color.fromRGBO(224, 224, 224, 1),
          icon: Icons.download_for_offline_outlined,
          onTap: () {},
        ),
      ],
    );
  }
}
