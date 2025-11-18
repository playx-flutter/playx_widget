import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playx_widget/src/widgets/optimized_card.dart';

class OptimizedListTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? horizontalSpace;
  final bool shouldShowCardShadow;

  const OptimizedListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.contentPadding,
    this.margin,
    this.padding,
    this.horizontalSpace,
    this.shouldShowCardShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return OptimizedCard(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 16.h),
      margin: margin,
      shouldShowCustomShadow: shouldShowCardShadow,
      child: Row(
        children: [
          if (leading != null)
            Container(padding: contentPadding, child: leading),
          SizedBox(width: horizontalSpace ?? 6.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(padding: contentPadding, child: title),
                if (subtitle != null)
                  Container(padding: contentPadding, child: subtitle),
              ],
            ),
          ),
          SizedBox(width: horizontalSpace ?? 6.w),
          if (trailing != null)
            Container(padding: contentPadding, child: trailing),
        ],
      ),
    );
  }
}
