import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playx_widget/src/utils/common_utils.dart';

/// Creates an adaptive progress indicator that is a
/// [CupertinoActivityIndicator] in iOS and [CircularProgressIndicator] in
/// material theme/non-iOS.
/// {@macro flutter.material.ProgressIndicator.ProgressIndicator}
class AdaptiveLoadingIndicator extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final bool isAnimating;
  final double radius;

  const AdaptiveLoadingIndicator(
      {super.key,
      this.color,
      this.isAnimating = true,
      this.radius = 10,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return isIos
        ? CupertinoActivityIndicator(
            color: color,
            animating: isAnimating,
            radius: radius,
          )
        : CircularProgressIndicator(
            color: color,
            value: isAnimating ? null : 1,
            strokeWidth: radius,
            backgroundColor: backgroundColor,
          );
  }
}
