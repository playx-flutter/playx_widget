import 'package:flutter_svg_provider/flutter_svg_provider.dart';

/// Rasterizes given svg picture for displaying in [Image] widget:
///
/// ```dart
/// Image(
///   width: 32,
///   height: 32,
///   image: Svg('assets/my_icon.svg'),
/// )
/// ```
class SvgProvider extends Svg {
  const SvgProvider(
    super.path, {
    super.size,
    super.scale,
    super.color,
    super.source = SvgSource.asset,
    super.svgGetter,
  });
}
