import 'package:flutter/material.dart';

import '../../core/palette.dart';
import '../../screens/profile/riwayat/aktivitas_screen.dart';
import '../../screens/profile/riwayat/pembelian_screen.dart';
import '../../screens/profile/riwayat/tagihan_screen.dart';
import '../../widgets/gradient_app_bar.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({Key? key}) : super(key: key);

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Riwayat'),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            color: Palette.kToDark.shade300,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 4,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(text: 'Tagihan'),
                Tab(text: 'Pembelian'),
                Tab(text: 'Aktivitas'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                TagihanScreen(),
                PembelianScreen(),
                AktivitasScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
