import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeadlineWidget extends StatelessWidget {
  final bool backButton;
  final String text;

  HeadlineWidget({
    required this.text,
    this.backButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_backButton(context), _renderTitle(context)],
    );
  }

  Widget _backButton(BuildContext context) {
    return backButton
        ? Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 15),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue,
                  size: 32,
                ),
                onPressed: () => Navigator.pop(context)),
          )
        : Container();
  }

  Widget _renderTitle(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(
            top: 40,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1),
        child: Text(
          text,
          // .localizations(context),
          textAlign: TextAlign.center,
          softWrap: true,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ));
  }
}
