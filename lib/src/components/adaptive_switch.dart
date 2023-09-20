import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Creates an adaptive [Switch] based on whether the target platform is iOS
/// or macOS, following Material design's
/// [Cross-platform guidelines](https://material.io/design/platform-guidance/cross-platform-adaptation.html).
///
/// On iOS and macOS, this constructor creates a [CupertinoSwitch], which has
/// matching functionality and presentation as Material switches, and are the
/// graphics expected on iOS. On other platforms, this creates a Material
/// design [Switch].
///
/// If a [CupertinoSwitch] is created, the following parameters are ignored:
/// [activeTrackColor], [inactiveThumbColor], [inactiveTrackColor], [trackOutlineWidth]
/// [activeThumbImage], [onActiveThumbImageError], [inactiveThumbImage],
/// [onInactiveThumbImageError], [materialTapTargetSize].
///
/// The target platform is based on the current [Theme]: [ThemeData.platform].
class AdaptiveSwitch extends StatelessWidget {
  /// Whether this switch is on or off.
  ///
  /// This property must not be null.
  final bool value;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  ///
  /// If null, the switch will be displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// Switch(
  ///   value: _giveVerse,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _giveVerse = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool>? onChanged;

  /// {@template flutter.material.switch.activeColor}
  /// The color to use when this switch is on.
  /// {@endtemplate}
  ///
  /// Defaults to [ColorScheme.secondary].
  ///
  /// If [thumbColor] returns a non-null color in the [MaterialState.selected]
  /// state, it will be used instead of this color.
  final Color? activeColor;

  /// {@template flutter.material.switch.activeTrackColor}
  /// The color to use on the track when this switch is on.
  /// {@endtemplate}
  ///
  /// Defaults to [ColorScheme.secondary] with the opacity set at 50%.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  ///
  /// If [trackColor] returns a non-null color in the [MaterialState.selected]
  /// state, it will be used instead of this color.
  final Color? activeTrackColor;

  /// {@template flutter.material.switch.inactiveThumbColor}
  /// The color to use on the thumb when this switch is off.
  /// {@endtemplate}
  ///
  /// Defaults to the colors described in the Material design specification.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  ///
  /// If [thumbColor] returns a non-null color in the default state, it will be
  /// used instead of this color.
  final Color? inactiveThumbColor;

  /// {@template flutter.material.switch.inactiveTrackColor}
  /// The color to use on the track when this switch is off.
  /// {@endtemplate}
  ///
  /// Defaults to the colors described in the Material design specification.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  ///
  /// If [trackColor] returns a non-null color in the default state, it will be
  /// used instead of this color.
  final Color? inactiveTrackColor;

  /// {@template flutter.material.switch.activeThumbImage}
  /// An image to use on the thumb of this switch when the switch is on.
  /// {@endtemplate}
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final ImageProvider? activeThumbImage;

  /// {@template flutter.material.switch.onActiveThumbImageError}
  /// An optional error callback for errors emitted when loading
  /// [activeThumbImage].
  /// {@endtemplate}
  final ImageErrorListener? onActiveThumbImageError;

  /// {@template flutter.material.switch.inactiveThumbImage}
  /// An image to use on the thumb of this switch when the switch is off.
  /// {@endtemplate}
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final ImageProvider? inactiveThumbImage;

  /// {@template flutter.material.switch.onInactiveThumbImageError}
  /// An optional error callback for errors emitted when loading
  /// [inactiveThumbImage].
  /// {@endtemplate}
  final ImageErrorListener? onInactiveThumbImageError;

  /// {@template flutter.material.switch.thumbColor}
  /// The color of this [Switch]'s thumb.
  ///
  /// Resolved in the following states:
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// {@tool snippet}
  /// This example resolves the [thumbColor] based on the current
  /// [MaterialState] of the [Switch], providing a different [Color] when it is
  /// [MaterialState.disabled].
  ///
  /// ```dart
  /// Switch(
  ///   value: true,
  ///   onChanged: (bool value) { },
  ///   thumbColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
  ///     if (states.contains(MaterialState.disabled)) {
  ///       return Colors.orange.withOpacity(.48);
  ///     }
  ///     return Colors.orange;
  ///   }),
  /// )
  /// ```
  /// {@end-tool}
  /// {@endtemplate}
  ///
  /// If null, then the value of [activeColor] is used in the selected
  /// state and [inactiveThumbColor] in the default state. If that is also null,
  /// then the value of [SwitchThemeData.thumbColor] is used. If that is also
  /// null, then the following colors are used:
  ///
  /// | State    | Light theme                       | Dark theme                        |
  /// |----------|-----------------------------------|-----------------------------------|
  /// | Default  | `Colors.grey.shade50`             | `Colors.grey.shade400`            |
  /// | Selected | [ColorScheme.secondary] | [ColorScheme.secondary] |
  /// | Disabled | `Colors.grey.shade400`            | `Colors.grey.shade800`            |
  final MaterialStateProperty<Color?>? thumbColor;

