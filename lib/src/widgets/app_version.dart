import 'package:flutter/widgets.dart';
import 'package:playx_widget/playx_widget.dart';

/// Widget to display current App Version.
class AppVersion extends StatelessWidget {
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

  /// Version Text color
  final FontWeight? fontWeight;

  /// Version Text font family
  final String? fontFamily;

  const AppVersion(
      {super.key,
      this.textStyle,
      this.prefix = 'V',
      this.postfix = '',
      this.showVersionCode = false,
      this.versionCodeSeparator = '+',
      this.textAlign = TextAlign.center,
      this.fontWeight,
      this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVersionName(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        final versionName = snapshot.data ?? '';
        return Text(
          versionName,
          style: textStyle ??
              TextStyle(
                  fontSize: 12.sp,
                  fontWeight: fontWeight,
                  fontFamily: fontFamily),
          textAlign: TextAlign.center,
        );
      },
    );
  }

  Future<String> getVersionName() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String version = packageInfo.version;
    final String buildNumber = packageInfo.buildNumber;
    if (showVersionCode) {
      return "$prefix$version$versionCodeSeparator$buildNumber$postfix";
    }
    return "$prefix$version$postfix";
  }
}
