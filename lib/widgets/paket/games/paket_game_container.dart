import 'package:flutter/material.dart';
import 'package:mynetvolve/screens/paket/games/claim_reward_screen.dart';
import 'package:mynetvolve/screens/paket/games/pilih_game_screen.dart';

import '../../../core/constants.dart';
import '../../buttons/gradient_button.dart';
import 'games_horizontal_list_view.dart';

class PaketGameContainer extends StatelessWidget {
  const PaketGameContainer({
    Key? key,
    required this.paketName,
    required this.price,
  }) : super(key: key);

  final String paketName;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paketName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${FORMAT_CURRENCY.format(price)}/bln',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 130,
                    child: GradientButton(
                      height: 40,
                      buttonHandle: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          // builder: (_) => PilihGameScreen(
                          //   name: paketName,
                          //   price: price,
                          // ),
                          builder: (_) => const ClaimRewardScreen(),
                        ),
                      ),
                      text: 'Pilih Paket',
                      useElevation: false,
                      useBorder: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose One',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 5),
              const GamesHorizontalListView(itemCount: 8),
              const SizedBox(height: 8),
              const Text(
                'Get Free',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 5),
              const GamesHorizontalListView(itemCount: 2),
            ],
          ),
        ),
      ],
    );
  }
}
