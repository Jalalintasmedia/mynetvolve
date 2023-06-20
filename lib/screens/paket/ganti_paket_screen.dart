import 'package:flutter/material.dart';
import 'package:mynetvolve/widgets/auth/register_dropdown_button.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:mynetvolve/widgets/paket/paket_card_button.dart';

class GantiPaketScreen extends StatefulWidget {
  const GantiPaketScreen({Key? key}) : super(key: key);

  @override
  State<GantiPaketScreen> createState() => _GantiPaketScreenState();
}

class _GantiPaketScreenState extends State<GantiPaketScreen> {
  var products = [
    'Internet Only',
    'Blablabla',
    'TV Only',
  ];
  var _selectedProduct = 'Internet Only';
  var areas = [
    'JABODETABEK',
    'Medan',
    'Cikupa',
    'Semarang',
    'Bali',
    'Kota Harapan Indah',
  ];
  var _selectedArea = 'JABODETABEK';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Ganti Paket'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dropdownWidget(
                'Produk',
                _selectedProduct,
                products,
                (String? newValue) {
                  setState(() {
                    _selectedProduct = newValue!;
                  });
                },
              ),
              const SizedBox(height: 10),
              dropdownWidget(
                'Select Area',
                _selectedArea,
                areas,
                (String? newValue) {
                  setState(() {
                    _selectedArea = newValue!;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              paketsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropdownWidget(
    String title,
    String value,
    List<String> valueList,
    void Function(String? p1)? onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: DropdownButtonFormField(
            isExpanded: true,
            value: value,
            items: valueList.map((item) {
              return DropdownMenuItem(
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 14),
                ),
                value: item,
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget paketsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _selectedArea,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (ctx, i) => Column(
            children: [
              PaketCardButton(
                text1: '${(i + 1) * 10}',
                color: Colors.white,
                icon: Icons.download_for_offline_outlined,
                onTap: () {},
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
