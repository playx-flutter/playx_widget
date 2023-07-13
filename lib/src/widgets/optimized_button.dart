import 'package:flutter/material.dart';

/// Widget that can be used to display any type of button.
class OptimizedButton extends StatefulWidget {
  final OptimizedButtonType _type;
  final Widget child;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final void Function(bool value)? onHover;
  final void Function(bool value)? onFocusChange;
  final FocusNode? focusNode;
  final bool autofocus = false;
  final Clip clipBehavior = Clip.none;
  final MaterialStatesController? statesController;
  final Widget? icon;
  final Widget? label;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? disabledForegroundColor;
  final Color? disabledBackgroundColor;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final Size? fixedSize;
  final Size? maximumSize;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final MouseCursor? enabledMouseCursor;
  final MouseCursor? disabledMouseCursor;
  final VisualDensity? visualDensity;
  final MaterialTapTargetSize? tapTargetSize;
  final Duration? animationDuration;
  final bool? enableFeedback;
  final AlignmentGeometry? alignment;
  final InteractiveInkFeatureFactory? splashFactory;

  const OptimizedButton._(
    this._type, {
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.statesController,
    this.icon,
    this.label,
    this.foregroundColor,
    this.backgroundColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.textStyle,
    this.padding,
    this.minimumSize,
    this.fixedSize,
    this.maximumSize,
    this.side,
    this.shape,
    this.enabledMouseCursor,
    this.disabledMouseCursor,
    this.visualDensity,
    this.tapTargetSize,
    this.animationDuration,
    this.enableFeedback,
    this.alignment,
    this.splashFactory,
  });

  factory OptimizedButton.elevated({
    required Widget child,
    required VoidCallback onPressed,
    VoidCallback? onLongPress,
    void Function(bool value)? onHover,
    void Function(bool value)? onFocusChange,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    MaterialStatesController? statesController,
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
  }) {
    return OptimizedButton._(
      OptimizedButtonType.elevated,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      focusNode: focusNode,
      statesController: statesController,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      textStyle: textStyle,
      padding: padding,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      side: side,
      shape: shape,
      enabledMouseCursor: enabledMouseCursor,
      disabledMouseCursor: disabledMouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
      child: child,
    );
  }

  factory OptimizedButton.elevatedIcon({
    required Widget icon,
    required Widget label,
    required VoidCallback onPressed,
    VoidCallback? onLongPress,
    void Function(bool value)? onHover,
    void Function(bool value)? onFocusChange,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    MaterialStatesController? statesController,
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
  }) {
    return OptimizedButton._(
      OptimizedButtonType.elevatedIcon,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      focusNode: focusNode,
      statesController: statesController,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      textStyle: textStyle,
      padding: padding,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      side: side,
      shape: shape,
      enabledMouseCursor: enabledMouseCursor,
      disabledMouseCursor: disabledMouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
      icon: icon,
      label: label,
      child: const SizedBox.shrink(),
    );
  }

  factory OptimizedButton.outlined({
    required Widget child,
    required VoidCallback onPressed,
    VoidCallback? onLongPress,
    void Function(bool value)? onHover,
    void Function(bool value)? onFocusChange,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    MaterialStatesController? statesController,
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
  }) {
    return OptimizedButton._(
      OptimizedButtonType.outlined,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      focusNode: focusNode,
      statesController: statesController,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      textStyle: textStyle,
      padding: padding,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      side: side,
      shape: shape,
      enabledMouseCursor: enabledMouseCursor,
      disabledMouseCursor: disabledMouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
      child: child,
    );
  }

  factory OptimizedButton.text({
    required Widget child,
    required VoidCallback onPressed,
    VoidCallback? onLongPress,
    void Function(bool value)? onHover,
    void Function(bool value)? onFocusChange,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    MaterialStatesController? statesController,
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
  }) {
    return OptimizedButton._(
      OptimizedButtonType.text,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      focusNode: focusNode,
      statesController: statesController,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      textStyle: textStyle,
      padding: padding,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      side: side,
      shape: shape,
      enabledMouseCursor: enabledMouseCursor,
      disabledMouseCursor: disabledMouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
      child: child,
    );
  }

  @override
  State<OptimizedButton> createState() => _OptimizedButtonState();
}