  /// {@template flutter.material.switch.trackColor}
  /// The color of this [Switch]'s track.
  ///
  /// Resolved in the following states:
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// {@tool snippet}
  /// This example resolves the [trackColor] based on the current
  /// [MaterialState] of the [Switch], providing a different [Color] when it is
  /// [MaterialState.disabled].
  ///
  /// ```dart
  /// Switch(
  ///   value: true,
  ///   onChanged: (bool value) { },
  ///   thumbColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
  ///     if (states.contains(MaterialState.disabled)) {
  ///       return Colors.orange.withOpacity(.48);
  ///     }
  ///     return Colors.orange;
  ///   }),
  /// )
  /// ```
  /// {@end-tool}
  /// {@endtemplate}
  ///
  /// If null, then the value of [activeTrackColor] is used in the selected
  /// state and [inactiveTrackColor] in the default state. If that is also null,
  /// then the value of [SwitchThemeData.trackColor] is used. If that is also
  /// null, then the following colors are used:
  ///
  /// | State    | Light theme                     | Dark theme                      |
  /// |----------|---------------------------------|---------------------------------|
  /// | Default  | `Color(0x52000000)`             | `Colors.white30`                |
  /// | Selected | [activeColor] with alpha `0x80` | [activeColor] with alpha `0x80` |
  /// | Disabled | `Colors.black12`                | `Colors.white10`                |
  final MaterialStateProperty<Color?>? trackColor;

  /// {@template flutter.material.switch.trackOutlineColor}
  /// The outline color of this [Switch]'s track.
  ///
  /// Resolved in the following states:
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// {@tool snippet}
  /// This example resolves the [trackOutlineColor] based on the current
  /// [MaterialState] of the [Switch], providing a different [Color] when it is
  /// [MaterialState.disabled].
  ///
  /// ```dart
  /// Switch(
  ///   value: true,
  ///   onChanged: (bool value) { },
  ///   trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
  ///     if (states.contains(MaterialState.disabled)) {
  ///       return Colors.orange.withOpacity(.48);
  ///     }
  ///     return null; // Use the default color.
  ///   }),
  /// )
  /// ```
  /// {@end-tool}
  /// {@endtemplate}
  ///
  /// In Material 3, the outline color defaults to transparent in the selected
  /// state and [ColorScheme.outline] in the unselected state. In Material 2,
  /// the [Switch] track has no outline by default.
  final MaterialStateProperty<Color?>? trackOutlineColor;

  /// {@template flutter.material.switch.trackOutlineWidth}
  /// The outline width of this [Switch]'s track.
  ///
  /// Resolved in the following states:
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// {@tool snippet}
  /// This example resolves the [trackOutlineWidth] based on the current
  /// [MaterialState] of the [Switch], providing a different outline width when it is
  /// [MaterialState.disabled].
  ///
  /// ```dart
  /// Switch(
  ///   value: true,
  ///   onChanged: (bool value) { },
  ///   trackOutlineWidth: MaterialStateProperty.resolveWith<double?>((Set<MaterialState> states) {
  ///     if (states.contains(MaterialState.disabled)) {
  ///       return 5.0;
  ///     }
  ///     return null; // Use the default width.
  ///   }),
  /// )
  /// ```
  /// {@end-tool}
  /// {@endtemplate}
  ///
  /// Defaults to 2.0.
  final MaterialStateProperty<double?>? trackOutlineWidth;

  /// {@template flutter.material.switch.thumbIcon}
  /// The icon to use on the thumb of this switch
  ///
  /// Resolved in the following states:
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// {@tool snippet}
  /// This example resolves the [thumbIcon] based on the current
  /// [MaterialState] of the [Switch], providing a different [Icon] when it is
  /// [MaterialState.disabled].
  ///
  /// ```dart
  /// Switch(
  ///   value: true,
  ///   onChanged: (bool value) { },
  ///   thumbIcon: MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
  ///     if (states.contains(MaterialState.disabled)) {
  ///       return const Icon(Icons.close);
  ///     }
  ///     return null; // All other states will use the default thumbIcon.
  ///   }),
  /// )
  /// ```
  /// {@end-tool}
  /// {@endtemplate}
  ///
  /// If null, then the value of [SwitchThemeData.thumbIcon] is used. If this is also null,
  /// then the [Switch] does not have any icons on the thumb.
  final MaterialStateProperty<Icon?>? thumbIcon;

