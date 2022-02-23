import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndicatorWidget extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;

  const IndicatorWidget({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: Get.textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
