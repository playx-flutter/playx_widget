import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playx_widget/src/widgets/optimized_card.dart';

class OptimizedListTile extends StatefulWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? horizontalSpace;

  const OptimizedListTile(
      {super.key,
      required this.title,
      this.subtitle,
      this.leading,
      this.trailing,
      this.contentPadding,
      this.margin,
      this.padding,
      this.horizontalSpace});

  @override
  State<OptimizedListTile> createState() => _OptimizedListTileState();
}

class _OptimizedListTileState extends State<OptimizedListTile> {
  @override
  Widget build(BuildContext context) {
    return OptimizedCard(
      padding: widget.padding ??
          EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 16.h),
      margin: widget.margin,
      child: Row(
        children: [
          if (widget.leading != null)
            Container(
              padding: widget.contentPadding,
              child: widget.leading,
            ),
          SizedBox(
            width: widget.horizontalSpace ?? 6.w,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: widget.contentPadding,
                  child: widget.title,
                ),
                if (widget.subtitle != null)
                  Container(
                    padding: widget.contentPadding,
                    child: widget.subtitle,
                  ),
              ],
            ),
          ),
          SizedBox(
            width: widget.horizontalSpace ?? 6.w,
          ),
          if (widget.trailing != null)
            Container(
              padding: widget.contentPadding,
              child: widget.trailing,
            ),
        ],
      ),
    );
  }
}