class _OptimizedButtonState extends State<OptimizedButton> {
  @override
  Widget build(BuildContext context) {
    Widget buttonWidget;
    switch (widget._type) {
      case OptimizedButtonType.elevated:
        buttonWidget = ElevatedButton(
          onPressed: widget.onPressed,
          onLongPress: widget.onLongPress,
          onHover: widget.onHover,
          onFocusChange: widget.onFocusChange,
          style: ElevatedButton.styleFrom(
            foregroundColor: widget.foregroundColor,
            backgroundColor: widget.backgroundColor,
            disabledForegroundColor: widget.disabledForegroundColor,
            disabledBackgroundColor: widget.disabledBackgroundColor,
            shadowColor: widget.shadowColor,
            surfaceTintColor: widget.surfaceTintColor,
            elevation: widget.elevation,
            textStyle: widget.textStyle,
            padding: widget.padding,
            shape: widget.shape,
            side: widget.side,
            minimumSize: widget.minimumSize,
            fixedSize: widget.fixedSize,
            maximumSize: widget.maximumSize,
            tapTargetSize: widget.tapTargetSize,
            enabledMouseCursor: widget.enabledMouseCursor,
            disabledMouseCursor: widget.disabledMouseCursor,
            visualDensity: widget.visualDensity,
            animationDuration: widget.animationDuration,
            enableFeedback: widget.enableFeedback,
            alignment: widget.alignment,
            splashFactory: widget.splashFactory,
          ),
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          clipBehavior: widget.clipBehavior,
          statesController: widget.statesController,
          child: widget.child,
        );
        break;
      case OptimizedButtonType.text:
        buttonWidget = TextButton(
          onPressed: widget.onPressed,
          onLongPress: widget.onLongPress,
          onHover: widget.onHover,
          onFocusChange: widget.onFocusChange,
          style: TextButton.styleFrom(
            foregroundColor: widget.foregroundColor,
            backgroundColor: widget.backgroundColor,
            disabledForegroundColor: widget.disabledForegroundColor,
            disabledBackgroundColor: widget.disabledBackgroundColor,
            shadowColor: widget.shadowColor,
            surfaceTintColor: widget.surfaceTintColor,
            elevation: widget.elevation,
            textStyle: widget.textStyle,
            padding: widget.padding,
            shape: widget.shape,
            side: widget.side,
            minimumSize: widget.minimumSize,
            fixedSize: widget.fixedSize,
            maximumSize: widget.maximumSize,
            tapTargetSize: widget.tapTargetSize,
            enabledMouseCursor: widget.enabledMouseCursor,
            disabledMouseCursor: widget.disabledMouseCursor,
            visualDensity: widget.visualDensity,
            animationDuration: widget.animationDuration,
            enableFeedback: widget.enableFeedback,
            alignment: widget.alignment,
            splashFactory: widget.splashFactory,
          ),
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          clipBehavior: widget.clipBehavior,
          statesController: widget.statesController,
          child: widget.child,
        );
        break;
      case OptimizedButtonType.outlined:
        buttonWidget = OutlinedButton(
          onPressed: widget.onPressed,
          onLongPress: widget.onLongPress,
          onHover: widget.onHover,
          onFocusChange: widget.onFocusChange,
          style: OutlinedButton.styleFrom(
            foregroundColor: widget.foregroundColor,
            backgroundColor: widget.backgroundColor,
            disabledForegroundColor: widget.disabledForegroundColor,
            disabledBackgroundColor: widget.disabledBackgroundColor,
            shadowColor: widget.shadowColor,
            surfaceTintColor: widget.surfaceTintColor,
            elevation: widget.elevation,
            textStyle: widget.textStyle,
            padding: widget.padding,
            shape: widget.shape,
            side: widget.side,
            minimumSize: widget.minimumSize,
            fixedSize: widget.fixedSize,
            maximumSize: widget.maximumSize,
            tapTargetSize: widget.tapTargetSize,
            enabledMouseCursor: widget.enabledMouseCursor,
            disabledMouseCursor: widget.disabledMouseCursor,
            visualDensity: widget.visualDensity,
            animationDuration: widget.animationDuration,
            enableFeedback: widget.enableFeedback,
            alignment: widget.alignment,
            splashFactory: widget.splashFactory,
          ),
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          clipBehavior: widget.clipBehavior,
          statesController: widget.statesController,
          child: widget.child,
        );
        break;
      case OptimizedButtonType.elevatedIcon:
        buttonWidget = ElevatedButton.icon(
          onPressed: widget.onPressed,
          onLongPress: widget.onLongPress,
          onHover: widget.onHover,
          onFocusChange: widget.onFocusChange,
          style: ElevatedButton.styleFrom(
            foregroundColor: widget.foregroundColor,
            backgroundColor: widget.backgroundColor,
            disabledForegroundColor: widget.disabledForegroundColor,
            disabledBackgroundColor: widget.disabledBackgroundColor,
            shadowColor: widget.shadowColor,
            surfaceTintColor: widget.surfaceTintColor,
            elevation: widget.elevation,
            textStyle: widget.textStyle,
            padding: widget.padding,
            shape: widget.shape,
            side: widget.side,
            minimumSize: widget.minimumSize,
            fixedSize: widget.fixedSize,
            maximumSize: widget.maximumSize,
            tapTargetSize: widget.tapTargetSize,
            enabledMouseCursor: widget.enabledMouseCursor,
            disabledMouseCursor: widget.disabledMouseCursor,
            visualDensity: widget.visualDensity,
            animationDuration: widget.animationDuration,
            enableFeedback: widget.enableFeedback,
            alignment: widget.alignment,
            splashFactory: widget.splashFactory,
          ),
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          clipBehavior: widget.clipBehavior,
          statesController: widget.statesController,
          icon: widget.icon!,
          label: widget.label!,
        );
        break;
    }

    return buttonWidget;
  }
}

enum OptimizedButtonType {
  elevated,
  text,
  outlined,
  elevatedIcon,
}
