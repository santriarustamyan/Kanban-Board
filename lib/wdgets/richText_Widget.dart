import 'package:flutter/material.dart';
// import 'package:internship0006/classes/localizations.dart';

class RichTextWidget extends StatelessWidget {
  final Color color;
  final String text;
  final bool wrap;
  RichTextWidget({
    required this.text,
    this.wrap = true,
    this.color = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.15,
            right: MediaQuery.of(context).size.width * 0.15),
        child: Text(text,
            // .localizations(context),
            textAlign: TextAlign.center,
            softWrap: wrap,
            style: TextStyle(
              color: color,
              fontSize: 14,
            )));
  }
}
