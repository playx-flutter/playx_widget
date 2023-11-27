import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/common_utils.dart';

enum CenterLoadingType { material, cupertino, adaptive }

///Widget that displays a simple circle loading indicator like in ios.
class CenterLoading extends StatelessWidget {
  final Color? color;
  final bool isAnimating;
  final double? radius;
  final double? strokeWidth;
  final Color? backgroundColor;
  final CenterLoadingType _type;

  const CenterLoading({
    super.key,
    this.color,
    this.isAnimating = true,
    this.radius = 10,
  })  : _type = CenterLoadingType.cupertino,
        backgroundColor = null,
        strokeWidth = null;

  const CenterLoading.adaptive({
    super.key,
    this.color,
    this.isAnimating = true,
    this.radius,
    this.strokeWidth,
    this.backgroundColor,
  }) : _type = CenterLoadingType.adaptive;

  const CenterLoading.material({
    super.key,
    this.color,
    this.isAnimating = true,
    this.strokeWidth = 4,
    this.backgroundColor,
  })  : _type = CenterLoadingType.material,
        radius = null;

  @override
  Widget build(BuildContext context) {
    Widget child;

    switch (_type) {
      case CenterLoadingType.material:
        child = _buildMaterialWidget();
        break;
      case CenterLoadingType.cupertino:
        child = _buildCupertinoWidget();
        break;
      case CenterLoadingType.adaptive:
        child = isCupertino ? _buildCupertinoWidget() : _buildMaterialWidget();
        break;
    }

    return Center(child: child);
  }

  Widget _buildCupertinoWidget() {
    return CupertinoActivityIndicator(
      color: color,
      animating: isAnimating,
      radius: radius ?? 10,
    );
  }

  Widget _buildMaterialWidget() {
    return CircularProgressIndicator(
      color: color,
      value: isAnimating ? null : 1,
      strokeWidth: strokeWidth ?? 4,
      backgroundColor: backgroundColor,
    );
  }
}
