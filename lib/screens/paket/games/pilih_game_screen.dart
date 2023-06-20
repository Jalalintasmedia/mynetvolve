import 'package:flutter/material.dart';
import 'package:mynetvolve/helpers/custom_modal_bottom_sheet.dart';
import 'package:mynetvolve/widgets/buttons/rounded_button.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:mynetvolve/widgets/gradient_widget.dart';

import '../../../core/constants.dart';
import '../../../widgets/paket/games/game_banner_container.dart';
import '../../../widgets/paket/games/game_detail_tile.dart';
import '../../../widgets/paket/games/syarat_dan_ketentuan_game.dart';

class PilihGameScreen extends StatefulWidget {
  const PilihGameScreen({
    Key? key,
    required this.name,
    required this.price,
  }) : super(key: key);

  final String name;
  final int price;

  @override
  State<PilihGameScreen> createState() => _PilihGameScreenState();
}

class _PilihGameScreenState extends State<PilihGameScreen> {
  int? _gameIndex = -1;

  void _selectGame(int i) {
    setState(() {
      _gameIndex = i;
      print('===== SELECTED INDEX: $_gameIndex');
    });
  }

  void _submit() {
    print('===== GAME CHOSEN: Game #$_gameIndex');
    showCustomModalBottomSheet(
      context,
      const [SyaratDanKetentuanGame()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: 'Paket ${widget.name}'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const GameBannerContainer(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pilih Games',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${FORMAT_CURRENCY.format(widget.price)}/bln',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (ctx, i) => const SizedBox(height: 10),
                itemCount: 10,
                itemBuilder: (ctx, i) => GameDetailTile(
                  isSelected: i == _gameIndex!,
                  onTap: () => _selectGame(i),
                ),
              ),
            ),
            RoundedButton(
              onPressed: _gameIndex == -1 ? null : _submit,
              text: 'Pilih',
              useSide: _gameIndex != -1,
              useShadow: false,
              bgColor: _gameIndex == -1 ? Colors.grey : null,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
