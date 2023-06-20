import 'package:flutter/material.dart';

class RegisterDropdownButton extends StatelessWidget {
  const RegisterDropdownButton({
    Key? key,
    required this.text,
    required this.value,
    required this.valueList,
    required this.onChanged,
  }) : super(key: key);

  final String text;
  final String value;
  final List<String> valueList;
  final void Function(String? p1)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w200,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownButtonFormField(
          isExpanded: true,
          value: value,
          items: valueList.map((item) {
            return DropdownMenuItem(
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
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
              horizontal: 15,
              vertical: 13,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromRGBO(0, 255, 240, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
