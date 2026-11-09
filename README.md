# PlayX Widget

[![pub package](https://img.shields.io/pub/v/playx_widget.svg)](https://pub.dev/packages/playx_widget)
[![CI](https://github.com/playx-flutter/playx_widget/actions/workflows/ci.yml/badge.svg)](https://github.com/playx-flutter/playx_widget/actions/workflows/ci.yml)
[![API docs](https://img.shields.io/badge/docs-API%20reference-blue)](https://playx-flutter.github.io/playx_widget/)

Utility widgets for the PlayX ecosystem that make everyday Flutter development faster.

- **Documentation:** <https://playx-flutter.github.io/playx_widget/>
- **Guides:** [Getting started](docs/getting-started.md) · [Widgets](docs/widgets.md) · [App info](docs/app-info.md) · [Known issues](docs/known-issues.md) · [Contributing](CONTRIBUTING.md)
- **Changelog:** [CHANGELOG.md](CHANGELOG.md)

## Requirements

| | |
|---|---|
| Flutter | `>=3.44.0` |
| Dart | `>=3.8.0 <4.0.0` |

## Installation

```yaml
dependencies:
  playx_widget: ^0.6.0
```

```dart
import 'package:playx_widget/playx_widget.dart';
```

Many widgets use `flutter_screenutil` for sizing, so wrap your app once:

```dart
ScreenUtilInit(
  designSize: const Size(360, 690),
  minTextAdapt: true,
  builder: (context, child) => MaterialApp(home: const HomePage()),
);
```

## Quick example

```dart
// Load the app info once (e.g. in main) and use it anywhere.
await AppInfoNotifier.instance.load();

const AppVersion(prefix: 'v', showVersionCode: true);

ReadMoreText(
  longText,
  trimCharsCount: 120,
  readMoreCollapsedText: 'Read more',
  readMoreExpandedText: ' Show less',
);

FavoriteButton(
  isInFavorite: item.isFavorite,
  onFavoriteChanged: (value) => save(value),
);
```

## Widgets

See [docs/widgets.md](docs/widgets.md) for the full list with descriptions. Highlights:

| Widget | Purpose |
|---|---|
| `AppVersion` / `AppInfoNotifier` | Show or listen to app name, package name, version and build number |
| `ImageViewer`, `IconViewer` | Show assets, network, cached or SVG images / icons from one API |
| `OptimizedTextField`, `AnimSearchBar` | Validated text field and animated search bar |
| `OptimizedCard`, `OptimizedListTile` | Cards and list tiles with better shadows |
| `AutoAnimatedList`, `FadeIndexedStack`, `AnimatedVisibility` | Animated lists, stacks and visibility |
| `ReadMoreText`, `StrokeText`, `Marquee` | Text helpers |
| `BlurBox`, `DashedLine`, `Box`, `SliverSizedBox` | Layout and decoration helpers |
| `AdaptiveWidget`, `OrientationWidget` | Screen-size and orientation based UI |
| `showConfirmDialog`, `DateTimePicker` | Platform-adaptive dialogs and pickers |

## Re-exported packages

`playx_widget` re-exports `cached_network_image`, `dotted_border`, `flutter_keyboard_visibility_temp_fork`,
`flutter_platform_widgets`, `flutter_screenutil`, `flutter_svg`, `flutter_svg_provider`, `font_awesome_flutter`,
`lottie`, `lucide_icons_flutter`, `package_info_plus`, `sliver_tools` and `wolt_modal_sheet`,
so one import is enough.

> `wolt_modal_sheet` is pinned to `0.11.x`. Version 0.12 migrates to `material_ui` and changes
> `WoltModalSheetThemeData`. See the [changelog](CHANGELOG.md).

## Example

A runnable app lives in [example/](example/).

```sh
cd example && flutter run
```

## PlayX

Consider the [Playx package](https://pub.dev/packages/playx), which bundles this package and more.

## See also

- [playx](https://pub.dev/packages/playx): the PlayX ecosystem umbrella package.
- [playx_theme](https://pub.dev/packages/playx_theme): multi-theme support.
- [playx_core](https://pub.dev/packages/playx_core): shared classes and utilities.

## License

See [LICENSE](LICENSE).
