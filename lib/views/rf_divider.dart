import 'package:flutter/material.dart';

class RFDivider extends StatelessWidget {

  final double? height;
  final Color? color;
  final double? indent;

  const RFDivider({
    Key? key,
    this.height = 1,
    this.color = Colors.grey,
    this.indent = 0.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsetsDirectional.only(start: indent!),
      color: color!,
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(
      //         width: height,
      //         color: color!),
      //   ),
      // ),
    );
  }
}