  /// {@template flutter.material.switch.materialTapTargetSize}
  /// Configures the minimum size of the tap target.
  /// {@endtemplate}
  ///
  /// If null, then the value of [SwitchThemeData.materialTapTargetSize] is
  /// used. If that is also null, then the value of
  /// [ThemeData.materialTapTargetSize] is used.
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// {@macro flutter.cupertino.CupertinoSwitch.applyTheme}
  final bool? applyCupertinoTheme;

  /// {@macro flutter.cupertino.CupertinoSwitch.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@template flutter.material.switch.mouseCursor}
  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  /// {@endtemplate}
  ///
  /// If null, then the value of [SwitchThemeData.mouseCursor] is used. If that
  /// is also null, then [MaterialStateMouseCursor.clickable] is used.
  ///
  /// See also:
  ///
  ///  * [MaterialStateMouseCursor], a [MouseCursor] that implements
  ///    `MaterialStateProperty` which is used in APIs that need to accept
  ///    either a [MouseCursor] or a [MaterialStateProperty<MouseCursor>].
  final MouseCursor? mouseCursor;

  /// The color for the button's [Material] when it has the input focus.
  ///
  /// If [overlayColor] returns a non-null color in the [MaterialState.focused]
  /// state, it will be used instead.
  ///
  /// If null, then the value of [SwitchThemeData.overlayColor] is used in the
  /// focused state. If that is also null, then the value of
  /// [ThemeData.focusColor] is used.
  final Color? focusColor;

  /// The color for the button's [Material] when a pointer is hovering over it.
  ///
  /// If [overlayColor] returns a non-null color in the [MaterialState.hovered]
  /// state, it will be used instead.
  ///
  /// If null, then the value of [SwitchThemeData.overlayColor] is used in the
  /// hovered state. If that is also null, then the value of
  /// [ThemeData.hoverColor] is used.
  final Color? hoverColor;

  /// {@template flutter.material.switch.overlayColor}
  /// The color for the switch's [Material].
  ///
  /// Resolves in the following states:
  ///  * [MaterialState.pressed].
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  /// {@endtemplate}
  ///
  /// If null, then the value of [activeColor] with alpha
  /// [kRadialReactionAlpha], [focusColor] and [hoverColor] is used in the
  /// pressed, focused and hovered state. If that is also null,
  /// the value of [SwitchThemeData.overlayColor] is used. If that is
  /// also null, then the value of [ColorScheme.secondary] with alpha
  /// [kRadialReactionAlpha], [ThemeData.focusColor] and [ThemeData.hoverColor]
  /// is used in the pressed, focused and hovered state.
  final MaterialStateProperty<Color?>? overlayColor;

  /// {@template flutter.material.switch.splashRadius}
  /// The splash radius of the circular [Material] ink response.
  /// {@endtemplate}
  ///
  /// If null, then the value of [SwitchThemeData.splashRadius] is used. If that
  /// is also null, then [kRadialReactionRadius] is used.
  final double? splashRadius;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.material.inkwell.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  const AdaptiveSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.materialTapTargetSize,
    this.thumbColor,
    this.trackColor,
    this.trackOutlineColor,
    this.trackOutlineWidth,
    this.thumbIcon,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.applyCupertinoTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
      activeTrackColor: activeTrackColor,
      inactiveThumbColor: inactiveThumbColor,
      inactiveTrackColor: inactiveTrackColor,
      activeThumbImage: activeThumbImage,
      onActiveThumbImageError: onActiveThumbImageError,
      inactiveThumbImage: inactiveThumbImage,
      onInactiveThumbImageError: onInactiveThumbImageError,
      materialTapTargetSize: materialTapTargetSize,
      thumbColor: thumbColor,
      trackColor: trackColor,
      trackOutlineColor: trackOutlineColor,
      trackOutlineWidth: trackOutlineWidth,
      thumbIcon: thumbIcon,
      dragStartBehavior: dragStartBehavior,
      mouseCursor: mouseCursor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      overlayColor: overlayColor,
      splashRadius: splashRadius,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
      applyCupertinoTheme: applyCupertinoTheme,
    );
  }
}
