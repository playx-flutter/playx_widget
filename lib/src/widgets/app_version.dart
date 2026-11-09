import 'package:flutter/widgets.dart';
import 'package:playx_widget/playx_widget.dart';

/// Widget to display current App Version.
///
/// The version is read through [AppVersionNotifier], so it is loaded once and
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

  /// Notifier to read the version from. Defaults to
  /// [AppVersionNotifier.instance].
  final AppVersionNotifier? notifier;

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
    this.notifier,
  });

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  AppVersionNotifier get _notifier =>
      widget.notifier ?? AppVersionNotifier.instance;

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
    return ValueListenableBuilder<AppVersionInfo?>(
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
        return Text(
          text,
          style:
              widget.textStyle ??
              TextStyle(
                fontSize: widget.fontSize ?? 12.sp,
                fontWeight: widget.fontWeight,
                fontFamily: widget.fontFamily,
              ),
          textAlign: widget.textAlign,
        );
      },
    );
  }
}
