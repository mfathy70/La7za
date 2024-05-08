import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn({
    Key? key,
    required this.icon,
    this.showShadow = false,
    required this.height,
    required this.width,
  }) : super(key: key);

  final IconData icon;
  final bool showShadow;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: const Offset(0, 6),
              blurRadius: 10,
              color: const Color(0xFFB0B0B0).withOpacity(0.2),
            ),
        ],
      ),
      child: Icon(
        icon,
        color: kPrimaryColor,
      ),
    );
  }
}
