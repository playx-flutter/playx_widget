import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Immutable snapshot of the app's version information.
@immutable
class AppVersionInfo {
  /// Version name, e.g. `1.2.3`.
  final String version;

  /// Build number / version code, e.g. `42`.
  final String buildNumber;

  const AppVersionInfo({required this.version, required this.buildNumber});

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
      other is AppVersionInfo &&
      other.version == version &&
      other.buildNumber == buildNumber;

  @override
  int get hashCode => Object.hash(version, buildNumber);

  @override
  String toString() => 'AppVersionInfo($version+$buildNumber)';
}

/// A shared, lazily loaded holder of the app version that can be listened to
/// from anywhere in the app.
///
/// ```dart
/// await AppVersionNotifier.instance.load(); // e.g. in main()
/// final version = AppVersionNotifier.instance.value?.version;
///
/// ValueListenableBuilder(
///   valueListenable: AppVersionNotifier.instance,
///   builder: (context, info, _) => Text(info?.format() ?? ''),
/// );
/// ```
///
/// [PackageInfo] is read once and cached; later [load] calls return the cached
/// value unless `force` is true. Listeners are notified only when the version
/// actually changes.
class AppVersionNotifier extends ValueNotifier<AppVersionInfo?> {
  AppVersionNotifier() : super(null);

  /// Shared instance used by `AppVersion` and recommended for app-wide use.
  static final AppVersionNotifier instance = AppVersionNotifier();

  Future<AppVersionInfo>? _loading;

  /// Whether the version has been loaded.
  bool get isLoaded => value != null;

  /// Loads the version (once) and returns it.
  Future<AppVersionInfo> load({bool force = false}) {
    final current = value;
    if (!force && current != null) return Future.value(current);
    if (force) _loading = null;
    return _loading ??= _fetch();
  }

  Future<AppVersionInfo> _fetch() async {
    try {
      final info = await PackageInfo.fromPlatform();
      final result = AppVersionInfo(
        version: info.version,
        buildNumber: info.buildNumber,
      );
      value = result; // ValueNotifier skips notifying when equal.
      return result;
    } catch (_) {
      _loading = null; // allow retry after a failure
      rethrow;
    }
  }
}
