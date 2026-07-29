import 'package:flutter/material.dart';
import '../../design_tokens/colors.dart';

class RaagaDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final double indent;
  final double endIndent;

  const RaagaDivider({
    super.key,
    this.height = 16.0,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      color: AppColors.divider,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
