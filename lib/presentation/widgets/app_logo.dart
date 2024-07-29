import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_management/presentation/utils/assets_path.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsPath.appLogo,
      width: 120,
      fit: BoxFit.scaleDown,
    );
  }
}