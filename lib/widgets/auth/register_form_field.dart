import 'package:flutter/material.dart';

class RegisterFormField extends StatefulWidget {
  const RegisterFormField({
    Key? key,
    required this.cont,
    this.text,
    required this.isPassword,
    required this.textInputType,
    required this.validator,
    required this.onSaved,
    this.onChanged,
    this.autofillHints,
  }) : super(key: key);

  final TextEditingController cont;
  final String? text;
  final bool isPassword;
  final TextInputType textInputType;
  final String? Function(String? p1)? validator;
  final String? Function(String? p1)? onSaved;
  final String? Function(String? p1)? onChanged;
  final Iterable<String>? autofillHints;

  @override
  State<RegisterFormField> createState() => _RegisterFormFieldState();
}

class _RegisterFormFieldState extends State<RegisterFormField> {
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
        if (widget.text != null)
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  widget.text!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: 13,
                  ),
                ),
                if (widget.isPassword) const SizedBox(width: 5),
                if (widget.isPassword)
                  Tooltip(
                    message:
                        'Jika Anda belum pernah merubah password, gunakan nomor telepon Anda',
                    triggerMode: TooltipTriggerMode.tap,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    // margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      // color: Colors.black87,
                      color: Colors.grey[700]!.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(
          height: 5,
        ),
        PhysicalModel(
          elevation: 5,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: TextFormField(
            controller: widget.cont,
            keyboardType: widget.textInputType,
            // keyboardType: TextInputType.number,
            obscureText: widget.isPassword ? _isObscured : false,
            // autofocus: false,
            // focusNode: focusNode,
            autofillHints: widget.autofillHints,
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
              suffixIconConstraints: const BoxConstraints(maxHeight: 32),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                      ),
                    )
                  : null,
            ),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            validator: widget.validator,
            onSaved: widget.onSaved,
            onChanged: widget.onChanged ?? (_) {},
          ),
        ),
      ],
    );
  }
}
