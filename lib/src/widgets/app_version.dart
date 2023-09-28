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

  const AppVersion(
      {super.key, this.textStyle, this.prefix = 'V', this.postfix = ''});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVersionName(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        final versionName = snapshot.data ?? '';
        return Text(
          versionName,
          style: textStyle ?? TextStyle(fontSize: 12.sp),
          textAlign: TextAlign.center,
        );
      },
    );
  }

  Future<String> getVersionName() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String version = packageInfo.version;
    return "$prefix$version$postfix";
  }
}
