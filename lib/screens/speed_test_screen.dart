import 'package:flutter/material.dart';
import 'package:mynetvolve/core/palette.dart';
import 'package:mynetvolve/widgets/buttons/gradient_button.dart';

class SpeedtestScreen extends StatefulWidget {
  const SpeedtestScreen({Key? key}) : super(key: key);

  @override
  State<SpeedtestScreen> createState() => _SpeedtestScreenState();
}

class _SpeedtestScreenState extends State<SpeedtestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Speed Test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(12, 193, 246, 0.9),
                    Color.fromRGBO(14, 84, 250, 0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Palette.kToDark),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.language, color: Palette.kToDark),
                        SizedBox(width: 8),
                        Text(
                          'PT Jala Lintas Media',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Palette.kToDark),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          buildNetworkInfoColumn(
                            'Ping',
                            '5 ms',
                            Icons.wifi,
                          ),
                          const VerticalDivider(color: Colors.grey),
                          buildNetworkInfoColumn(
                            'Download',
                            '50 Mbps',
                            Icons.file_download_outlined,
                          ),
                          const VerticalDivider(color: Colors.grey),
                          buildNetworkInfoColumn(
                            'Upload',
                            '40 Mbps',
                            Icons.file_upload_outlined,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GradientButton(
          buttonHandle: () {},
          text: 'Restart Test',
          height: 50,
          useBorder: false,
          useElevation: false,
        ),
      ),
    );
  }

  Widget buildNetworkInfoColumn(
      String title, String description, IconData icon) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: Palette.kToDark),
              const SizedBox(width: 5),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  title,
                  style: const TextStyle(color: Palette.kToDark),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
