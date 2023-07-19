import 'package:flutter/cupertino.dart';

///Widget that displays a simple circle loading indicator like in ios.
class CenterLoading extends StatelessWidget {
  final Color? color;
  final bool isAnimating;
  final double radius;

  const CenterLoading({
    super.key,
    this.color,
    this.isAnimating = true,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: color,
        animating: isAnimating,
        radius: radius,
      ),
    );
  }
}
