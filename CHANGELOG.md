# Changelog

### 0.6.0
- **Breaking:** Update Flutter environment requirement to `>=3.44.0`.
- **Breaking:** Update `cached_network_image` to `^4.0.6` and `cached_network_image_platform_interface` to `^5.0.3` (now depend on `material_ui`).
- **Breaking:** Update `lucide_icons_flutter` to `^4.0.2`. Weighted icons moved to separate libraries (e.g. `LucideIcons.activity300` is now `LucideIcons300.activity`, imported from `package:lucide_icons_flutter/lucide_icons_300.dart`). Regular icons are unchanged.
- Update `package_info_plus` to `^10.2.2` (requires iOS 13 / macOS 10.15 and Dart 3.11+).
- Add `AppInfoNotifier` (`ValueNotifier<AppInfo?>` with a shared `instance`) exposing app name, package name, version, build number, build signature and installer store, loaded once and shareable across the app. `AppVersion` now uses it, so `PackageInfo` is read once instead of on every rebuild.
- Add `color`, `showStroke` and `strokeColor` to `AppVersion`.
- Fix `AppVersion` ignoring `textAlign`.
- Fix `FavoriteButton` not updating when `isInFavorite` changes from the parent; `onFavoriteChanged` is now a `ValueChanged<bool>`.
- `ReadMoreText` now trims at word boundaries, never splits emoji, appends a configurable `ellipsis`, and uses `Text.rich`.
- Add widget tests.
- Fix `ImageViewer.network` never showing the loaded image and `ImageViewer.icon` rendering nothing. Export `IconInfo`; `IconInfo.copyWith` keeps `assetIcon`.
- Web: `ImageViewer.file` loads picked paths as URLs on web, add `ImageViewer.filePath(String)` that works on every platform, network images fall back to an HTML element (`webHtmlElementStrategy`), SVG constructors accept `errorBuilder`.
- `showConfirmDialog` closes on confirm and returns `true`; `onConfirmed` and `lottie` are optional.
- `DateTimePicker`: Cupertino pickers return the picked value, clamp `initialDate`, respect `initialTime`, support `label`/`use24hFormat`; add `pickDateRange` and `endOfToday`. Cancelling the time step of `pickDateTime` now returns `null`.
- Fix dashed lines disappearing on repaint / hanging in unbounded parents, `AnimatedVisibility` fade-in, `AutoAnimatedList` diffing and duplicate items, `OptimizedTextField` timers and form key, `AnimSearchBar` disposal and animation state, `OptimizedCard` ripple, `Marquee` idle spinning.
- Keep `wolt_modal_sheet` at `^0.11.0`, as 0.12.0 migrates to `material_ui`.

### 0.5.0
- Add `lucide_icons_flutter` package.
- Update `flutter_platform_widgets` to `^10.0.1` and `font_awesome_flutter` to `^11.0.0`.
- Update `flutter_svg` and `cupertino_icons` dependencies.
- Update Flutter environment requirement to `>=3.38.0`.
- Remove `cupertino_icons` export from `playx_widget.dart`.


### 0.4.0
- Add `MultiValueListenableBuilder` to rebuild a widget from multiple `ValueListenable`s.
- Add `BlurBox` widget for applying a blur effect to its child with animation.
- Add `CustomInkWell` widget for a standardized ink well effect.
- Add `StrokeText` widget to render text with an outline.
- Add `Box` and `SliverSizedBox` for creating spaced boxes with predefined sizes.
- Add `SpacingExtensions` on `num` for creating `SizedBox` and `SliverSizedBox` easily.
- Update `package_info_plus`, `flutter_svg`, `lottie`, and `font_awesome_flutter` dependencies.

### 0.3.0
- Update packages.
- (Flutter version support: v3.32.0)
  Adds all the flutter 3.32 additional properties for platform widgets

## 0.2.2

- Update packages.
- Update `ReadMoreText` to not be clickable when trimCharsCount is less than the text length.

## 0.2.1

- Update packages.

## 0.2.0

### New Features

#### OptimizedTextField

- **`enableSuggestions`**: Added to toggle text suggestions in the text field.
- **`autocorrect`**: Added to enable or disable autocorrection.
- **`autoValidateMode`**: Added to specify the auto-validation mode (e.g., on user input or form
  submission).
- **`debounceDuration`**: Added to support debouncing for text field input and validation.
- **`debounceValidation`**: Added to enable debouncing for validation, improving performance.

#### ImageViewer

- **`imageRenderMethodForWeb`**: Added to the `ImageViewer.cachedNetwork` method to specify
  rendering options for images on the web platform.

### Updates

- **Utility Methods**: Moved the following methods under the new `CommonImageUtils` class:
  - `getImageFromSvgAsset`
  - `getImageFromWidget`

- **WebAssembly (WASM) Support**: Added support for WebAssembly (WASM) in the package allowing the
  package to compile to `WASM` in web.

- **PlayxWidget**: Exported `OrientationWidget` for enhanced usability in responsive designs.

