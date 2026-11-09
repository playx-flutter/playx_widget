# Widgets

Full API reference: <https://playx-flutter.github.io/playx_widget/>

## Display

- `AppVersion`: shows the app version (see [App info](app-info.md)).
- `ImageViewer`: images from assets, network, cached network or SVG.
- `IconViewer`: an icon from `IconData`, SVG, image or text.
- `StrokeText`: text with an outline.
- `ReadMoreText`: expands/collapses text past a character count; trims at word boundaries.
- `Marquee`: scrolls any widget horizontally.
- `CenterLoading`: centered loading indicator (`material`, `cupertino` or `adaptive`).

## Input

- `OptimizedTextField`: text field with auto validation and focus chaining.
- `AnimSearchBar`: search bar that animates between collapsed and expanded.
- `FavoriteButton`: animated favorite toggle; follows the parent's `isInFavorite`.
- `CustomInkWell`: standardized ink well.
- `DateTimePicker`: platform-adaptive date/time picker (`DatePickerPlatform`).
- `showConfirmDialog`: adaptive confirmation dialog.

## Layout and containers

- `OptimizedScrollView`: scroll view that fills the viewport between the last widget and the bottom.
- `OptimizedCard`, `OptimizedListTile`: cards and tiles with better shadows.
- `Box`, `SliverSizedBox`, `SpacingExtensions`: spacing helpers (`20.boxH`, `10.boxW`, `20.sliverH`).
- `BlurBox`: animated blur effect over a child.
- `DashedLine`, `VerticalDashedLine`: dashed separators.
- `KeepAliveWrapper`: keeps a child alive in lists/tabs.
- `AdaptiveWidget`: builds different widgets for small/medium/large mobile and tablets.
- `OrientationWidget`: separate builders for portrait and landscape.

## Animation and state

- `AutoAnimatedList`: animates insertions and removals.
- `FadeIndexedStack`: `IndexedStack` with fade transitions.
- `AnimatedVisibility`: fades a child and removes its space when hidden (unlike `AnimatedOpacity`).
- `TimerRefreshWidget`: rebuilds its child periodically.
- `MultiValueListenableBuilder`: rebuilds from several `ValueListenable`s.
- `AppInfoNotifier`: shared app info.
