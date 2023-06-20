import 'package:flutter/material.dart';

class PaketCardButton extends StatelessWidget {
  final String text1;
  final String? text2;
  final Color? color;
  final IconData icon;
  final VoidCallback onTap;
  const PaketCardButton({
    Key? key,
    required this.text1,
    this.text2,
    required this.color,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.circular(15);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: _borderRadius,
      ),
      shadowColor: Colors.black,
      elevation: 6,
      color: color,
      child: InkWell(
        onTap: onTap,
        borderRadius: _borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: TextStyle(fontSize: 20),
                  ),
                  if (text2 != null) const SizedBox(height: 5),
                  if (text2 != null)
                    Text(
                      text2!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
              Icon(
                icon,
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