- **Dependency Replacement**: Replaced **flutter_keyboard_visibility** by *
  *flutter_keyboard_visibility_temp_fork** to address the following issues:
  - Use the Flutter default `compileSdkVersion` as a workaround for a bug in Flutter (#63533),
    allowing targeting of the latest `compileSdkVersion`.
  - Added support for Flutter/WASM. Previous implementations using `dart:html` or `package:js`
    prevented compilation for the WebAssembly (WASM) target.

- **Dependency Upgrade**: Upgraded `archive` dependency to version `^3.6.1`, which is used in the
  `lottie` package.

## 0.1.9

- Update packages.
- feat: Add date time picker utility class to show date/time picker based on platform.
- refactor: Update app version widget to allow showing version code.

## 0.1.8

- Update packages.
- export `cupertino_icons` and `font_awesome_flutter` icon packages.

## 0.1.7

- Update `ImageViewer.cachedNetwork` to accept `errorBuilder` parameter.

## 0.1.6

- Updated packages.
- Add new `IconInfo` class and new `ImageViewer.icon` method to create an image viewer with an icon.

## 0.1.5

- Updated packages.

#### 0.1.4

- Updated packages.
- fix breaking change with `getImageFromWidget` function.

## 0.1.3

- Update packages.
- Add new `flutter_keyboard_visibility`, `sliver_tools`, `dotted_border` and `wolt_modal_sheet`
  packages.
- Add new `SvgProvider` class to provide svg images.
- Rename `DashedVerticalLine` widget to `VerticalDashedLine`.
- Enhance `DashedLine` and `VerticalDashedLine` to work better in scrolling list.

## 0.1.2

- update packages

## 0.1.1

- update packages
- Update to flutter 3.16.0
- Bump minimum Dart version to 3.2.0
- Add `DashedVerticalLine` widget : Creates a dashed vertical line widget.
- Add `strokeWidth` to `CenterLoading` widget to customize the stroke width of the material loading
  indicator.

## 0.1.0-beta.5

- fix: bug causing `isCupertino` not working correctly on web.

## 0.1.0-beta.4

- Upgrade Packages.
- Add `AdaptiveLayout` : Widget which can be used to create adaptive layout for mobile and tablet
  devices.
- Add `OrientationWidget` : Widget that can be used to build different widgets for different
  orientations.
- Add onSubmitted callback to `OptimizedTextField` widget.

## 0.1.0-beta.3

### New Widgets

#### DashedLine

- Creates a dashed line widget.

#### FadeIndexedStack

- Creates an indexed Stack widget that paints a single child with fade animation.

#### FavoriteButton

- Creates a button that shows favorite state.

### Bug fixes and Enhancements

#### OptimizedCard

- Update OptimizedCard default shadowColor to not be transparent on Ios.
- Add the onPressed callback for the card to listen to any tapping events.
- Add borderRadius which can be used to set the border radius of the default card's rounded
  rectangular shape.

#### OptimizedTextField

- Add hintStyle to the text field to customize the hint text style.
- Enhancement to the text field in Ios when using `.adaptive` constructor.

## 0.1.0-beta.2

- Upgrade Packages.
- Add .adaptive constructor that creates a platform specific widget for centerLoading and
  optimizedTextField widgets.
- Enahncement to other widgets and remove OptimizedButton widget.

## 0.1.0-beta.1

- include `flutter_platform_widgets` into the package to include platform specific widgets.
- fix errorMaxLines on `OptimizedTextField` not working correctly.

## 0.0.8

- Upgrade Packages.
- Enhancements to `IconViewer` and `ImageViewer` widgets.

## 0.0.7

- Upgrade Packages.
- add `Marquee` widget :Marquee widget to make any widget scroll horizontally automatically.
- add `AnimSearchBar` widget :Widget that allows displaying a search bar with nice animation when
  expanded/ collapsed state.
- add `ReadMore` widget :Widget that allows Expanding and collapsing text based on it's characters
  count.
- add `scrollPadding` and `autoFillHints` to `OptimizedTextField` widget.

## 0.0.6

- Upgrade Packages.
- integrate `flutter_screenutil` package into the package to make widgets more responsive.
- Add new widget `OptimizedListTile` which is a widget that is enhanced version of list tile that
  can display a card with title, subtitle, leading and trailing widgets.
- update `OptimizedCard` to enhance card shadows.
- add `radius` to `CenterLoading` widget.

## 0.0.5

- Upgrade Packages.
- Add new widgets `AnimatedVisibility`, `OptimizedButton`, `OptimizedTextField`
  , `TimerRefreshWidget` .
- Add new Confirmation dialog that can be used to confirm any operation.
- update `OptimizedCard` to enhance card shadows.

## 0.0.4

- Upgrade Packages.

## 0.0.3

- Upgrade Packages.
- Update Exports to easy import widgets.
- Add common utilities like `getUnit8ListFromSvgAsset` which covert svg asset to Unit8List.

## 0.0.2

- Add support for Dart 3.0.0
- Upgrade Packages.
- Add `AutoAnimatedList` : Widget that automatically animates list of items when inserting or
  deleting any item.
- Add `OptimizedCard` : Widget which provides better shadow effect for the card to look more like
  native card.
- Add lottie package.

## 0.0.1
- initial release
