import 'package:flutter/cupertino.dart';

///Widget that displays a simple circle loading indicator like in ios.
class CenterLoading extends StatelessWidget {
  final Color? color;
  final bool isAnimating;

  const CenterLoading({
    super.key,
    this.color,
    this.isAnimating = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: color,
        animating: isAnimating,
      ),
    );
  }
}
