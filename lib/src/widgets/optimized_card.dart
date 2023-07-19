import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Optimized Card Widget which provides better shadow effect for the card.
/// To look more like native card.
class OptimizedCard extends StatefulWidget {
  //Width of the card.
  final double? width;

  //Height of the card.
  final double? height;

  //Padding of the card.
  final EdgeInsetsGeometry? padding;

  /// The card's background color.
  ///
  /// Defines the card's [Material.color].
  ///
  /// If this property is null then the ambient [CardTheme.color] is used. If that is null,
  /// and [ThemeData.useMaterial3] is true, then [ColorScheme.surface] of
  /// [ThemeData.colorScheme] is used. Otherwise, [ThemeData.cardColor] is used.
  final Color? color;

  /// The color to paint the shadow below the card.
  ///
  /// If null then the ambient [CardTheme]'s shadowColor is used.
  /// If that's null too, then the overall theme's [ThemeData.shadowColor]
  /// (default black) is used.
  final Color? shadowColor;

  /// The color used as an overlay on [color] to indicate elevation.
  ///
  /// If this is null, no overlay will be applied. Otherwise this color
  /// will be composited on top of [color] with an opacity related
  /// to [elevation] and used to paint the background of the card.
  ///
  /// The default is null.
  ///
  /// See [Material.surfaceTintColor] for more details on how this
  /// overlay is applied.
  final Color? surfaceTintColor;

  /// The z-coordinate at which to place this card. This controls the size of
  /// the shadow below the card.
  ///
  /// Defines the card's [Material.elevation].
  ///
  /// If this property is null then [CardTheme.elevation] of
  /// [ThemeData.cardTheme] is used. If that's null, the default value is 1.0.
  final double? elevation;

  /// The shape of the card's [Material].
  ///
  /// Defines the card's [Material.shape].
  ///
  /// If this property is null then [CardTheme.shape] of [ThemeData.cardTheme]
  /// is used. If that's null then the shape will be a [RoundedRectangleBorder]
  /// with a circular corner radius of 4.0.
  final ShapeBorder? shape;

  /// Whether to paint the [shape] border in front of the [child].
  ///
  /// The default value is true.
  /// If false, the border will be painted behind the [child].
  final bool borderOnForeground;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// If this property is null then [CardTheme.clipBehavior] of
  /// [ThemeData.cardTheme] is used. If that's null then the behavior will be [Clip.none].
  final Clip? clipBehavior;

  /// The empty space that surrounds the card.
  ///
  /// Defines the card's outer [Container.margin].
  ///
  /// If this property is null then [CardTheme.margin] of
  /// [ThemeData.cardTheme] is used. If that's null, the default margin is 4.0
  /// logical pixels on all sides: `EdgeInsets.all(4.0)`.
  final EdgeInsetsGeometry? margin;

  /// The empty space that surrounds the card shadow.
  ///
  /// Defines the card  shadow margin [Container.margin].
  final EdgeInsetsGeometry? innerCardShadowMargin;

  /// Whether this widget represents a single semantic container, or if false
  /// a collection of individual semantic nodes.
  ///
  /// Defaults to true.
  ///
  /// Setting this flag to true will attempt to merge all child semantics into
  /// this node. Setting this flag to false will force all child semantic nodes
  /// to be explicit.
  ///
  /// This flag should be false if the card contains multiple different types
  /// of content.
  final bool semanticContainer;

  /// The color of custom shadow that is around the card.
  /// If null then the Colors.grey.withOpacity(.25) shadowColor is used.
  final Color? customShadowColor;

  /// Blur radius of the custom shadow.
  final double shadowRadius;

  /// spread radius of the custom shadow.
  final double spreadRadius;

  /// offset of the custom shadow.
  final Offset shadowOffset;

  /// Determines the border radius of the shadow.
  final BorderRadius? shadowBorderRadius;

  /// Determines the blur style of the shadow.
  final BlurStyle shadowBlurStyle;

  /// Determines whether the custom shadow should be applied to the card or not.
  final bool shouldShowCustomShadow;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  const OptimizedCard(
      {super.key,
      this.width,
      this.height,
      this.padding,
      this.color,
      this.shadowColor = Colors.transparent,
      this.surfaceTintColor,
      this.elevation = 3,
      this.shape,
      this.borderOnForeground = true,
      this.clipBehavior = Clip.hardEdge,
      this.margin,
      this.innerCardShadowMargin,
      this.semanticContainer = true,
      this.customShadowColor,
      this.shadowOffset = const Offset(
        0.0,
        1.0,
      ),
      this.shadowRadius = 5.0,
      this.spreadRadius = 1.0,
      this.shadowBorderRadius,
      this.shadowBlurStyle = BlurStyle.normal,
      this.shouldShowCustomShadow = true,
      this.child});

  @override
  State<OptimizedCard> createState() => _OptimizedCardState();
}

class _OptimizedCardState extends State<OptimizedCard> {
  @override
  Widget build(BuildContext context) {
    if (!widget.shouldShowCustomShadow) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Card(
            elevation: widget.elevation,
            shadowColor: widget.shadowColor,
            surfaceTintColor: widget.surfaceTintColor,
            borderOnForeground: widget.borderOnForeground,
            shape: widget.shape ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
            color: widget.color,
            margin: widget.margin ??
                EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: widget.child,
            )),
      );
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Container(
        margin: widget.margin ??
            EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
        decoration: BoxDecoration(
          borderRadius: widget.shadowBorderRadius ??
              BorderRadius.all(Radius.circular(10.r)),
          boxShadow: [
            BoxShadow(
              color: widget.customShadowColor ?? Colors.grey.withOpacity(.3),
              blurRadius: widget.shadowRadius,
              spreadRadius: widget.spreadRadius,
              // soften the shadow
              offset: widget.shadowOffset,
              blurStyle: widget.shadowBlurStyle,
            )
          ],
        ),
        child: Card(
            elevation: widget.elevation,
            shadowColor: widget.shadowColor,
            surfaceTintColor: widget.surfaceTintColor,
            borderOnForeground: widget.borderOnForeground,
            shape: widget.shape ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
            color: widget.color,
            margin: widget.innerCardShadowMargin ??
                EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: widget.child,
            )),
      ),
    );
  }
}
