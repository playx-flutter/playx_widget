import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A custom widget that mimics the behavior of [SizedBox] but for use inside
/// a [CustomScrollView] or other sliver-based lists.
class SliverSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;

  const SliverSizedBox({super.key, this.height, this.width, this.child});

  // --- Static Getters for Important Values (Vertical Spacing) ---
  static SliverSizedBox h4 = SliverSizedBox(height: 4.r);
  static SliverSizedBox h8 = SliverSizedBox(height: 8.r);
  static SliverSizedBox h12 = SliverSizedBox(height: 12.r);
  static SliverSizedBox h16 = SliverSizedBox(height: 16.r);
  static SliverSizedBox h24 = SliverSizedBox(height: 24.r);
  static SliverSizedBox h32 = SliverSizedBox(height: 32.r);
  static SliverSizedBox h48 = SliverSizedBox(height: 48.r);
  static SliverSizedBox h64 = SliverSizedBox(height: 64.r);

  static SliverSizedBox w4 = SliverSizedBox(width: 4.r);
  static SliverSizedBox w8 = SliverSizedBox(width: 8.r);
  static SliverSizedBox w12 = SliverSizedBox(width: 12.r);
  static SliverSizedBox w16 = SliverSizedBox(width: 16.r);

  static SliverSizedBox w24 = SliverSizedBox(width: 24.r);
  static SliverSizedBox w32 = SliverSizedBox(width: 32.r);

  static SliverSizedBox w48 = SliverSizedBox(width: 48.r);

  static SliverSizedBox w64 = SliverSizedBox(width: 64.r);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: height, width: width, child: child),
    );
  }
}
