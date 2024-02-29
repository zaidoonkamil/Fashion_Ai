import 'package:flutter/material.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({
    super.key,
    required this.iconData,
    this.edgeInsetsGeometry,
    this.color,
    this.colorIcon,
  });

  final IconData iconData;
  final Color? color;
  final Color? colorIcon;
  final EdgeInsetsGeometry? edgeInsetsGeometry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:edgeInsetsGeometry?? const EdgeInsets.only(left: 8, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: color,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1.0,
        ),
      ),
      child: Icon(
        iconData,
        color: colorIcon,
      ),
    );
  }
}
