import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Immutable snapshot of the app's information (from `PackageInfo`).
@immutable
class AppInfo {
  /// App name, e.g. `My App`.
  final String appName;

  /// Package name / bundle id, e.g. `com.example.app`.
  final String packageName;

  /// Version name, e.g. `1.2.3`.
  final String version;

  /// Build number / version code, e.g. `42`.
  final String buildNumber;

  /// Build signature (Android only, empty elsewhere).
  final String buildSignature;

  /// Store the app was installed from, when known (Android / iOS).
  final String? installerStore;

  const AppInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
    this.buildSignature = '',
    this.installerStore,
  });

  /// Formats the version, e.g. `V1.2.3+42`.
  String format({
    String prefix = 'V',
    String postfix = '',
    bool showVersionCode = false,
    String versionCodeSeparator = '+',
  }) {
    if (showVersionCode) {
      return '$prefix$version$versionCodeSeparator$buildNumber$postfix';
    }
    return '$prefix$version$postfix';
  }

  @override
  bool operator ==(Object other) =>
      other is AppInfo &&
      other.appName == appName &&
      other.packageName == packageName &&
      other.version == version &&
      other.buildNumber == buildNumber &&
      other.buildSignature == buildSignature &&
      other.installerStore == installerStore;

  @override
  int get hashCode => Object.hash(
    appName,
    packageName,
    version,
    buildNumber,
    buildSignature,
    installerStore,
  );

  @override
  String toString() => 'AppInfo($packageName $version+$buildNumber)';
}

/// A shared, lazily loaded holder of the app info (name, package name,
/// version, ...) that can be listened to from anywhere in the app.
///
/// ```dart
/// await AppInfoNotifier.instance.load(); // e.g. in main()
/// final info = AppInfoNotifier.instance.value; // info?.packageName, ...
///
/// ValueListenableBuilder(
///   valueListenable: AppInfoNotifier.instance,
///   builder: (context, info, _) => Text(info?.format() ?? ''),
/// );
/// ```
///
/// [PackageInfo] is read once and cached; later [load] calls return the cached
/// value unless `force` is true. Listeners are notified only when the version
/// actually changes.
class AppInfoNotifier extends ValueNotifier<AppInfo?> {
  AppInfoNotifier() : super(null);

  /// Shared instance used by `AppVersion` and recommended for app-wide use.
  static final AppInfoNotifier instance = AppInfoNotifier();

  Future<AppInfo>? _loading;

  /// Whether the version has been loaded.
  bool get isLoaded => value != null;

  /// Loads the version (once) and returns it.
  Future<AppInfo> load({bool force = false}) {
    final current = value;
    if (!force && current != null) return Future.value(current);
    if (force) _loading = null;
    return _loading ??= _fetch();
  }

  Future<AppInfo> _fetch() async {
    try {
      final info = await PackageInfo.fromPlatform();
      final result = AppInfo(
        appName: info.appName,
        packageName: info.packageName,
        version: info.version,
        buildNumber: info.buildNumber,
        buildSignature: info.buildSignature,
        installerStore: info.installerStore,
      );
      value = result; // ValueNotifier skips notifying when equal.
      return result;
    } catch (_) {
      _loading = null; // allow retry after a failure
      rethrow;
    }
  }
}
