import 'package:flutter/material.dart';

class AkunFormField extends StatefulWidget {
  const AkunFormField({
    Key? key,
    required this.cont,
    required this.text,
    required this.textInputType,
    required this.validator,
    required this.onSaved,
    this.isPassword,
    this.readOnly,
    this.additionalInfo,
  }) : super(key: key);

  final TextEditingController cont;
  final String text;
  final TextInputType textInputType;
  final bool? isPassword;
  final bool? readOnly;
  final Widget? additionalInfo;
  final String? Function(String? p1)? validator;
  final String? Function(String? p1)? onSaved;

  @override
  State<AkunFormField> createState() => _AkunFormFieldState();
}

class _AkunFormFieldState extends State<AkunFormField> {
  var _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            if (widget.additionalInfo != null) widget.additionalInfo!,
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.cont,
          readOnly: widget.readOnly != null && widget.readOnly == true ? true : false,
          keyboardType: widget.textInputType,
          obscureText: (widget.isPassword != null && widget.isPassword == true)
              ? _isObscured
              : false,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 13,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 255, 240, 1),
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            suffixIcon: (widget.isPassword != null && widget.isPassword == true)
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility),
                  )
                : null,
          ),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          validator: widget.validator,
          onSaved: widget.onSaved,
        ),
      ],
    );
  }
}
