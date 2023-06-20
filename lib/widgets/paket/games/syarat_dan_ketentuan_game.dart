import 'package:flutter/material.dart';
import 'package:mynetvolve/widgets/buttons/gradient_button.dart';
import 'package:mynetvolve/widgets/buttons/rounded_button.dart';

import '../../gradient_widget.dart';

class SyaratDanKetentuanGame extends StatefulWidget {
  const SyaratDanKetentuanGame({
    Key? key,
  }) : super(key: key);

  @override
  State<SyaratDanKetentuanGame> createState() => _SyaratDanKetentuanGameState();
}

class _SyaratDanKetentuanGameState extends State<SyaratDanKetentuanGame> {
  var _agreeTnC = false;
  @override
  Widget build(BuildContext context) {
    const tnc =
        'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.\n\nAliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.\n\nAliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.\n\nAliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.\n\nAliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.';
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const GradientWidget(
                child: ImageIcon(
                  AssetImage('assets/icons/tnc.png'),
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Syarat dan Ketentuan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'update 03/03/2023',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: const SingleChildScrollView(
              child: Text(tnc),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: _agreeTnC,
                onChanged: (value) {
                  setState(() {
                    _agreeTnC = value!;
                  });
                },
                visualDensity: const VisualDensity(horizontal: -2),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Text(
                'I agree with the terms and conditions',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 130,
                child: RoundedButton(
                  onPressed: () {},
                  text: 'Cancel',
                  useSide: false,
                  useShadow: false,
                ),
              ),
              const SizedBox(width: 30),
              _agreeTnC
                  ? GradientButton(
                      buttonHandle: () {},
                      text: 'Lanjutkan',
                      height: 35,
                      width: 130,
                      useElevation: false,
                    )
                  : const SizedBox(
                      width: 130,
                      child: RoundedButton(
                        onPressed: null,
                        text: 'Lanjutkan',
                        useSide: false,
                        useShadow: false,
                        bgColor: Colors.grey,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
