import 'package:flutter/material.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:mynetvolve/core/palette.dart';
import 'package:mynetvolve/widgets/paket/games/paket_game_container.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../widgets/circle_indicator.dart';
import '../../../widgets/gradient_app_bar.dart';
import '../../../widgets/paket/games/game_banner_container.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final _pageController = PageController(viewportFraction: 1.05);
  int _currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Games'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const GameBannerContainer(),
              const SizedBox(height: 15),
              const Text(
                'Paket',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              ExpandablePageView.builder(
                controller: _pageController,
                itemCount: 4,
                itemBuilder: (ctx, i) => FractionallySizedBox(
                  widthFactor: 1 / _pageController.viewportFraction,
                  child: const PaketGameContainer(
                    paketName: 'Bronze',
                    price: 7000,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: CircleIndicator(
                  activeIndex: _currentPage,
                  imagesLength: 4,
                  activeDotColor: Palette.kToDark,
                  dotColor: Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
