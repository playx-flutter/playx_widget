import 'package:flutter/material.dart';

/// AdaptiveWidget : Widget that adapts to the screen size by creating multiple widgets for different screen sizes.
/// It has breakpoints for small mobile, medium mobile, large mobile, small tablet and large tablet.
/// These breakpoints are based on the smallest width of the screen.
/// Here is the breakpoint for mobile devices: [small mobile: 0-400, medium mobile: 400-480, large mobile: 480-600]
/// Here is the breakpoint for tablet devices: [small tablet: 600-720, large tablet: 720]
abstract class AdaptiveWidget extends StatelessWidget {
  const AdaptiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < 600) {
      Widget? widget;
      if (shortestSide < 400) {
        widget = buildSmallMobile(context) ?? buildMediumMobile(context);
      } else if (shortestSide >= 400 && shortestSide < 480) {
        widget = buildMediumMobile(context);
      }
      return widget ?? buildMobile(context);
    } else {
      Widget? widget;
      if (shortestSide >= 720) {
        widget = buildLargeTablet(context);
      }
      return widget ?? buildTablet(context);
    }
  }

  /// Builds the widget for small mobile devices.
  /// It supports devices with smallest width between 0 and 400.
  /// If this method is not implemented, [buildMediumMobile] will be called.
  /// If [buildMediumMobile] is not implemented, [buildMobile] will be called.
  Widget? buildSmallMobile(BuildContext context) {
    return null;
  }

  ///Builds the widget for medium mobile devices.
  ///It supports devices with smallest width between 400 and 480.
  ///If this method is not implemented, [buildMobile] will be called.
  Widget? buildMediumMobile(BuildContext context) {
    return null;
  }

  ///Builds the widget for large mobile devices.
  ///It supports devices with smallest width between 480 and 600.
  ///If [buildSmallMobile] or [buildMediumMobile] were not implemented.
  ///It will be called as default widget for small or medium mobile devices.
  Widget buildMobile(BuildContext context);

  /// Builds the widget for small tablet devices.
  /// It supports devices with smallest width between 600 and 720.
  /// If [buildLargeTablet] was not implemented, it will be called as default widget for large tablet devices.
  Widget buildTablet(BuildContext context);

  ///Builds the widget for large tablet devices.
  Widget? buildLargeTablet(BuildContext context) {
    return null;
  }
}
