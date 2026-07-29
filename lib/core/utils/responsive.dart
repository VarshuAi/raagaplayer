import 'package:flutter/material.dart';

enum RaagaDeviceType { compact, medium, expanded }

class RaagaResponsive extends StatelessWidget {
  final Widget compact;
  final Widget? medium;
  final Widget? expanded;

  const RaagaResponsive({
    super.key,
    required this.compact,
    this.medium,
    this.expanded,
  });

  static RaagaDeviceType getDeviceType(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    if (width >= 840) return RaagaDeviceType.expanded;
    if (width >= 600) return RaagaDeviceType.medium;
    return RaagaDeviceType.compact;
  }

  static bool isCompact(BuildContext context) => getDeviceType(context) == RaagaDeviceType.compact;
  static bool isMedium(BuildContext context) => getDeviceType(context) == RaagaDeviceType.medium;
  static bool isExpanded(BuildContext context) => getDeviceType(context) == RaagaDeviceType.expanded;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 840) {
          return expanded ?? medium ?? compact;
        }
        if (constraints.maxWidth >= 600) {
          return medium ?? compact;
        }
        return compact;
      },
    );
  }
}
