import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynetvolve/core/enums.dart';
import 'package:mynetvolve/models/game.dart';
import 'package:mynetvolve/providers/games_prov.dart';
import 'package:mynetvolve/widgets/loading/shimmer_list_view.dart';
import 'package:mynetvolve/widgets/paket/games/claim_game_dialog.dart';
import 'package:mynetvolve/widgets/paket/games/shimmers/claim_game_tile_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../helpers/custom_dialog.dart';
import 'claim_game_tile.dart';

class ClaimGameListView extends StatefulWidget {
  const ClaimGameListView({
    Key? key,
    required this.gameType,
  }) : super(key: key);

  final GameType gameType;

  @override
  State<ClaimGameListView> createState() => _ClaimGameListViewState();
}

class _ClaimGameListViewState extends State<ClaimGameListView> {
  void getVoucher(String gameCode) async {
    try {
      waitDialog(context);
      final voucherCode = await Provider.of<GamesProv>(
        context,
        listen: false,
      ).claimGameReward(
        customerCode: 'BNF99',
        packageCode: 'BNF0304',
        gameCode: gameCode,
      );
      Navigator.of(context).pop();
      setState(() {});
      showDialog(
        context: context,
        builder: (ctx) => ClaimGameDialog(
          voucherCode: voucherCode,
        ),
      );
    } catch (e) {
      Navigator.of(context).pop();
      showErrMsg(context, '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    late final gamesFuture = Provider.of<GamesProv>(
      context,
      listen: false,
    ).getGameRewardList(customerCode: 'BNF99', packageCode: 'BNF0304');
    return FutureBuilder(
      future: gamesFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerListView(
            shimmerTile: ClaimGameTileShimmer(),
            useDivider: false,
          );
        }
        if (dataSnapshot.hasError) {
          return Text('ERROR: ${dataSnapshot.error}');
        }
        return Consumer<GamesProv>(
          builder: (ctx, gameData, _) {
            List<GameReward> games;
            switch (widget.gameType) {
              case GameType.free:
                games = gameData.freeGames!;
                break;
              case GameType.chooseOne:
                games = gameData.chooseOneGames!;
                break;
            }

            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (ctx, i) => const SizedBox(height: 10),
              itemCount: games.length,
              itemBuilder: (ctx, i) => ClaimGameTile(
                gameName: games[i].gameName,
                info: widget.gameType == GameType.free
                    ? 'yang Anda dapatkan:'
                    : 'yang bisa Anda dapatkan:',
                imageUrl: games[i].gamePicture,
                description: games[i].gameTNC,
                isClaim: games[i].isClaim,
                onPressed: () {
                  if (!games[i].isClaim) {
                    getVoucher(games[i].gameCode);
                  } else {
                    null;
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
