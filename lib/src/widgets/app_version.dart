import 'package:flutter/material.dart';
import 'package:playx_widget/playx_widget.dart';

/// Widget to display current App Version.
///
/// The version is read through [AppInfoNotifier], so it is loaded once and
/// shared across the app.
class AppVersion extends StatefulWidget {
  /// Version text style.
  final TextStyle? textStyle;

  /// text to be added before app version.
  final String prefix;

  /// text to be added after app version.
  final String postfix;

  /// Show version code
  final bool showVersionCode;

  /// Version code separator
  final String versionCodeSeparator;

  /// Version Text alignment
  final TextAlign textAlign;

  /// Version Text font weight
  final FontWeight? fontWeight;

  /// Version Text font family
  final String? fontFamily;

  final double? fontSize;

  /// Version text color. Defaults to the ambient text color (or white when
  /// [showStroke] is true).
  final Color? color;

  /// Draws an outline around the text (useful over images).
  final bool showStroke;

  /// Outline color when [showStroke] is true.
  final Color strokeColor;

  /// Notifier to read the version from. Defaults to
  /// [AppInfoNotifier.instance].
  final AppInfoNotifier? notifier;

  const AppVersion({
    super.key,
    this.textStyle,
    this.prefix = 'V',
    this.postfix = '',
    this.showVersionCode = false,
    this.versionCodeSeparator = '+',
    this.textAlign = TextAlign.center,
    this.fontWeight,
    this.fontFamily,
    this.fontSize,
    this.color,
    this.showStroke = false,
    this.strokeColor = Colors.black,
    this.notifier,
  });

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  AppInfoNotifier get _notifier => widget.notifier ?? AppInfoNotifier.instance;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(AppVersion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.notifier != widget.notifier) _load();
  }

  void _load() {
    // Errors leave the text empty; the notifier allows retrying later.
    _notifier.load().then((_) {}, onError: (_) {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppInfo?>(
      valueListenable: _notifier,
      builder: (context, info, _) {
        final text =
            info?.format(
              prefix: widget.prefix,
              postfix: widget.postfix,
              showVersionCode: widget.showVersionCode,
              versionCodeSeparator: widget.versionCodeSeparator,
            ) ??
            '';
        final style =
            widget.textStyle ??
            TextStyle(
              fontSize: widget.fontSize ?? 12.sp,
              fontWeight: widget.fontWeight,
              fontFamily: widget.fontFamily,
            );
        if (widget.showStroke) {
          return StrokeText(
            text: text,
            strokeColor: widget.strokeColor,
            textStyle: style.copyWith(color: widget.color ?? Colors.white),
            textAlign: widget.textAlign,
          );
        }
        return Text(
          text,
          style: widget.color == null
              ? style
              : style.copyWith(color: widget.color),
          textAlign: widget.textAlign,
        );
      },
    );
  }
}
