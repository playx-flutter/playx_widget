import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInkWell extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final BorderRadius? borderRadius;

  const CustomInkWell({
    super.key,
    this.onTap,
    this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(16.r),
        child: child,
      ),
    );
  }
}
