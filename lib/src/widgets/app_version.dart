import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Widget to display current App Version.
class AppVersion extends StatelessWidget {
  /// Version text style.
  final TextStyle textStyle;

  /// text to be added before app version.
  final String prefix;

  /// text to be added after app version.
  final String postfix;

  const AppVersion(
      {super.key,
      this.textStyle = const TextStyle(),
      this.prefix = 'V',
      this.postfix = ''});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVersionName(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        final versionName = snapshot.data ?? '';
        return Text(
          versionName,
          style: textStyle,
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
