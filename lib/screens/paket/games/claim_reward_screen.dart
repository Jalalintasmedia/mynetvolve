import 'package:flutter/material.dart';
import 'package:mynetvolve/core/enums.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:mynetvolve/widgets/paket/games/game_banner_container.dart';

import '../../../widgets/paket/games/claim_game_list_view.dart';

class ClaimRewardScreen extends StatelessWidget {
  const ClaimRewardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Claim Reward'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 10),
              GameBannerContainer(),
              SizedBox(height: 15),
              Text(
                'Claim Games',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              ClaimGameListView(gameType: GameType.free),
              SizedBox(height: 15),
              Text(
                'Choose One',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              ClaimGameListView(gameType: GameType.chooseOne),
            ],
          ),
        ),
      ),
    );
  }
}

