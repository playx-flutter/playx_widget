import 'package:flutter/cupertino.dart';
import 'package:playx_widget/playx_widget.dart';

class IconInfo {
  final IconData? icon;
  final String? svgIcon;
  final String? assetIcon;
  final String? url;
  final Color? color;
  final double? size;

  IconInfo({
    this.icon,
    this.svgIcon,
    this.assetIcon,
    this.url,
    this.color,
    this.size,
  });

  factory IconInfo.icon(IconData icon, {Color? color, double? size}) {
    return IconInfo(icon: icon, color: color, size: size);
  }

  factory IconInfo.asset(String assetIcon, {Color? color, double? size}) {
    return IconInfo(assetIcon: assetIcon, color: color, size: size);
  }

  factory IconInfo.svg(String svgIcon, {Color? color, double? size}) {
    return IconInfo(svgIcon: svgIcon, color: color, size: size);
  }

  factory IconInfo.url(String url, {Color? color, double? size}) {
    return IconInfo(url: url, color: color, size: size);
  }

  IconInfo copyWith({
    IconData? icon,
    String? svgIcon,
    String? url,
    Color? color,
    double? size,
  }) {
    return IconInfo(
      icon: icon ?? this.icon,
      svgIcon: svgIcon ?? this.svgIcon,
      url: url ?? this.url,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }

  Widget buildIconWidget({
    Color? color,
    double? size,
    BoxFit? fit,
    TextDirection? textDirection,
  }) {
    return ImageViewer.icon(this,
        color: color,
        width: size,
        height: size,
        fit: fit,
        iconDirection: textDirection);
  }
}
