import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum MyIconTheme {
  sun,
  moon,
}

class ThemeModeWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final MyIconTheme iconTheme;
  const ThemeModeWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.iconTheme,
  });

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? iconTheme == MyIconTheme.moon
            ? SvgPicture.asset(
                'assets/light.svg',
                width: 120,
                height: 120,
              )
            : SvgPicture.asset(
                'assets/dark.svg',
                width: 110,
                height: 110,
              )
        //
        // Isn't selected
        //
        : iconTheme == MyIconTheme.moon
            ? SvgPicture.asset(
                'assets/light.svg',
                width: 120,
                height: 120,
              )
            : SvgPicture.asset(
                'assets/dark.svg',
                width: 110,
                height: 110,
              );
  }
}
