import 'package:assingment_task_menager/presentation/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsPath.logoSvg,
      width: 120,
      fit: BoxFit.scaleDown,
    );
  }
}