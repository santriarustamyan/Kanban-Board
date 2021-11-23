import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TxtFieldForScreen extends StatelessWidget {
  final String? label;
  final String? initialValue;
  final String? Function(String?)? validator;
  final Function(String)? onChange;
  final TextInputType? txtType;
  final bool? obscure;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final Widget? preffix;
  TxtFieldForScreen({
    this.label,
    this.initialValue,
    this.obscure,
    this.onChange,
    this.txtType,
    this.validator,
    this.suffixIcon,
    this.preffixIcon,
    this.preffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 35,
        right: 35,
      ),
      child: TextFormField(
        autofocus: true,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        keyboardType: txtType,
        obscureText: obscure!,
        validator: validator,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChange,
        decoration: InputDecoration(
            prefix: preffix,
            labelText: label,
            labelStyle: TextStyle(color: Colors.white),
            suffixIcon: suffixIcon,
            prefixIcon: preffixIcon,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))),
      ),
    );
  }
}
